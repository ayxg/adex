include "@xs-local@/test_include/include_root.xs";

mutable void test_include() @fn-decl-void@
mutable bool test_include_call_mutable() @fn-decl-bool@


void test_include(){
  // Test variable and function symbol scope in reference to file inclusion.
  test_include_call_mutable();
}

mutable bool test_include_call_mutable(){
  TEST("test_include_call_mutable");

  // Allowed, function is visible. Uses func from "test-file-1.xs".
  // Result will be '1'(script_mutable from file 1);
  int t1 = mutable_func();
  if(EXPECT_EQ(t1, 1) == false) return (TEST_END());
  // Which script local variable is modifier?  "test-file-1.xs" ?
  t1 = mutable_func(1000,true);
  if(EXPECT_EQ(t1, 1000) == false) return (TEST_END());

  // Which script local variable is being accessed here?
  t1 = file_func();
  if(EXPECT_EQ(t1, 999999) == false) return (TEST_END());
  t1 = file0_func();
  if(EXPECT_EQ(t1, 100) == false) return (TEST_END());
  t1 = file1_func();
  if(EXPECT_EQ(t1, 101) == false) return (TEST_END());

  return (TEST_END());
}