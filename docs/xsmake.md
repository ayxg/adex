# XSMake Module Docs

## Variables
*`ADEX_XSMAKE_GAME_XS_DIR`*
> Local AOE2 game /xs/ scripts directory where build files will be installed to.

  Usually `${steam-path}/SteamLibrary/steamapps/common/AoE2DE/resources/_common/xs`. `Built` CMake-ADEX projects
  will output XS files here. The following files are reserved, and will be overwritten by the game at any time.
  Do NOT create these official game paths:
    - `default0.xs`
    - `Constants.xs`
    - `Effects.xs` 
    - `xs.txt`
    - `ailib/Geometry.xs`
    - `/ailib/`
  Do NOT create these ADEX reserved paths:
    - `adex.xs`
    - `std.xs`
    - `/std/`
    - `/adex/`
    - any paths inside `/std/` or `/adex/`

*`ADEX_XSMAKE_USER_SCENARO_DIR`*
> User's local mods folder. Only required if performing analysis using 'aoe2de-analyzer' C++ CMake target.
  
  Usually "C:/Users/${username}/Games/Age of Empires 2 DE/${user-id}/mods/local"

*`ADEX_XSMAKE_USER_LOCAL_MOD_DIR`*
> User's local mods folder. Only required if performing analysis using 'aoe2de-analyzer' C++ CMake target.
  
  Usually `C:/Users/${username}/Games/Age of Empires 2 DE/${user-id}/mods/local`

## Builtin Pragmas

