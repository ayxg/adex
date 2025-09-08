#[====================================================================================================================[
Copyright 2025 Anton Yashchenko
Licensed under the Apache License, Version 2.0(the "License");
=======================================================================================================================
@project: [ADEX] Anton's AOE2DE XS Script Extentions
@author(s): Anton Yashchenko
@website: https://www.acpp.dev
=======================================================================================================================
@file XSMake Module
@ingroup xsmake_box
@brief Custom CMake target for building XS scripts.
#]====================================================================================================================]
include_guard()
include(SsgCMakeUtils)

#[====================================================================================================================[
  @option ADEX_XSMAKE_GAME_XS_DIR
  @brief Local AOE2 game /xs/ scripts directory where build files will be installed to.
  
  Usually "${steam-path}/SteamLibrary/steamapps/common/AoE2DE/resources/_common/xs". "Built" CMake-ADEX projects
  will output XS files here. The following files are reserved, and will be overwritten by the game at any time.
  Do NOT create these official game paths:
    - "default0.xs"
    - "Constants.xs"
    - "Effects.xs" 
    - "xs.txt"
    - "ailib/Geometry.xs"
    - "/ailib/"
  Do NOT create these ADEX reserved paths:
    - "adex.xs"
    - "std.xs"
    - "/std/"
    - "/adex/"
    - any paths inside "/std/" or "/adex/"
#]====================================================================================================================]
set(ADEX_XSMAKE_GAME_XS_DIR 
    "D:/SteamLibrary/steamapps/common/AoE2DE/resources/_common/xs"
    CACHE FILEPATH
    "Local AOE2 game /xs/ scripts directory where build files will be installed to."
    FORCE
)

#[====================================================================================================================[
  @option ADEX_XSMAKE_GAME_XS_DIR
  @brief User's local scenario folder. Only required if generating scenarios using `AoE2ScenarioParser` python module.
  
  Usually "C:/Users/${username}/Games/Age of Empires 2 DE/${user-id}/resources/_common/scenario"
#]====================================================================================================================]
set(ADEX_XSMAKE_USER_SCENARIO_DIR 
    "C:/Users/Anton/Games/Age of Empires 2 DE/76561198001524995/resources/_common/scenario"
    CACHE FILEPATH
    " User's local scenario folder."
    FORCE
)

#[====================================================================================================================[
  @option ADEX_USER_LOCAL_MOD_DIR
  @brief User's local mods folder. Only required if performing analysis using 'aoe2de-analyzer' C++ CMake target.
  
  Usually "C:/Users/${username}/Games/Age of Empires 2 DE/${user-id}/mods/local"
#]====================================================================================================================]
set(ADEX_XSMAKE_USER_LOCAL_MOD_DIR 
    "C:/Users/Anton/Games/Age of Empires 2 DE/76561198001524995/mods/local"
    CACHE FILEPATH
    "User's local mods folder."
    FORCE
)
#[====================================================================================================================[
  @var Z_ADEX_XSMAKE_BUILTIN_PRAGMAS
  [INTERNAL] Built-in XS pragmas. Stored as zipped name;value; pairs. See `adex_xsmake_project()` docs for details.
#]====================================================================================================================]
set(Z_ADEX_XSMAKE_BUILTIN_PRAGMAS
  "pragma-relative-path";     ""; # set per XS source file inside `adex_xsmake_project()`
  "pragma-virtual-int";       "{ xsChatData(\\\"[FATAL] Forgot to define function.\\\")\; return (-1)\; }";
  "pragma-virtual-bool";      "{ xsChatData(\\\"[FATAL] Forgot to define function.\\\")\; return (false)\; }";
  "pragma-virtual-float";     "{ xsChatData(\\\"[FATAL] Forgot to define function.\\\")\; return (-1.0)\; }";    
  "pragma-virtual-string";    "{ xsChatData(\\\"[FATAL] Forgot to define function.\\\")\; return (\\\"\\\")\; }";
  "pragma-virtual-vec3";      "{ xsChatData(\\\"[FATAL] Forgot to define function.\\\")\; return (vector(-1.0,-1.0,-1.0))\; }";
  "pragma-virtual-void";      "{ xsChatData(\\\"[FATAL] Forgot to define function.\\\")\; return \; }";
  "Vec3";                     "vector";
  "xsArrayInt";               "int";
  "xsArrayBool";              "int";
  "xsArrayFloat";             "int";
  "xsArrayString";            "int";
  "xsArrayVec3";              "int";
  "pragma-internal-implicit"; "\\\\ @pragma-internal-implicit@";
  "pragma-implicit";          "\\\\ @pragma-implicit@";
  "pragma-comment-on";        "\\* @pragma-comment-on@";
  "pragma-comment-off";       "*\\ @pragma-comment-off@";
  "pragma-debug-on";          "\\* @pragma-debug-on@";
  "pragma-debug-off";         "*\\ @pragma-debug-off@";
  "pragma-safe-on";           "\\* @pragma-safe-on@";
  "pragma-safe-off";          "*\\ @pragma-safe-off@";
)

