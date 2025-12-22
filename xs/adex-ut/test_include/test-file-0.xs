// "test-file-0.xs"
int script_mutable = 0;
const int script_const = 0;

mutable int mutable_func(int val = 0,bool assign = false){
    return (42);
}

// Allowed cause foo was declared mutable first.
int mutable_func(int val = 0,bool assign = false){
    if(assign) script_mutable = val;
    return (script_mutable);
}

// Dont override.
mutable int file0_func(int val = 0,bool assign = false){
    if(assign) script_mutable = val;
    return (100);
}


// Can't multiply include the file if an extern or non-mutable func is defined in the file.
// extern const int my_global_var = 0;
// int bar(){ return (42); }