import argparse
import pathlib

import pathlib
from typing import List, Union

class XsPreprocessor:
    def __init__(self, include_paths: List[pathlib.Path] = []):
        self.macros = {}
        self.output = []
        self.processed_files = set()
        self.conditional_stack = []
        self.include_paths = []

        # Normalize include paths
        if include_paths:
            for path in include_paths:
                self.include_paths.append(path.resolve())

    def add_include_path(self, path: Union[str, pathlib.Path]):
        """Add an additional include path to search."""
        self.include_paths.append(pathlib.Path(path).resolve())

    def _parse_identifier(self, src: str, start: int) -> (str, int):
        """Parse an identifier starting at src[start]. Returns (identifier, new_position)."""
        curr = start
        length = len(src)

        ident_start = curr
        while curr < length and (src[curr].isalnum() or src[curr] == '_' or src[curr] == '-'):
            curr += 1

        identifier = src[ident_start:curr]
        return identifier, curr

    def _skip_whitespace(self, src: str, curr: int) -> int:
        """Skip whitespace characters starting from curr position."""
        length = len(src)
        while curr < length and src[curr].isspace() and src[curr] != '\n':
            curr += 1
        return curr

    def process(self, root_script: pathlib.Path):
        """Main entry point to process a file."""
        self.output = []
        self._process_file(root_script)
        return "".join(self.output)

    def _process_file(self, file_path: pathlib.Path):
        """Process a single file."""
        # Check for include cycles
        if file_path in self.processed_files:
            raise RuntimeError(f"Circular include detected: {file_path}")
        self.processed_files.add(file_path)

        src = file_path.read_text()
        curr = 0
        length = len(src)

        while curr < length:
            # Ignore content in inactive conditional blocks.
            if self.conditional_stack and not self.conditional_stack[-1]:
                if src[curr] == '#':
                    curr += 1
                    directive_ident = self._parse_identifier(src, curr)
                    curr = directive_ident[1]
                    if directive_ident[0] == "endif":
                        self.conditional_stack.pop()
                curr = self._skip_to_newline(src, curr)
                continue

            if src[curr] == '#':
                curr = self._parse_directive(src, curr, file_path)
            elif src[curr] == '@':
                curr = self._parse_macro_expansion(src, curr)
            else:
                self.output.append(src[curr])
                curr += 1

    def _parse_directive(self, src: str, start: int, file_path: pathlib.Path) -> int:
        """Parse a preprocessor directive starting with #."""
        curr = start + 1  # Skip the '#'
        directive = self._parse_identifier(src, curr)
        curr = directive[1]

        if directive[0] == "include":
            return self._parse_include(src, curr, file_path)
        elif directive[0] == "define":
            return self._parse_define(src, curr)
        elif directive[0] == "undef":
            return self._parse_undef(src, curr)
        elif directive[0] == "ifdef":
            return self._parse_ifdef(src, curr)
        else:
            raise RuntimeError(f"Unknown preprocessor directive: #{directive[0]}")

    def _parse_define(self, src: str, curr: int) -> int:
        """Parse #define MACRO value - only stores macro, doesn't expand."""
        length = len(src)
        curr = self._skip_whitespace(src, curr)
        macro_ident = self._parse_identifier(src, curr)
        curr = macro_ident[1]
        macro_name = macro_ident[0]
        curr = self._skip_whitespace(src, curr)

        # parse optional macro value
        value_start = curr
        while curr < length and src[curr] != '\n':
            curr += 1
        macro_value = src[value_start:curr].rstrip()
        self.macros[macro_name] = macro_value

        if curr < length and src[curr] == '\n':
            curr += 1

        return curr

    def _parse_undef(self, src: str, curr: int) -> int:
        """Parse #undef MACRO - removes macro definition."""
        length = len(src)

        # Parse macro identifier
        ident_start = curr
        while curr < length and (src[curr].isalnum() or src[curr] == '_'):
            curr += 1

        if curr > ident_start:
            macro_name = src[ident_start:curr]
            # Remove macro if it exists
            if macro_name in self.macros:
                del self.macros[macro_name]

        # Skip to end of line
        return self._skip_to_newline(src, curr)

    def _parse_ifdef(self, src: str, curr: int) -> int:
        """Parse #ifdef """
        length = len(src)
        ident_start = curr
        while curr < length and (src[curr].isalnum() or src[curr] == '_'):
            curr += 1

        if curr == ident_start:
            raise RuntimeError("Expected identifier after #ifdef")

        macro_name = src[ident_start:curr]
        is_defined = macro_name in self.macros
        self.conditional_stack.append(is_defined)
        return self._skip_to_newline(src, curr)

    def _parse_include(self, src: str, curr: int, current_file: pathlib.Path) -> int:
        """Parse #include directive and process the included file."""
        length = len(src)

        # Skip whitespace
        while curr < length and src[curr].isspace():
            curr += 1

        # Check for opening quote
        if curr >= length or src[curr] != '"':
            # Invalid include syntax
            return self._skip_to_newline(src, curr)

        curr += 1  # Skip opening quote
        filename_start = curr

        # Parse filename
        while curr < length and src[curr] != '"':
            curr += 1

        if curr >= length:
            # Unterminated string
            return curr

        filename = src[filename_start:curr]
        curr += 1  # Skip closing quote

        # Skip any remaining characters on the line
        curr = self._skip_to_newline(src, curr)

        # Find and process the included file
        self._process_include_file(filename, current_file)

        return curr

    def _process_include_file(self, filename: str, current_file: pathlib.Path):
        """Find and process an included file with proper path resolution."""
        # Check if filename starts with "./" (local only)
        if filename.startswith("./"):
            # Remove "./" prefix and search only relative to current file
            local_filename = filename[2:]
            include_path = current_file.parent / local_filename

            if include_path.exists() and include_path.is_file():
                self._process_file(include_path)
                return
            else:
                raise FileNotFoundError(f"Local included file not found: {include_path}")

        # Search order for non-local includes:
        # 1. Relative to current file's directory
        local_path = current_file.parent / filename
        if local_path.exists() and local_path.is_file():
            self._process_file(local_path)
            return

        # 2. Search in additional include paths
        for include_dir in self.include_paths:
            include_path = include_dir / filename
            if include_path.exists() and include_path.is_file():
                self._process_file(include_path)
                return

        # File not found in any search location
        raise FileNotFoundError(
            f"Included file '{filename}' not found. Searched:\n"
            f"  1. {current_file.parent}\n"
            f"  2. Additional include paths: {self.include_paths}"
        )

    def _parse_macro_expansion(self, src: str, start: int) -> int:
        """Parse @macro-name@ pattern and expand if defined."""
        curr = start + 1  # Skip first '@'
        length = len(src)

        # Parse macro identifier
        ident_start = curr
        while curr < length and (src[curr].isalnum() or src[curr] == '_' or src[curr] == '-'):
            curr += 1

        # Check if we have closing '@'
        if curr >= length or src[curr] != '@':
            # Not a macro expansion pattern, output the original '@'
            self.output.append('@')
            return start + 1

        macro_name = src[ident_start:curr]
        curr += 1  # Skip closing '@'

        # Expand macro if defined
        if macro_name in self.macros:
            self.output.append(self.macros[macro_name])
        else:
            # Macro not defined - output the original pattern
            self.output.append(f"@{macro_name}@")

        return curr

    def _skip_to_newline(self, src: str, curr: int) -> int:
        """Skip to the end of the current line."""
        length = len(src)
        while curr < length and src[curr] != '\n':
            curr += 1

        # Skip the newline itself
        if curr < length and src[curr] == '\n':
            curr += 1

        return curr