#[====================================================================================================================[
  @function adex_xsmake_project(
    <projectName> 
    XS_INCLUDE_DIR <xsDirectory> 
    XS_SOURCES <xsFile1> [<xsFile2> ...] 
    MACROS [<cmakeVariable> ...] 
  )
  @brief Creates custom target which links an external project directory to the game's XS scripts directory.

  On build:
  1. All source files from the include dir are stripped of the include dir filename component, and copied over to the 
     binary /xs/ path.
  2. All occurences of @macro-name@ in the code are expanded to the macro's value. Macros can be passed as
     cmake variable names to the `MACROS` argument. The value of the cmake variable is captured at the inital call
     of `adex_project()` at config time, not upon build.
  3. Post build, copies the binary files to cache variable `ADEX_XSMAKE_GAME_XS_DIR`. Passing 'INSTALL_PATH' will 
     override the the target path. If path is empty or invalid, files will not be installed, only built to the binary 
     directory.
  
  Macros
  May be used with the @name@ syntax in XS scripts to generate code by passing CMake variables to the `MACROS` argument.
  Some built-in `pragma` macros are provided for acessibility purposes:
  - pragma-relative-path 
    : Relative path to the source file where the macro is called. XS does not provide a way to create relative
      includes, you must provide the entire file path from the root XS dir. Use this macro to paste the current 
      file's relative path before a relative include. 
      eg. Given file "path/to/file.xs" :  
        include "@pragma-relative-path@foo.xs";
      Will expand to:
        include "path/to/foo.xs";
    
  - pragma-virtual-[returnType] 
    : Use pragma after a mutable function signature to define a dummy empty function. 
      If ever called, prints "[FATAL] Forgot to define function." to chat.
      Function will return a garbage value.
        - int : -1
        - bool : false
        - float : -1.0
        - string : ""
        - vec3 : vector(-1.0,-1.0,-1.0)
        - void : [nothing]

  - Vec3 | xsArrayInt | xsArrayBool | xsArrayFloat | xsArrayString | xsArrayVec3
    : Builtin type aliases. 
        - @Vec3@ : expands to 'vector'. 
        - @xsArrays[type]@ : expands to 'int'.

  - pragma-internal-implicit
    : Internal use only. Indicates a function or variable definition is provided implicitly by the XS language.
      Used to define prototypes for XS core functions. Line after pragma will be commented out. 

  - pragma-implicit
    : Describe a function or variable definition which is available implicitly. Line after pragma will be commented out. 
      Can be used to declare existing function protypes inside diffrent files for reference.

  - pragma-comment-on | pragma-comment-off 
    : Code between on/off pragma will be commented out.

  - pragma-debug-on | pragma-debug-off 
    : Code between on/off pragma will be commented out if 'RELEASE' option is passed to the xs target.

  - pragma-safe-on | pragma-safe-off 
    : Code between on/off pragma will be commented out unless 'SAFE' option is passed to the xs target.
      This pragma used by the standard library to provide extra checks such as out of bounds access, and enables 
      crashing on errors (disabled by default to not ruin games). When developing a scenario the user may enable a 
      'SAFE' build to catch errors. Unlike the default debug mode, these checks may significatly impact performance.
