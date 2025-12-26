import argparse
import pathlib
from pathlib import Path
from typing import List, Union

ADEX_SCRIPT_DIR = Path(__file__).resolve().parent
ADEX_LIBRARY_DIR = ADEX_SCRIPT_DIR / "xs"

ADEX_KW_DEFINE = "define"
ADEX_KW_INCLUDE = "include"
ADEX_KW_IFDEF = "ifdef"
ADEX_KW_ENDIF = "endif"

ADEX_EXIT_FAIL = 1
ADEX_EXIT_SUCCESS = 0

def print_error(msg : str) -> int :
    """ Prints red error message and returns 'ADEX_EXIT_FAIL'(1) """
    print("\033[91m[Error]" + msg)
    return ADEX_EXIT_FAIL

def print_warning(msg : str) -> int :
    """ Prints red warning message and returns 'ADEX_EXIT_SUCCESS'(0) """
    print("\033[91m[Warning]" + msg)
    return ADEX_EXIT_SUCCESS

class AdexCli :
  def __init__(self):
    # Setup command line parser
    self.parser = argparse.ArgumentParser(
      prog="adex",
      description='AoE2DE XS Script Preprocessor'
    )
    self.parser.add_argument('script')
    self.parser.add_argument("--no-libs",help= "Don't implicitly include ADEX XS library paths.")
    self.parser.add_argument('--paths','-p',nargs='+',help='Additional include paths')
    self.parser.add_argument('--out','-o')
    self.parser.add_argument('--version','-v', action='version', version='%(prog)s 0.0')

  def _validate_cli_args(self, args) -> int:
    """ Validates parsed 'self.args', returns ADEX_EXIT_FAIL on error, ADEX_EXIT_SUCCESS on pass"""

    # Validate input script
    script = Path(args.script)
    if not script.exists():
        return self._print_error("Input script file '" + args.script + "' does not exist.")
    if not script.is_file():
        return self._print_error("Input script path '" + args.script + "' is not a file.")
    # Validate additional include paths
    if args.paths:
        for p in args.paths:
            path = pathlib.Path(p)
            if not path.exists():
                return self._print_error("Additional include path '" + p + "' does not exist.")
            if not path.is_dir():
                return self._print_error("Additional include path '" + p + "' is not a valid directory path.")

    # Validate output file path
    if not args.out:
        return self._print_error("Output script path is required. Use '--out' or '-o'.")
    out_script = pathlib.Path(args.out)
    if not out_script.suffix == '.xs':
        return self._print_error("Output script file extension must be '.xs' for the scenario editor to detect it.")
    # Check if out script is a valid file path ???
    #

    return ADEX_EXIT_SUCCESS

  def run(self) -> int:
    args = self.parser.parse_args()
    if self._validate_cli_args(args) == ADEX_EXIT_FAIL:
      return ADEX_EXIT_FAIL

    # Merge implicit additional paths and user paths
    added_paths = []
    if not args.no_libs :
      added_paths.append(Path(ADEX_LIBRARY_DIR).resolve())
    if args.paths :
      for p in args.paths:
        added_paths.append(Path(p).resolve())

    # Init preprocessor and compile
    preprocessor = XsPreprocessor(added_paths)
    result = preprocessor.process(args.script)
    if result == ADEX_EXIT_FAIL:
      return ADEX_EXIT_FAIL
    Path(args.out).write_text("".join(preprocessor.output), encoding="utf-8")
    return ADEX_EXIT_SUCCESS