def main():
    parser = argparse.ArgumentParser(
           prog="xsmake",
           description='AoE2DE XS Script Preprocessor'
           )
    parser.add_argument('script')
    parser.add_argument('--paths','-p',nargs='+',help='Additional include paths')
    parser.add_argument('--out','-o')
    parser.add_argument('--version', action='version', version='%(prog)s 0.0')

    args = parser.parse_args()



    # Validate input script
    script = pathlib.Path(args.script)
    if not script.exists():
        print("\033[91mInput script file '" + str(script) + "' does not exist")
        return 1
    if not script.is_file():
        print("\033[91Input script path '" + str(script) + "' is not a valid file path")
        return 1

    # Validate additional include paths
    if args.paths:
        for p in args.paths:
            path = pathlib.Path(p)
            if not path.exists():
                print("\033[91mAdditional include path '" + str(path) + "' does not exist")
                return 1
            if not path.is_dir():
                print("\033[91Additional include path '" + str(path) + "' is not a valid directory path")
                return 1

    # Validate output file path
    if not args.out:
        print("\033[91mOutput out_script path is required")
        return 1
    out_script = pathlib.Path(args.out)
    #if not out_script.is_file():
    #    print("\033[91mOutput out_script path '" + str(out_script) + "' is not a valid file path")
    #    return 1
    if not out_script.suffix == '.xs':
        print("\033[91mOutput out_script extension must be '.xs' for the scenario editor to detect it.")
        return 1

    print('Processing input script: ' + args.script)
    print('Additional include paths:',args.paths)
    print('Output script: ' + args.out)
    preprocessor = XsPreprocessor()
    result = preprocessor.process(script)
    print(result)

if __name__ == "__main__":
    main()