#]====================================================================================================================]
function(adex_project)
    set(prefix arg)
    set(noValues)
    set(singleValues NAME XS_INCLUDE_DIR)
    set(multiValues XS_SOURCES MACROS)
    cmake_parse_arguments(${prefix}
        "${noValues}"
        "${singleValues}"
        "${multiValues}"
        ${ARGN}
    )

    foreach(req IN ITEMS NAME XS_INCLUDE_DIR XS_SOURCES)
        if(NOT DEFINED arg_${req})
            message(FATAL_ERROR "Missing required argument: ${req}")
        endif()
    endforeach()

    if(NOT EXISTS "${arg_XS_INCLUDE_DIR}")
        message(FATAL_ERROR "XS include directory does not exist: ${arg_XS_INCLUDE_DIR}")
    endif()


    set(abs_source_files)
    set(output_files)
    set(output_file_dirs "pop_this_element") # so empty vals can be appended 
    foreach(xs_file IN LISTS arg_XS_SOURCES)
        # get input file paths
        if(IS_ABSOLUTE "${xs_file}")
            cmake_path(SET abs_source_path NORMALIZE "${xs_file}")
        else()
            cmake_path(SET abs_source_path NORMALIZE "${arg_XS_INCLUDE_DIR}/${xs_file}")
        endif()

        if(NOT EXISTS "${abs_source_path}")
            message(WARNING "XS source file not found: ${abs_source_path}")
            continue()
        endif()
        list(APPEND abs_source_files "${abs_source_path}")

        # gen output paths 
        cmake_path(RELATIVE_PATH abs_source_path 
            BASE_DIRECTORY "${arg_XS_INCLUDE_DIR}"
            OUTPUT_VARIABLE rel_path
        )
        set(out_path "${ADEX_GAME_XS_DIR}/${rel_path}")
        list(APPEND output_files "${out_path}") 

        # save source dir for @xs-local@ macro
        get_filename_component(rel_dir "${xs_file}" DIRECTORY)
        list(APPEND output_file_dirs "${rel_dir}")
    endforeach()
    list(POP_FRONT output_file_dirs) 

    
    set(macro_vars) # generate passed macro vars
    foreach(mv IN LISTS arg_MACROS)
       string(APPEND macro_vars "set(${mv} \""${${mv}}"\")\n\n")
    endforeach()

    set(configure_script "${CMAKE_CURRENT_BINARY_DIR}/cmake-xs/${arg_NAME}-configure.cmake")
    cmake_path(GET configure_script PARENT_PATH script_dir)
    file(MAKE_DIRECTORY "${script_dir}")
    file(WRITE "${configure_script}" "# Auto-generated configuration script\n")
    file(APPEND "${configure_script}" "${macro_vars}")

    foreach(src out filemacro IN ZIP_LISTS abs_source_files output_files output_file_dirs)
        cmake_path(GET out PARENT_PATH out_dir)
        file(APPEND "${configure_script}"
            "file(MAKE_DIRECTORY \"${out_dir}\")\n"
            "set(pragma-relative-path \"${filemacro}\")\n" # append '/' to filemacro dir
            "configure_file(\"${src}\" \"${out}\" @ONLY)\n"
        )
    endforeach()

    # target
    add_custom_target(${arg_NAME} ALL
        COMMAND ${CMAKE_COMMAND} -P "${configure_script}"
        DEPENDS ${abs_source_files}
        BYPRODUCTS ${output_files}
        COMMENT "Processing XS files for ${arg_NAME}"
        VERBATIM
    )

    set_property(DIRECTORY APPEND PROPERTY
        ADDITIONAL_CLEAN_FILES ${output_files}
    )
    
    # clean empty dirs
    #foreach(out IN LISTS output_files)
    #    cmake_path(GET out PARENT_PATH out_dir)
    #    list(APPEND output_dirs "${out_dir}")
    #endforeach()
    #list(REMOVE_DUPLICATES output_dirs)
    #set_property(DIRECTORY APPEND PROPERTY
    #    ADDITIONAL_CLEAN_FILES ${output_dirs}
    #)
endfunction()


function(ssg_declare_subproject projectName)
  set(options)
  set(one_value_args SOURCE_DIR)
  set(multi_value_args)
  cmake_parse_arguments(PARSE_ARGV 1 arg "${options}" "${one_value_args}" "${multi_value_args}")
  ssg_check_unparsed_arguments(arg FATAL_ERROR)

  # arg_packagePrefix : ARGV0
  if(${ARGC} LESS 1)
    ssg_message(FUNC_ERROR "Missing <pkgPrefix> positional argument.")
  endif()
  set(arg_packagePrefix "${ARGV0}")

  ssg_assert_arguments(
    ARGUMENTS arg_SOURCE_DIR 
    REQUIRED 
    NOT_EMPTY
    FATAL_ERROR
  )

  # Include as sub-project. Use OVERRIDE_FIND_PACKAGE to force subsequent find_package calls
  # to use the local project configuration files. 
  include(FetchContent)
  FetchContent_Declare("${ARGV0}" 
    SOURCE_DIR "${arg_SOURCE_DIR}" 
    OVERRIDE_FIND_PACKAGE
  )
endfunction()

#[====================================================================================================================[
  @function ssg_declare_subprojects(
    NAMES <packageName1> [<packageName2> ...]
    SOURCE_DIRS <projectDir1> [<projectDir2> ...]
  )
  @brief Helper function for declaring subprojects. The function will declare the project in the order they are 
         passed. 'NAMES' and 'SOURCE_DIRS' must be equal in length. Each source dir will be associated with a package
         name on the same index.
  @see ssg_declare_subproject for details.
