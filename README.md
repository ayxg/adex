# Anton's AOE2DE XS Scripting Extensions & Resources **`STATUS:WIP`**
Extensions and resources for the XS scripting language used in Age of Empires 2 Definitive Edition scenarios.

## Projects:
- `xstdlib` :
	- C-Like XS Standard Library.
- `adex` :
	- Game-specific XS extensions. Requires `xstdlib`.
	- Enumerated game data arrays. Perpetual WIP, the end goal is to know all the data points.
- `xsmake`
	- Basic CMake build system for XS.
	- "Build" XS scripts from an external directory. To "build" in XS means to copy, and expand macros.
	- Allows macro definitions(pragmas) using `@pragma-ident@` syntax.
	- Allows file-local includes using `@pragma-relative-path@`.

## License Additions
Any XS script which you create and wish to share as a mod, is **implicitly source available** to anyone who plays or downloads the scenario. Therefore, its **impossible to release a closed source** XS script. Future plan is to add a "code mangler" for your scenario release, so you can keep your scenario's XS code semi-private. Main goal of using AGPL license is to discourage any thin api wrapper websites from using the extracted json datapoints for profit, without sharing their source back to the community. These are the special case exceptions to the AGPL license for `adex`:
	- If you use adex to create an Age of Empires scenario, you don't have 
	  to share your scenario's XS source or scenario file. 
	- If you modify the adex library for an an Age of Empires scenario, you 
	  are fully exempt from the AGPL license. Though any new discoveries are
	  appericated as contributions to `adex`.
