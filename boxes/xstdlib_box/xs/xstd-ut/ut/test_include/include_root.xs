// "include_root.xs"
// Test variable and function symbol scope in reference to file inclusion.

include "@xs-local@/test-file-0.xs";
include "@xs-local@/test-file-1.xs"; // Allowed. Second include of "test-file-0.xs", not sure why.

int script_mutable = 999999;
const int script_const = 999999;

int file_func(int val = 0,bool assign = false){
  if(assign) script_mutable = val;
  return (script_mutable);
}