#]====================================================================================================================]
function(ssg_declare_subprojects)
  set(options)
  set(one_value_args)
  set(multi_value_args SOURCE_DIRS NAMES)
  cmake_parse_arguments(PARSE_ARGV 0 arg "${options}" "${one_value_args}" "${multi_value_args}")
  ssg_check_unparsed_arguments(arg FATAL_ERROR)

  ssg_assert_arguments(
    ARGUMENTS arg_SOURCE_DIRS arg_NAMES 
    REQUIRED 
    NOT_EMPTY
    FATAL_ERROR
  )

  list(LENGTH arg_SOURCE_DIRS n_source_dirs)
  list(LENGTH arg_NAMES n_package_names)
  if(NOT ${n_source_dirs} EQUAL ${n_package_names})
    ssg_message(FUNC_ERROR "Number of source directories and package names must be equal.")
  endif()

  math(EXPR last_index "${n_package_names} - 1")
  foreach(i RANGE 0 ${last_index})
    list(GET arg_SOURCE_DIRS ${i} this_src_dir)
    list(GET arg_NAMES ${i} this_package_name)

    include(FetchContent)
    FetchContent_Declare("${this_package_name}" 
      SOURCE_DIR "${this_src_dir}" 
      OVERRIDE_FIND_PACKAGE
    )
  endforeach()
endfunction()

#[====================================================================================================================[
  @function ssg_configure_alias_targets_file(
    <packageName>
    TARGETS <target1> <target2> ...
    OUTPUT <path>
    [INPUT <path>]
  )
  @brief Creates an alias targets file which declares aliases for all passed targets. Meant to be included by a 
         subproject config file.

  @argv0 packageName 
    : Prefix for the subproject. Used to create alias targets and to generate the config file name. 
      @note Prefix 'foo' will be postfixed with '::' when creating the alias targets. eg. 'foo::target1'

  @sinlge TARGETS 
    : List of targets to create alias targets for. The targets must be defined in the project.

  @single OUTPUT 
    : Path to the output file.

  @single INPUT 
    : Path to the input file. Only the init header is generated if no user input is provided.


  Appends given prefix to all targets in list. For each target, adds a generated cmake line base on target type:
    add_[library|executable](${arg_PREFIX}::${target} ALIAS ${target})

  When 'INPUT' is provided, the input file must be a valid cmake script configure file.
  The file MUST contain @SSG_THIS_CONFIG_INIT_ALIAS_TARGETS@ placeholder at the top of the file.
  Additional target properties may be exported in this script.

  The placeholder will be replaced with the generated code for the alias targets.
  If all alias targets are declared, anything below the placeholder will be ignored.
  If some of the alias targets are declared, incorrect config is assumed and results in fatal error.
 
  The input file will be configured with the following variables along with user variable in the scope:
    - SSG_THIS_CONFIG_NAME : prefix for the passed targets (package name).
    - SSG_THIS_CONFIG_PREFIXED_TARGETS_LIST : list of prefixed alias targets.
    - SSG_THIS_CONFIG_ALIAS_TARGETS_CODE : generated code for the alias targets.

  It is reccommended to name the input file 'alias-targets.cmake.in'.
  It is reccommended to name the output file '[packageName]-alias-targets.cmake'.

  TODO: impl may be improved by avoding intermediate file 'alias-targets-init.cmake.in'.
