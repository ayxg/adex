///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright 2025 Anton Yashchenko
// Licensed under the MIT License.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// @project: Anton's AOE2 DE XS Script Extensions
// @author(s): Anton Yashchenko (Steam Name: DEJ)
// @website: https://www.acpp.dev
// @created: 2025/08/03
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// @file test_framework.xs
/// @brief
/// Based on my C++ Test Framework 'minitest'. Code was loosley translated and simplified from C++.
///
/// Usage:
/// Declare a function for your test. At the begining call TEST("test_name") and at the end call TEST_END().
/// Use the various EXPECT_* macros to check conditions, if the condition is not met, prints error message in game.
/// Use the return value of the EXPECT_* macros conditionally test other conditions, or simulate an assert.
/// Make sure to call TEST_END() before exiting your test function.
///
/// eg.
/// @code
/// bool my_foo_test(){
///   TEST("my_foo_test"); // Doesnt have to be the same as function name
///   int val = 42;
///   EXPECT_TRUE(val);
///   EXPECT_EQ(val, 42);
///
///   // Assert-like check.
///   if(EXPECT_TRUE(val,0)) return (TEST_END());
///
///   return (TEST_END()); // call at end
/// }
/// @endcode
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "predef.xs"
#include "keywords.xs"

@decl@ void TEST(string name = "");
@decl@ bool TEST_END();
@decl@ bool EXPECT_TRUE(bool v = false, string msg = "");
@decl@ bool EXPECT_FALSE(bool v = false, string msg = "");
@decl@ bool EXPECT_EQ(int a = 0, int b = 0, string msg = "");
@decl@ bool EXPECT_NE(int a = 0, int b = 0, string msg = "");
@decl@ bool EXPECT_GT(int a = 0, int b = 0, string msg = "");
@decl@ bool EXPECT_GE(int a = 0, int b = 0, string msg = "");
@decl@ bool EXPECT_LT(int a = 0, int b = 0, string msg = "");
@decl@ bool EXPECT_LE(int a = 0, int b = 0, string msg = "");

@decl@ bool EXPECT_EQ_STRING(string a = "", string b = "", string msg = "");
@decl@ bool EXPECT_NE_STRING(string a = "", string b = "", string msg = "");

@decl@ bool EXPECT_EQ_FLOAT(float a = 0.0, float b = 0.0, string msg = "");
@decl@ bool EXPECT_NE_FLOAT(float a = 0.0, float b = 0.0, string msg = "");
@decl@ bool EXPECT_GT_FLOAT(float a = 0.0, float b = 0.0, string msg = "");
@decl@ bool EXPECT_LT_FLOAT(float a = 0.0, float b = 0.0, string msg = "");
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// impl
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Current active test after 'TEST' call.
string __minitest_curr_test(string name = "",bool reset_name = false){
  static int self = nullptr;
  if(self == nullptr) self = xsArrayCreateString(1,"[]");
  if(reset_name) self = xsArrayCreateString(1,"[]");
  else if(name != "") xsArraySetString(self,0,"[" + name + "]");
  return (xsArrayGetString(self,0));
}

// Defaults to 'true'.
bool __minitest_curr_test_state(bool state = true,bool set_state = false){
  static bool self = true;
  if(set_state) self = state;
  return (self);
}

bool __minitest_fail(string msg = ""){
  __minitest_curr_test_state(false,true);
  xsChatData("<RED>" + __minitest_curr_test() + msg);
  return (false);
}

bool TEST_END(){
  bool result = __minitest_curr_test_state();
  if(result) xsChatData("<GREEN>[Pass]" + __minitest_curr_test());
  else xsChatData("<RED>[Fail]" + __minitest_curr_test());
  __minitest_curr_test_state(true,true);
  __minitest_curr_test("",true); // Reset current test name.
  return (result);
}

void TEST(string name = ""){
  __minitest_curr_test(name);
  __minitest_curr_test_state(true, true);
}

bool EXPECT_TRUE(bool v = false, string msg = ""){
  if(v) return (true);
  return (__minitest_fail("Expected true." "[" + msg + "]"));
}

bool EXPECT_FALSE(bool v = false, string msg = ""){
  if(v == false) return (true);
  return (__minitest_fail("Expected false." "[" + msg + "]"));
}

bool EXPECT_EQ(int a = 0, int b = 0, string msg = ""){
  if(a == b) return (true);
  return (__minitest_fail("Expected equality. [" + msg + "] L: " + a + " | R: " + b));
}

bool EXPECT_NE(int a = 0, int b = 0, string msg = ""){
  if(a != b) return (true);
  return (__minitest_fail("Expected inequality. [" + msg + "] L: " + a + " | R: " + b));
}

bool EXPECT_GT(int a = 0, int b = 0, string msg = ""){
  if(a > b) return (true);
  return (__minitest_fail("Expected greater than. [" + msg + "] L: " + a + " | R: " + b));
}

bool EXPECT_GE(int a = 0, int b = 0, string msg = ""){
  if(a >= b) return (true);
  return (__minitest_fail("Expected greater than or equal. [" + msg + "] L: " + a + " | R: " + b));
}

bool EXPECT_LT(int a = 0, int b = 0, string msg = ""){
  if(a < b) return (true);
  return (__minitest_fail("Expected less than. [" + msg + "] L: " + a + " | R: " + b));
}

bool EXPECT_LE(int a = 0, int b = 0, string msg = ""){
  if(a <= b) return (true);
  return (__minitest_fail("Expected less than or equal. [" + msg + "] L: " + a + " | R: " + b));
}

bool EXPECT_EQ_STRING(string a = "", string b = "", string msg = ""){
  if(a == b) return (true);
  return (__minitest_fail("Expected string equality. [" + msg + "] L: " + a + " | R: " + b));
}

bool EXPECT_NE_STRING(string a = "", string b = "", string msg = ""){
  if(a != b) return (true);
  return (__minitest_fail("Expected string inequality. [" + msg + "] L: " + a + " | R: " + b));
}

bool EXPECT_EQ_FLOAT(float a = 0.0, float b = 0.0, string msg = ""){
  if(a == b) return (true);
  return (__minitest_fail("Expected float equality. [" + msg + "] L: " + a + " | R: " + b));
}

bool EXPECT_NE_FLOAT(float a = 0.0, float b = 0.0, string msg = ""){
  if(a != b) return (true);
  return (__minitest_fail("Expected float inequality. [" + msg + "] L: " + a + " | R: " + b));
}

bool EXPECT_GT_FLOAT(float a = 0.0, float b = 0.0, string msg = ""){
  if(a > b) return (true);
  return (__minitest_fail("Expected float greater than. [" + msg + "] L: " + a + " | R: " + b));
}

bool EXPECT_LT_FLOAT(float a = 0.0, float b = 0.0, string msg = ""){
  if(a < b) return (true);
  return (__minitest_fail("Expected float less than. [" + msg + "] L: " + a + " | R: " + b));
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// @project: Anton's AOE2 DE XS Script Extensions
// @author(s): Anton Yashchenko (Steam Name: DEJ)
// @website: https://www.acpp.dev
// @created: 2025/08/03
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// The MIT License (MIT)
// Copyright 2025 Anton Yashchenko
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
// documentation files (the “Software”), to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
// and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial
// portions of the Software.
//
// THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
// TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
// CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////