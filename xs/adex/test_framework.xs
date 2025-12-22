/*
Based on my C++ Test Framework 'minitest'. Code was loosley translated and simplified from C++.

Usage:
Declare a function for your test. At the begining call TEST("test_name") and at the end call TEST_END().
Use the various EXPECT_* macros to check conditions, if the condition is not met, prints error message in game.
Use the return value of the EXPECT_* macros conditionally test other conditions, or simulate an assert.
Make sure to call TEST_END() before exiting your test function.

eg.
@code
bool my_foo_test(){
  TEST("my_foo_test"); // Doesnt have to be the same as function name
  int val = 42;
  EXPECT_TRUE(val);
  EXPECT_EQ(val, 42);

  // Assert-like check.
  if(EXPECT_TRUE(val,0)) return (TEST_END());

  return (TEST_END()); // call at end
}
@endcode
*/
mutable void TEST(string name = "")                               @fn-decl-void@
mutable bool TEST_END()                                           @fn-decl-bool@
mutable bool EXPECT_TRUE(bool v = false)                          @fn-decl-bool@
mutable bool EXPECT_FALSE(bool v = false)                         @fn-decl-bool@
mutable bool EXPECT_EQ(int a = 0, int b = 0)                      @fn-decl-bool@
mutable bool EXPECT_NE(int a = 0, int b = 0)                      @fn-decl-bool@
mutable bool EXPECT_GT(int a = 0, int b = 0)                      @fn-decl-bool@
mutable bool EXPECT_GE(int a = 0, int b = 0)                      @fn-decl-bool@
mutable bool EXPECT_LT(int a = 0, int b = 0)                      @fn-decl-bool@
mutable bool EXPECT_LE(int a = 0, int b = 0)                      @fn-decl-bool@

mutable bool EXPECT_EQ_STRING(string a = "", string b = "")       @fn-decl-bool@
mutable bool EXPECT_NE_STRING(string a = "", string b = "")       @fn-decl-bool@


// Current active test after 'TEST' call.
mutable string __minitest_curr_test(string name = "",bool reset_name = false){
  static int self = nullptr;
  if(self == nullptr) self = xsArrayCreateString(1,"[]");  
  if(reset_name) self = xsArrayCreateString(1,"[]");
  else if(name != "") xsArraySetString(self,0,"[" + name + "]");
  return (xsArrayGetString(self,0));
}

// Defaults to 'true'.
mutable bool __minitest_curr_test_state(bool state = true,bool set_state = false){
  static bool self = true;
  if(set_state) self = state;
  return (self);
}

mutable bool __minitest_fail(string msg = ""){
  __minitest_curr_test_state(false,true);
  xsChatData("<RED>" + __minitest_curr_test() + msg);
  return (false);
}

mutable bool TEST_END(){
  bool result = __minitest_curr_test_state();
  if(result) xsChatData("<GREEN>[Pass]" + __minitest_curr_test());
  else xsChatData("<RED>[Fail]" + __minitest_curr_test());
  __minitest_curr_test_state(true,true);
  __minitest_curr_test("",true); // Reset current test name.
  return (result);
}

mutable void TEST(string name = ""){
  __minitest_curr_test(name);
  __minitest_curr_test_state(true, true);
}

mutable bool EXPECT_TRUE(bool v = false){
  if(v) return (true);
  return (__minitest_fail("Expected true."));
}

mutable bool EXPECT_FALSE(bool v = false){
  if(v == false) return (true);
  return (__minitest_fail("Expected false."));
}

mutable bool EXPECT_EQ(int a = 0, int b = 0){
  if(a == b) return (true);
  return (__minitest_fail("Expected equality."));
}

mutable bool EXPECT_NE(int a = 0, int b = 0){
  if(a != b) return (true);
  return (__minitest_fail("Expected inequality."));
}

mutable bool EXPECT_GT(int a = 0, int b = 0){
  if(a > b) return (true);
  return (__minitest_fail("Expected greater than."));
}

mutable bool EXPECT_GE(int a = 0, int b = 0){
  if(a >= b) return (true);
  return (__minitest_fail("Expected greater than or equal."));
}

mutable bool EXPECT_LT(int a = 0, int b = 0){
  if(a < b) return (true);
  return (__minitest_fail("Expected less than."));
}

mutable bool EXPECT_LE(int a = 0, int b = 0){
  if(a <= b) return (true);
  return (__minitest_fail("Expected less than or equal."));
}

mutable bool EXPECT_EQ_STRING(string a = "", string b = ""){
  if(a == b) return (true);
  return (__minitest_fail("Expected string equality."));
}

mutable bool EXPECT_NE_STRING(string a = "", string b = ""){
  if(a != b) return (true);
  return (__minitest_fail("Expected string inequality."));
}