#]====================================================================================================================]
function(ssg_configure_alias_targets_file)
  set(options)
  set(one_value_args OUTPUT INPUT)
  set(multi_value_args TARGETS)
  cmake_parse_arguments(PARSE_ARGV 1 arg "${options}" "${one_value_args}" "${multi_value_args}")
  ssg_check_unparsed_arguments(arg FATAL_ERROR)

  # arg_packagePrefix : ARGV0
  if(${ARGC} LESS 1)
    ssg_message(FUNC_ERROR "Missing <pkgPrefix> positional argument.")
  endif()
  set(arg_packagePrefix "${ARGV0}")

  ssg_assert_arguments(
    ARGUMENTS arg_packagePrefix arg_TARGETS arg_OUTPUT 
    REQUIRED 
    NOT_EMPTY
    FATAL_ERROR
  )

  # Declare temporary input vars for "alias-targets-init.cmake.in" header config.
  # - SSG_THIS_CONFIG_NAME : prefix for the passed targets (package name).
  set(SSG_THIS_CONFIG_NAME ${arg_packagePrefix})

  # - SSG_THIS_CONFIG_PREFIXED_TARGETS_LIST : list of prefixed alias targets.
  set(SSG_THIS_CONFIG_PREFIXED_TARGETS_LIST "")
  set(export_prefix "${arg_packagePrefix}::")
  foreach(alias_target ${arg_TARGETS}) # Append alias prefix
    list(APPEND 
      SSG_THIS_CONFIG_PREFIXED_TARGETS_LIST 
      "${export_prefix}${alias_target}"
    )
  endforeach()

  # - SSG_THIS_CONFIG_ALIAS_TARGETS_CODE : generated code for the alias targets.
  set(SSG_THIS_CONFIG_ALIAS_TARGETS_CODE "")
  foreach(alias_target ${arg_TARGETS})
    if(NOT TARGET ${alias_target}) # Make sure target actually exists first.
      ssg_message(FUNC_ERROR "Failed to configure file. Target '${alias_target}' is not defined.")
      return()
    endif()

    get_target_property(target_type ${alias_target} TYPE)
    if(${target_type} STREQUAL "EXECUTABLE")
      string(APPEND SSG_THIS_CONFIG_ALIAS_TARGETS_CODE 
        "add_executable(${export_prefix}${alias_target} ALIAS ${alias_target})\n"
      )
    else()
      string(APPEND SSG_THIS_CONFIG_ALIAS_TARGETS_CODE 
        "add_library(${export_prefix}${alias_target} ALIAS ${alias_target})\n"
      )
    endif()
  endforeach()

  # Generate and read in alias init header for use in following config call.
  # - SSG_THIS_CONFIG_INIT_ALIAS_TARGETS
  set(this_alias_targets_init_file 
    "${SSG_PROJECTPACKAGEUTILS_OUT_DIR}/${arg_packagePrefix}/${arg_packagePrefix}-alias-targets-init.cmake"
  )
  configure_file(
    "${SSG_PROJECTPACKAGEUTILS_FILES_DIR}/alias-targets-init.cmake.in"
    "${this_alias_targets_init_file}"
    @ONLY
  )
  # unset(SSG_THIS_CONFIG_NAME) # Keep 'SSG_THIS_CONFIG_NAME' for the user config
  unset(SSG_THIS_CONFIG_PREFIXED_TARGETS_LIST)
  unset(SSG_THIS_CONFIG_ALIAS_TARGETS_CODE)

  file(READ 
    "${this_alias_targets_init_file}"
    SSG_THIS_CONFIG_INIT_ALIAS_TARGETS
  )
  file(REMOVE 
    "${this_alias_targets_init_file}"
  )

  # Configure user config if 'INPUT' is provided.
  if(NOT DEFINED arg_INPUT OR "${arg_INPUT}" STREQUAL "")
    file(WRITE "${arg_OUTPUT}" "${SSG_THIS_CONFIG_INIT_ALIAS_TARGETS}")
  else()
    # @SSG_THIS_CONFIG_INIT_ALIAS_TARGETS@ must be at the top of input file.
    configure_file(
      "${arg_INPUT}"
      "${arg_OUTPUT}"
      @ONLY
    )
  endif()
endfunction()

#[====================================================================================================================[
  @function ssg_write_pkg_redirects_extra_file(
    NAME <pkgName>
    [OUTPUT <outFilePath>]
    [OVERWRITE]
    [APPEND]
    [INCLUDES [<filePath1> [filePath2]...]] 
  )
  @brief Creates a '[name]-extra.cmake' file in the CMAKE_PACKAGE_REDIRECTS_DIR directory. The file is used to include 
         additional package config files when the project is brought in with FetchContent.

  @single NAME      
    : Name of the package. The file will be named '[name]-extra.cmake' and placed in the CMAKE_PACKAGE_REDIRECTS_DIR 
      directory. Ignored if 'OUTPUT' is set.

  @single OUTPUT    
    : When set, content will be written to specified path.

  @option OVERWRITE 
    : File will be overwritten if it already exists. Otherwise, the file won't be written. No diagnostic.

  @option APPEND
    : File will be appended to if it already exists.

  @multi INCLUDES  : [REQUIRED] List of absolute paths to config files which will be 'include()'-ed in the generated 
                     file. The files will be included in the order they are passed.

  When FetchContent is called  with 'OVERRIDE_FIND_PACKAGE', cmake automatically creates a config and version file for
  the subproject inside the CMAKE_PACKAGE_REDIRECTS_DIR. The generated config file does only one thing include an 
  optional file called : [pkg-name]-extras.cmake or [pkg-name]Extras.cmake. 

  CMAKE_PACKAGE_REDIRECTS_DIR is deleted and re-writted to every config run, by  CMake. So this file must be small, 
  and generated every run.
