cmake_minimum_required (VERSION 3.8)
project ("adex" LANGUAGES C CXX)

# This should be done inside the project's own CMakeLists.txt file.
include(XsMake)

# These should be set in your CMakePresets.json or CMakeUserPresets.json file.
set(ADEX_XSMAKE_USER_SCENARIO_DIR "C:/Users/Anton/Games/Age of Empires 2 DE/76561198001524995/resources/_common/scenario")
set(ADEX_XSMAKE_USER_LOCAL_MOD_DIR "C:/Users/Anton/Games/Age of Empires 2 DE/76561198001524995/mods/local")
set(ADEX_XSMAKE_GAME_XS_DIR "D:/SteamLibrary/steamapps/common/AoE2DE/resources/_common/xs")

adex_xsmake_project(
  XsStdLibrary 
  XS_INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/boxes/xstdlib_box/xs"
  XS_SOURCES 
  # Main header.
  "xstd.xs"
  # Xs standard library sources  
  "xstd/__include__.xs"
    # xstd/xsxx `XS++` private submodule
    "xstd/private/xsxx/__include__.xs"
        "xstd/private/xsxx/xsAi.xs"
        "xstd/private/xsxx/xsArray.xs"
        "xstd/private/xsxx/xsConstants.xs"
        "xstd/private/xsxx/xsGame.xs"
        "xstd/private/xsxx/xsGeneral.xs"
        "xstd/private/xsxx/xsMath.xs"
        "xstd/private/xsxx/xsMisc.xs"
        "xstd/private/xsxx/xsReadWrite.xs"
        "xstd/private/xsxx/xsRule.xs"
        "xstd/private/xsxx/xsVector.xs"
    # xstd/private `xStdlib` private implementation sources
    "xstd/private/__include__.xs"
        "xstd/private/array.xs"
        "xstd/private/dbgutil.xs"
        "xstd/private/keywords.xs"
        "xstd/private/operators.xs"
        "xstd/private/test_framework.xs"
        "xstd/private/xsarray_ops.xs"
        "xstd/private/xstdlib.xs"
    # xstd/private `xStdlib` public headers
    "xstd/public/__include__.xs"
  
  # Xs standard library unit tests
  "std-unit-tests/ut_main.xs"                 
    "std-unit-tests/ut/test_include.xs"
        "std-unit-tests/ut/test_include/include_root.xs" 
        "std-unit-tests/ut/test_include/test-file-0.xs"
        "std-unit-tests/ut/test_include/test-file-1.xs"
        "std-unit-tests/ut/test_include/test-file-2.xs"
    "std-unit-tests/ut/test_array.xs"
    "std-unit-tests/ut/test_bitwise.xs"
    "std-unit-tests/ut/test_semantics.xs"
)