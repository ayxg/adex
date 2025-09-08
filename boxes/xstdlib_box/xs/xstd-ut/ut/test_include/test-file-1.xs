// "test-file-1.xs"
include "./@xs-local@/test-file-0.xs"; // Allowed. Second include of "test-file-0.xs", not sure why.

// Allowed - script local variables.
int script_mutable = 1;
const int script_const = 1;

// Allowed - does it override?
mutable int mutable_func(int val = 0,bool assign = false){
    return (42);
}

// Will override the same function inside "test-file-0.xs"
int mutable_func(int val = 0,bool assign = false){
    if(assign) script_mutable = val;
    return (script_mutable);
}

// Dont override.
mutable int file1_func(int val = 0,bool assign = false){
    return (101);
}