#]====================================================================================================================]
function(ssg_write_pkg_redirects_extra_file)
  set(options APPEND OVERWRITE)
  set(one_value_args PREFIX OUTPUT)
  set(multi_value_args INCLUDES)
  cmake_parse_arguments(PARSE_ARGV 0 arg "${options}" "${one_value_args}" "${multi_value_args}")
  ssg_check_unparsed_arguments(arg FATAL_ERROR)
  ssg_assert_arguments(
    ARGUMENTS arg_INCLUDES
    REQUIRED 
    NOT_EMPTY
    FATAL_ERROR
  )  

  # Validate input args.
  if(arg_OVERWRITE AND arg_APPEND)
    ssg_message(FUNC_ERROR "Can't specify both 'OVERWRITE' and 'APPEND' options.")
  endif()

  if(DEFINED arg_OUTPUT)
    if("${arg_OUTPUT}" STREQUAL "") 
      ssg_message(FUNC_ERROR "'OUTPUT' argument was specified but is empty.")
    endif()
    if(EXISTS "${arg_OUTPUT}")
      if(NOT arg_APPEND OR NOT arg_OVERWRITE)
        ssg_message(FUNC_ERROR "${arg_OUTPUT} file already exists. Use 'OVERWRITE' or 'APPEND' options.")
      endif()
    endif()
    if(DEFINED arg_PREFIX)
       ssg_message(FUNC_WARNING "'NAME' argument ignored when using 'OUTPUT' argument.")
    endif()
    set(this_output_file "${arg_OUTPUT}")
  else()
    ssg_assert_arguments(
      ARGUMENTS arg_PREFIX
      REQUIRED 
      NOT_EMPTY
      FATAL_ERROR
    ) 
    set(this_output_file "${CMAKE_FIND_PACKAGE_REDIRECTS_DIR}/${arg_PREFIX}-extra.cmake")
  endif()

  # Generate the file content.
  set(extras_file_content
    "# Generated by 'ssg_write_pkg_redirects_extra_file'.\n"
  )
  foreach(this_include_file IN LISTS arg_INCLUDES)
    string(APPEND extras_file_content 
      "include(\"${this_include_file}\")\n"
    )
  endforeach()
  string(APPEND extras_file_content 
    "# end - Generated by 'ssg_write_pkg_redirects_extra_file'.\n"
  )

  # Write the file.
  if(arg_OVERWRITE)
    file(WRITE 
      "${this_output_file}"
      "${extras_file_content}"
    )
  elseif(arg_APPEND)
    file(APPEND 
      "${this_output_file}"
      "${extras_file_content}"
    )
  else()
    if(EXISTS "${this_output_file}")
      ssg_message(FUNC_ERROR "'${this_output_file}' already exists. Use 'OVERWRITE' or 'APPEND' options.")
    endif()

    file(WRITE 
      "${this_output_file}"
      "${extras_file_content}"
    )
  endif()
endfunction()

#[====================================================================================================================[
  @function ssg_configure_subproject_config_file(
    <packageName>
    OUTPUT <subprojectConfigFilePath>
    [INPUT <subprojectConfigInputFile>]
    [TARGETS_FILE <targetsConfigFile>]
    [MODULE_PATHS [<modulePath> [modulePath2]...]]
  )
  @brief Export a subproject config file which emulates exported targets when the project is added using FetchContent.
         Allows overriding find_package to trigger this extra configuration file when called for the subproject.

  @argv0 packageName : 
    Prefix for the subproject. 

  @single OUTPUT : 
    Path to the output file.

  @single INPUT : 
    Path to the input file. Only the init header is generated if no user input is provided. Must contain 
    @SSG_THIS_CONFIG_INIT@ placeholder at the top of the file. The file should define any additional commands or 
    variables that the dependency would normally provide but which won't be available globally if the dependency is 
    brought into the build via FetchContent instead.

  @single TARGETS_FILE : 
    Path to the targets file. The file will be included in the generated config file.

  @multi MODULE_PATHS : 
    List of module paths to be exported in the config file. The paths will be added to the
    CMAKE_MODULE_PATH variable when the config file is included.
    The paths must be absolute.
