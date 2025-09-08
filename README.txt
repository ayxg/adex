# Anton's AOE2DE XS Scripting Extensions & Resources
Extensions and resources for the XS(eXtended subroutine) scripting language used in Age of Empires 2 Definitive Edition scenarios.

### Subprojects Overview:
- `std` : C-Like XS Standard Library.
- `xx` : Game-specific XS extensions.
	- Requires `std`.
- `kb` : Knowledge base. 
	- Enumerated game data arrays. Perpetual WIP, the end goal is to know all the data points.
- `CmakeXsTarget.cmake`
	- Build XS scripts from an external directory. 
	- Allows macro definitions(pragmas) using `@pragma-ident@` syntax.
	- Allows file-local includes using @pragma-relative-path@.
 