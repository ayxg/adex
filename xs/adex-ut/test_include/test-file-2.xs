// "test-file-3.xs"
include "./@xs-local@/test-file-1.xs";

int script_mutable = 0;
const int script_const = 0;

// Dont override.
mutable int file2_func(int val = 0,bool assign = false){
    if(assign) script_mutable = val;
    return (script_mutable);
}