#]====================================================================================================================]
function(ssg_configure_subproject_config_file)
  set(options)
  set(one_value_args INPUT OUTPUT TARGETS_FILE)
  set(multi_value_args MODULE_PATHS)
  cmake_parse_arguments(PARSE_ARGV 1 arg "${options}" "${one_value_args}" "${multi_value_args}")
  ssg_check_unparsed_arguments(arg FATAL_ERROR)
  ssg_assert_arguments(
    ARGUMENTS arg_OUTPUT
    REQUIRED 
    NOT_EMPTY
    FATAL_ERROR
  )
  
  # <packageName> : ARGV0
  if(${ARGC} LESS 1)
    ssg_message(FUNC_ERROR "Missing <packageName> positional argument.")
  endif()
  set(this_package_name "${ARGV0}")

  # Input config files should already exist prior to this call. Fail early.
  if(DEFINED arg_INPUT)
    if(NOT EXISTS "${arg_INPUT}")
      ssg_message(FUNC_ERROR "'INPUT' argument file does not exist. Path : ${arg_INPUT}")
    endif()
  endif()

  # Enable module paths export vars.
  if(DEFINED arg_MODULE_PATHS AND NOT "${arg_MODULE_PATHS}" STREQUAL "")
    set(SSG_THIS_CONFIG_MODULE_PATHS "${arg_MODULE_PATHS}")
    set(SSG_THIS_CONFIG_EXPORTS_MODULE_PATHS ON)
  else()
    set(SSG_THIS_CONFIG_MODULE_PATHS "")
    set(SSG_THIS_CONFIG_EXPORTS_MODULE_PATHS OFF)
  endif()

  # Enable alias targets export vars.
  if(DEFINED arg_TARGETS_FILE AND NOT "${arg_TARGETS_FILE}" STREQUAL "")
    set(SSG_THIS_CONFIG_ALIAS_TARGETS_FILE "${arg_TARGETS_FILE}")
    set(SSG_THIS_CONFIG_EXPORTS_ALIAS_TARGETS ON)
  else()
    set(SSG_THIS_CONFIG_ALIAS_TARGETS_FILE "")
    set(SSG_THIS_CONFIG_EXPORTS_ALIAS_TARGETS OFF)
  endif()

  # Configure temp init header, and read into 'SSG_THIS_PACKAGE_SUBPROJECT_CONFIG_INIT'.
  set(this_config_init_input_file "${SSG_PROJECTPACKAGEUTILS_FILES_DIR}/subproject-config-init.cmake.in")
  set(this_config_init_file 
    "${SSG_PROJECTPACKAGEUTILS_OUT_DIR}/${this_package_name}/${this_package_name}-subproject-config-init.cmake"
  )
  configure_file(
    "${this_config_init_input_file}"
    "${this_config_init_file}"
    @ONLY
  )
  unset(SSG_THIS_CONFIG_MODULE_PATHS)
  unset(SSG_THIS_CONFIG_EXPORTS_MODULE_PATHS)
  unset(SSG_THIS_CONFIG_ALIAS_TARGETS_FILE)
  unset(SSG_THIS_CONFIG_EXPORTS_ALIAS_TARGETS)

  file(READ "${this_config_init_file}" SSG_THIS_PACKAGE_SUBPROJECT_CONFIG_INIT) # config input
  file(REMOVE "${this_config_init_file}")
  
  # If no input was provided, output is just the header.
  if(NOT DEFINED arg_INPUT OR "${arg_INPUT}" STREQUAL "")
    file(WRITE "${arg_OUTPUT}" "${SSG_THIS_PACKAGE_SUBPROJECT_CONFIG_INIT}")
  else()
    configure_file("${arg_INPUT}" "${arg_OUTPUT}" @ONLY)
  endif()
endfunction()

#[====================================================================================================================[
  @function ssg_export_subproject(
    <packagePrefix>
    [ALIAS_TARGETS <target1> <target2> ...]
    [MODULE_PATHS <path1> <path2> ...]
    [OUTPUT_DIR]
    [REDIRECT_FIND_PACKAGE]
    [ALWAYS]
    [IF_SUBPROJECT]
  )
  @brief Create subproject config files, which emulate a project's exported interface.

  @argv0 pkgPrefix : 
    Prefix for the subproject. Used to create alias targets and to generate the config file name. 
    @note Prefix 'foo' will be postfixed with '::' when creating the alias targets. eg. 'foo::target1'

  @single OUTPUT_DIR : 
    Directory where the config files will be created. If not set, the files will be created
    inside 'SSG_PROJECTPACKAGEUTILS_SUBPROJECT_CONFIGS_DIR/[PREFIX]'.

  @multi TARGETS : 
    List of targets to create alias targets for. The targets must be defined in the project.
    When passed, a '[prefix]-alias-targets.cmake' file will be created inside 'OUTPUT_DIR'.
    Targets will be aliased '[prefix]::target1'.

  @multi MODULE_PATHS : 
    List of module paths to be exported in the config file. The paths will be added to the
    CMAKE_MODULE_PATH variable when the config file is included.
    The paths must be absolute. 

  @option REDIRECT_FIND_PACKAGE :
    When set, a '[prefix]-extra.cmake' file will be created inside 'CMAKE_FIND_PACKAGE_REDIRECTS_DIR'.
    This file will include the generated '[prefix]-config.cmake' file. Use this option to allow subproject
    configs to be included by other subprojects when the project is added using FetchContent(OVERRIDE_FIND_PACKAGE).

  @option ALWAYS :
    When set, the subproject config files will be created even if the project is top level. Otherwise, this function 
    will attempt to detect if the project was a subproject included using 'FetchContent' or 'find_package'.
    Overrides 'IF_SUBPROJECT' option.

  @option IF_SUBPROJECT
    When set, the config files will be created only if the project is a subproject. Otherwise, this function 
    will attempt to detect if the project was a subproject included using 'FetchContent' or 'find_package'.

  @requires 'SSG_PROJECTPACKAGEUTILS_OUT_DIR' if 'OUTPUT_DIR' is NOT set.
  @requires 'SSG_PROJECTPACKAGEUTILS_FILES_DIR'.