class XsPreprocessor:
    def __init__(self, include_paths: List[Path] = None):
        self.macros = {}
        self.output = []
        self.exit_code = []
        self.processed_files = set()
        self.conditional_stack = []   # Stack to track active/inactive conditional blocks
        self.include_paths = []       # Additional include paths

        self.curr = 0                 # Current index in source being processed
        self.curr_file = None
        self.curr_col = 0
        self.curr_line = 1

        # Normalize include paths
        if include_paths:
            for path in include_paths:
                self.include_paths.append(path.resolve())

    def process(self, root_script: pathlib.Path) -> int:
        """Main entry point to process a file."""
        return self._process_file(Path(root_script).resolve())

    def _print_error_with_loc(self, msg: str) -> int:
        """Print error message with current file/line/col context."""
        return print_error(f"{msg} File: {self.curr_file}, Line: {self.curr_line}, Col: {self.curr_col}")

    def _print_warning_with_loc(self, msg: str) -> int:
        """Print warning message with current file/line/col context."""
        return print_warning(f"{msg} File: {self.curr_file}, Line: {self.curr_line}, Col: {self.curr_col}")

    def _advance(self, src: str, count: int = 1) -> int:
        """Advance the current position by count characters, updating line/column."""
        for _ in range(count):
            if self.curr >= len(src):
                break
            if src[self.curr] == '\n':
                self.curr_line += 1
                self.curr_col = 0
            else:
                self.curr_col += 1
            self.curr += 1
        return self.curr

    def _set_curr_file(self, file_path: Path, index: int = 0, line: int = 1, col: int = 0):
        """Set the current file context for error reporting."""
        self.curr = index
        self.curr_file = file_path
        self.curr_line = line
        self.curr_col = col

    def _skip_whitespace(self, src: str):
        """Skip whitespace characters starting from self.curr position."""
        while self.curr < len(src) and src[self.curr].isspace() and src[self.curr] != '\n':
            self._advance(src)

    def _skip_to_newline(self, src: str):
        """Skip to the end of the current line."""
        length = len(src)
        while self.curr < length and src[self.curr] != '\n':
            self._advance(src)
        if self.curr < length and src[self.curr] == '\n':
            self._advance(src)

    def _lex_ident(self, src: str) -> str:
        """Parse an identifier starting at src[start]. Returns identifier."""
        ident_start = self.curr
        while self.curr < len(src) and (src[self.curr].isalnum() or src[self.curr] == '_' or src[self.curr] == '-'):
            self._advance(src)

        identifier = src[ident_start:self.curr]
        return identifier

    def _lex_string(self, src: str) -> tuple[int, str]:
        """Parse a C-style quoted string starting at src[self.curr].
        Returns (new_index, string_content)."""
        length = len(src)
        if self.curr >= length or src[self.curr] != '"':
            return self._print_error_with_loc(f"Expected opening quote for string literal."), ""

        self._advance(src)  # skip opening quote
        result = []

        while self.curr < length:
            if src[self.curr] == '"':  # closing quote
                self._advance(src)
                return ADEX_EXIT_SUCCESS, "".join(result)

            if src[self.curr] == '\\': # escape sequence
                self._advance(src)
                if self.curr >= length:
                    break

                esc = src[self.curr]
                if esc == 'n':
                    result.append('\n')
                elif esc == 't':
                    result.append('\t')
                elif esc == 'r':
                    result.append('\r')
                elif esc == '\\':
                    result.append('\\')
                elif esc == '"':
                    result.append('"')
                elif esc == '0':
                    result.append('\0')
                else: # Unknown escape keep the character as-is
                    result.append(esc)
            else:
                result.append(src[self.curr])

            self._advance(src)

        return self._print_error_with_loc(f"Unterminated string literal."), ""

    def _parse_directive(self, src: str) -> int:
        """Parse a preprocessor directive starting with #."""
        self._advance(src)  # Skip the '#'
        self._skip_whitespace(src)
        directive = self._lex_ident(src)

        if directive == "include":
            return self._parse_include(src)
        elif directive == "define":
            return self._parse_define(src)
        elif directive == "undef":
            return self._parse_undef(src)
        elif directive == "ifdef":
            return self._parse_ifdef(src)
        else:
            return print_error(f"Unknown preprocessor directive: #{directive}. \
                File: {self.curr_file}, Line: {self.curr_line}, Col: {self.curr_col}")

    def _parse_define(self, src: str) -> int:
        """Parse #define MACRO value and store in 'self.macros'."""
        length = len(src)

        self._skip_whitespace(src)
        macro_ident = self._lex_ident(src)
        if not macro_ident:
            return self._print_error_with_loc("No macro identifier provided for #define.")
        self._skip_whitespace(src)

        value_start = self.curr
        while self.curr < length and src[self.curr] != '\n':
            self._advance(src)
        macro_value = src[value_start:self.curr].strip()
        self.macros[macro_ident] = macro_value

        if self.curr < length and src[self.curr] == '\n':
            self._advance(src)

        return ADEX_EXIT_SUCCESS

    def _parse_undef(self, src: str) -> int:
        """Parse #undef MACRO - removes macro from 'self.macros'."""
        ident_start = self.curr
        self._skip_whitespace(src)
        macro_ident = self._lex_ident(src)
        self._skip_whitespace(src)

        if self.curr > ident_start:
            if macro_ident in self.macros:
                del self.macros[macro_ident]
            else:
                return self._print_warning_with_loc(f"Attempted to undefine undefined macro '{macro_ident}'.")
        else:
            return self._print_warning_with_loc(f"No macro identifier provided for #undef.")
        self._skip_to_newline(src)

        return ADEX_EXIT_SUCCESS

    def _parse_ifdef(self, src: str) -> int:
        """Parse #ifdef """
        ident_start = self.curr
        self._skip_whitespace(src)
        macro_ident = self._lex_ident(src)
        self._skip_whitespace(src)
        if ident_start == self.curr:
            return self._print_error_with_loc(f"No macro identifier provided for #ifdef.")

        self.conditional_stack.append(macro_ident in self.macros)
        self._skip_to_newline(src)
        return ADEX_EXIT_SUCCESS

    def _parse_include(self, src: str) -> int:
        """Parse #include directive and process the included file."""
        self._skip_whitespace(src)
        str_lit = self._lex_string(src)
        if str_lit[0] == ADEX_EXIT_FAIL:
            return ADEX_EXIT_FAIL
        if str_lit[1] == "":
            return self._print_error_with_loc(f"No filename provided for #include directive.")
        self._skip_to_newline(src)
        self._process_include_file(str_lit[1])
        return ADEX_EXIT_SUCCESS

    def _process_include_file(self, filename: str):
        """Find and process an included file with proper path resolution."""
        # Check if filename starts with "./" (local only)
        if filename.startswith("./"):
            # Remove "./" prefix and search only relative to current file
            local_filename = filename[2:]
            include_path = self.curr_file.parent / local_filename

            if include_path.exists() and include_path.is_file():
                self._process_file(include_path)
                return
            else:
                raise FileNotFoundError(f"Local included file not found: {include_path}")

        # Search order for non-local includes:
        # 1. Relative to current file's directory
        local_path = self.curr_file.parent / filename
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
            f"  1. {self.curr_file.parent}\n"
            f"  2. Additional include paths: {self.include_paths}"
        )

    def _parse_macro_expansion(self, src: str) -> int:
        """Parse @macro-name@ pattern and expand if defined."""
        self._advance(src)  # Skip the initial '@'
        length = len(src)

        # Parse macro identifier
        ident_start = self.curr
        macro_ident = self._lex_ident(src)
        if ident_start == self.curr:
            return self._print_error_with_loc(f"No macro identifier provided for macro expansion.")

        # Check if we have closing '@'
        if self.curr >= length or src[self.curr] != '@':
            return self._print_error_with_loc(f"Unterminated macro expansion pattern.")
        else:
            self._advance(src)  # Skip closing '@'

        # Expand macro if defined
        if macro_ident in self.macros:
            self.output.append(self.macros[macro_ident])

        return ADEX_EXIT_SUCCESS

    def _process_file(self, file_path: pathlib.Path) -> int:
        """Process a single file."""
        # Check for include cycles
        if file_path in self.processed_files:
            return print_warning(f"Include cycle detected for file \
                '{file_path}'. Skipping re-inclusion.")

        # Store previous file context
        prev_index = self.curr
        prev_file = self.curr_file
        prev_line = self.curr_line
        prev_col = self.curr_col

        self._set_curr_file(file_path)
        self.processed_files.add(file_path)
        src = file_path.read_text(encoding="utf-8")

        self.curr = 0
        length = len(src)

        while self.curr < len(src):
            # Ignore content in inactive conditional blocks.
            if self.conditional_stack and not self.conditional_stack[-1]:
                if src[self.curr] == '#':
                    self._advance(src)  # Skip '#'
                    directive_ident = self._lex_ident(src)
                    if directive_ident == "endif":
                        self.conditional_stack.pop()
                self._skip_to_newline(src)
                continue

            if src[self.curr] == '#':
                if self._parse_directive(src) == ADEX_EXIT_FAIL:
                  return ADEX_EXIT_FAIL
            elif src[self.curr] == '@':
                  if self._parse_macro_expansion(src) == ADEX_EXIT_FAIL:
                    return ADEX_EXIT_FAIL
            elif src[self.curr] == '"':  # Forward string literals
                str_lit_begin = self.curr
                str_lit = self._lex_string(src)
                if str_lit[0] == ADEX_EXIT_FAIL:
                    return ADEX_EXIT_FAIL
                self.output.append(src[str_lit_begin:self.curr])
            elif src[self.curr:self.curr+2] == '//':  # Skip single line comment
                self._skip_to_newline(src)
            elif src[self.curr:self.curr+2] == '/*':  # Skip multi-line comment
                self._advance(src, 2)
                while self.curr < length and src[self.curr:self.curr+2] != '*/':
                    self._advance(src)
                    if self.curr >= length:
                        return self._print_error_with_loc("Unterminated multi-line comment'.")
                if self.curr < length:
                    self._advance(src,2)
            else:                           # Forward other chars to output
                self.output.append(src[self.curr])
                self._advance(src)

        # Restore previous file context
        self._set_curr_file(prev_file, prev_index, prev_line, prev_col)
        return ADEX_EXIT_SUCCESS

def main():
  return AdexCli().run()

if __name__ == "__main__":
  main()
