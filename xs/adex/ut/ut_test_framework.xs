#include "adex/test_framework.xs";

bool ut_test_framework(){
  TEST("ut_test_framework"); // Doesnt have to be the same as function name
	if(EXPECT_TRUE(true) != true) xsChatData("'EXPECT_TRUE' function impl failure.");
	if(EXPECT_FALSE(false) != true) xsChatData("'EXPECT_FALSE' function impl failure.");
	if(EXPECT_EQ(42, 42) != true) xsChatData("'EXPECT_EQ' function impl failure.");
	if(EXPECT_NE(42, 41) != true) xsChatData("'EXPECT_NE' function impl failure.");
	if(EXPECT_GT(42, 41) != true) xsChatData("'EXPECT_GT' function impl failure.");
	if(EXPECT_GE(42, 41) != true) xsChatData("'EXPECT_GE' function impl failure.");
	if(EXPECT_GE(42, 42) != true) xsChatData("'EXPECT_GE' function impl failure.");
	if(EXPECT_LT(41, 42) != true) xsChatData("'EXPECT_LT' function impl failure.");
	if(EXPECT_LE(41, 42) != true) xsChatData("'EXPECT_LE' function impl failure.");
	if(EXPECT_LE(42, 42) != true) xsChatData("'EXPECT_LE' function impl failure.");
	if(EXPECT_EQ_STRING("Hello World!", "Hello World!")!= true) xsChatData("'EXPECT_EQ_STRING' function impl failure.");
	if(EXPECT_NE_STRING("Hello World!", "Hello Earth!")!= true) xsChatData("'EXPECT_NE_STRING' function impl failure.");

  // All the following tests should fail
  // Commented out to not spamm the chat with fails. Remove if test necessary.
  /*
	if(EXPECT_TRUE(false) != false) xsChatData("'EXPECT_TRUE' function impl failure.");
	if(EXPECT_FALSE(false) != false) xsChatData("'EXPECT_FALSE' function impl failure.");
	if(EXPECT_EQ(42, 41) != false) xsChatData("'EXPECT_EQ' function impl failure.");
	if(EXPECT_NE(42, 42) != false) xsChatData("'EXPECT_NE' function impl failure.");
	if(EXPECT_GT(41, 42) != false) xsChatData("'EXPECT_GT' function impl failure.");
	if(EXPECT_GE(41, 42) != false) xsChatData("'EXPECT_GE' function impl failure.");
	if(EXPECT_GT(42, 42) != false) xsChatData("'EXPECT_GT' function impl failure.");
	if(EXPECT_LT(42, 41) != false) xsChatData("'EXPECT_LT' function impl failure.");
	if(EXPECT_LE(42, 41) != false) xsChatData("'EXPECT_LE' function impl failure.");
	if(EXPECT_LT(42, 42) != false) xsChatData("'EXPECT_LT' function impl failure.");
	if(EXPECT_EQ_STRING("Hello Earth!", "Hello World!") != false) xsChatData("'EXPECT_EQ_STRING' function impl failure.");
	if(EXPECT_NE_STRING("Hello World!", "Hello World!") != false) xsChatData("'EXPECT_NE_STRING' function impl failure.");
  */
  return (TEST_END()); // call at end
}