#]====================================================================================================================]
function(ssg_export_subproject)
  set(options REDIRECT_FIND_PACKAGE ALWAYS IF_SUBPROJECT)
  set(one_value_args OUTPUT_DIR)
  set(multi_value_args MODULE_PATHS TARGETS)
  cmake_parse_arguments(PARSE_ARGV 1 arg "${options}" "${one_value_args}" "${multi_value_args}")

  # arg_packagePrefix : ARGV0
  if(${ARGC} LESS 1)
    ssg_message(FUNC_ERROR "Missing <pkgPrefix> positional argument.")
  endif()
  set(arg_packagePrefix "${ARGV0}")

  ssg_check_unparsed_arguments(arg FATAL_ERROR)
  ssg_assert_arguments(
    ARGUMENTS arg_packagePrefix
    REQUIRED 
    NOT_EMPTY
    FATAL_ERROR
  )

  # Set auxillary dir 'this_out_dir' for this function call.
  if(DEFINED SSG_PROJECTPACKAGEUTILS_OUT_DIR)
    set(this_out_dir "${SSG_PROJECTPACKAGEUTILS_OUT_DIR}/${arg_packagePrefix}")
  else()
    ssg_message(FUNC_ERROR "'SSG_PROJECTPACKAGEUTILS_OUT_DIR' not defined. Implementation failure.")
  endif()


  # Determine if we should configure based on how the project was added to the build.
  # Store in 'apply_this_config'.
  if(arg_ALWAYS)
    set(apply_this_config ON)
  elseif(arg_IF_SUBPROJECT)
    if(NOT PROJECT_IS_TOP_LEVEL)
      set(apply_this_config ON)
    else()
      set(apply_this_config OFF)
    endif()   
  else()
    string(TOUPPER ${arg_packagePrefix} upper_prefix)
    # FetchContent?
    # - FETCHCONTENT_SOURCE_DIR_${upper_prefix}
    # - FETCHCONTENT_UPDATES_DISCONNECTED_${upper_prefix}
    # - ${arg_packagePrefix}_POPULATED
    if(DEFINED "FETCHCONTENT_SOURCE_DIR_${upper_prefix}" 
       AND DEFINED "FETCHCONTENT_UPDATES_DISCONNECTED_${upper_prefix}"
       AND DEFINED "${arg_packagePrefix}_POPULATED")
       set(is_using_fetchcontent ON)
    else()
      set(is_using_fetchcontent OFF)   
    endif()

    # find_package() ?
    # - ${arg_packagePrefix}_FIND_REQUIRED (maybe)
    if(DEFINED CMAKE_FIND_PACKAGE_NAME 
       AND "${CMAKE_FIND_PACKAGE_NAME}" STREQUAL "${arg_packagePrefix}"
       AND DEFINED "${arg_packagePrefix}_FIND_REQUIRED"
       AND "${${arg_packagePrefix}_FIND_REQUIRED}")
      set(is_using_findpackage ON)
    else()
      set(is_using_findpackage OFF)   
    endif()

    if(is_using_fetchcontent 
      AND is_using_findpackage 
      AND NOT PROJECT_IS_TOP_LEVEL)
      set(apply_this_config ON)
    else()
      set(apply_this_config OFF)
    endif()
  endif()

  if(${apply_this_config})
    # Create alias targets file.
    if(DEFINED arg_TARGETS AND NOT "${arg_TARGETS}" STREQUAL "")
      set(this_alias_targets_file
        "${this_out_dir}/${arg_packagePrefix}-alias-targets.cmake"
      )
      ssg_configure_alias_targets_file(
        "${arg_packagePrefix}"
        TARGETS ${arg_TARGETS}
        OUTPUT "${this_alias_targets_file}"
      )
    endif()

    # Configure the subproject config file.
    set(this_subproject_config_file "${this_out_dir}/${arg_packagePrefix}-subproject-config.cmake")
    ssg_configure_subproject_config_file(
      "${arg_packagePrefix}"
      OUTPUT "${this_subproject_config_file}"
      TARGETS_FILE "${this_alias_targets_file}"
      MODULE_PATHS ${arg_MODULE_PATHS}
    ) 

    # Write 'CMakeFiles/pkgRedirects/[projectName]-extra.cmake' file.
    if(arg_REDIRECT_FIND_PACKAGE)
      ssg_write_pkg_redirects_extra_file(
        PREFIX "${arg_packagePrefix}"
        INCLUDES "${this_subproject_config_file}"
        OVERWRITE
      )
    endif()
  endif()
endfunction()


#[====================================================================================================================[
Copyright 2025 Anton Yashchenko
Licensed under the Apache License, Version 2.0(the "License");
=======================================================================================================================
@project: [ADEX] Anton's AOE2DE XS Script Extentions
@author(s): Anton Yashchenko
@website: https://www.acpp.dev
#]====================================================================================================================]