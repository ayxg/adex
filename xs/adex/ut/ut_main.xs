#include "./ut_test_framework.xs";
#include "./ut_bitwise.xs";

void ut_main(){
    xsChatData("<GREEN>===Running XsStdLibrary Unit Tests===");
    ut_test_framework();
    ut_bitwise();
}