# Anton's AOE2DE XS Scripting Extensions & Resources **`STATUS:FROZEN`**
Partially finished library of extensions and resources for the XS scripting language used in Age of Empires 2 Definitive Edition scenarios.

**Unfortunatley, I do not have the time to continue developing this atm.** I'm posting it publicly in hopes of inspiring someone to work on it, or
use it as a reference for their XS script.

## Projects:
- `xs/adex` :
	- C-Like XS Standard Library.
	- Game-specific XS extensions.
	- Enumerated game data arrays. Perpetual WIP, the end goal is to know all the data points.
- `adex.py`
	- Basic preprocessor for XS.
	- "Build" XS scripts from an external directory. To "build" in XS means to copy, merge included files, and expand macros.
	- Allows one line macro definitions using `#define` syntax, expanded with `@macro-name@`.
	- Allows including files with `#include`, fully merging them into one file so you can share scripts which use includes online.

## Currently useable parts
- `adex.py`: XS preprocessor which can help you create re-useable headers for your XS scripts. Use `#include` instead of the XS `include` function inside your XS input script. The `xs/adex` folder is added to the include paths implicitly. Macro definitions also work(see above). Basic usage:
	```
	py adex.py path/to/input.xs -o your/aoe/steam/xs/folder/output.xs -i additional/include/paths
	```

- `xs/adex/std.xs` and `xs/adex/array_ops.xs` : many utility programming functions and array operations which may be useful. Use `#include "adex/std.xs"` with the preprocessor or copy the parts you need directly into your script.

- `xs/adex/DE[name].xs` : headers containing arrays of game data which may be initialized. They are extracted from the game data using python in the `scripts` folder.

- `res/dej-scenarios` : Some useful XS tricks such as creating "objects" in XS can be found in my unfinished example scenario scripts.

### License : **MIT** Anton Yashchenko 2025
