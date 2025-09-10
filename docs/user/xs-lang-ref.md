# AOE2DE XS Scripting Language Reference (Un-official)


## Keywords


### Include
- Your main script which is set in the editor must be in the root 'xs' directory. Not a subdirectory.
- Main script name in editor is entered without ".xs" extension.
- Absolute paths are relative to the root 'xs' directory.
- Relative paths are broken and seem to act exactly the same as absolute paths.  
  This can been proven if you try to include a file inside a script in a subdir. 
  All paths are relative to "xs" folder.
- The name of the file must end in .xs ?????????
```c
// relative path include (works but same as absolute)
include "./filename.xs"
// absolute path include
include "filename.xs";
// full filesystem paths also work
include "C:/Users/Anton/Desktop/test.xs"; // Works, still files included in this file cant have relative includes...
```
Given file "2" in a "subdir" you will get this bug trying to include a relative file:
```c
#file "subdir/2.xs"
...
#file "subdir/1.xs"
// include "2.xs" // FAILURE. no such file exists.
// include "./2.xs" // FAILURE. no such file exists.
include "subdir/2.xs"; // Works, relative to root script dir.
include "./subdir/2.xs"; // Works too, relative to root script dir. 
                         // Also a valid double include given file-2 only has local vars.
// include "subdir/2.xs"; // Fails. Even though its the same as above.
include "subdir/3.xs"; // Works. This file also includes file 2, again.
```

With all this info. How should an xs project be organized? A lot of the benefits of includes are negated due to no relative paths.
Furthermore, any include can only be included once accross multiple files with no way to add a file guard or conditional code.
I reccomend the following structure:
- Most flat, prefer enumarted file names of nested folder structures.
- One since __includes__.xs file that includes all other files and controls order of dependencies of files.
- Main script file that includes __includes__.xs and is set in the editor.
- All other files will not include anything. You can leave commented out includes to incidate depndencies.
  If the the devs decide to ever fix the include system you can simply uncomment it :) IMHO , it is bugged.
```
my_project.xs - Main script, set in the editor, includes "my_project/__includes__.xs"
my_project/__includes__.xs 
my_project/subdir/1.xs
my_project/main.xs
my_project/scripts...
```

## Statements

### Global, script, local and rule declaration scopes.
Global vars may be const or mutable, by default they are mutable. Vars at the top level are all 'static' implicitly,
their lifetime will persist throughout the entire game session. By default, vars are file local, NOT accessible from
other scripts, and may be re-declared by other scripts.
```c
// Script-local variables
#file "1"
int my_script_mutable = 0;
const int my_script_const = 0;

#file "2"
include "1.xs";
int my_script_mutable = 0;
const int my_script_const = 0;

```
Including two files with the same script vars is allowed. 
```c
// Allowed
#file "1"
int my_script_mutable = 0;
const int my_script_const = 0;

#file "2"
int my_script_mutable = 0; 
const int my_script_const = 0;

#file "3"
include "1.xs"
include "2.xs"
int my_script_mutable = 0; 
const int my_script_const = 0;
```
Including the same file twice even if it only contains script local vars is **not** allowed. Except! See next point.
```c
#file "1"
int my_script_mutable = 0;
const int my_script_const = 0;****

#file "2"
include "1.xs";
include "1.xs"; // Not allowed, same file included twice
int my_script_mutable = 0; 
const int my_script_const = 0;
```
If required, you can still include the same file twice if it is included inside a diffrent file. 
This only works if, the file only contains script local vars and mutable functions.
For example:
```c
#file "1"
int my_script_mutable = 0;
const int my_script_const = 0;

// Can't double include.
// extern const int my_global_var = 0;
// int bar(){ return (42); }

mutable int foo(){ // Only a mutable function can be included twice
 return (42);
}

// Regular function allowed cause foo was declared mutable already.
// Furthermore, you can then forward a script local var to the global scope
// from a function.
int foo(){
 return (my_script_const);
}


#file "2"
include "1.xs"; // Allowed, first include
int my_script_mutable = 0;
const int my_script_const = 0;

#file "3"
include "1.xs";
include "2.xs"; // Allowed. Second include of "1.xs", not sure why.

void call_foo(){
    foo(); // Allowed, function is visible. Result will be '0'(script_local_var);
}
```
