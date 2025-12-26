bool test_registry_int_arrays(){
  TEST("test_registry_int_arrays");
  static_new_Reg();

  int user_arr = RegAllocArray(int_t);
  EXPECT_TRUE(int_t == RegTypeOf(user_arr));              // Get array's type.
  EXPECT_TRUE(RegStateOf(user_arr) == kArrayState_Live);  // Check if the array is live.
  RegDeleteArray(user_arr);                               // Delete the array (mark it dead and clear elements).
  EXPECT_TRUE(RegStateOf(user_arr) == kArrayState_Dead);  // Check if the array is dead.

  // Recycled array should be the same array id.
  int recycled_arr = RegRecycleArray(int_t);
  EXPECT_EQ(recycled_arr,user_arr);

  // Using 'new' should recycle if any dead arrays are available.
  // Otherwise it will allocate a new array.
  int new_user_arr = RegNewArray(int_t);
  EXPECT_NE(new_user_arr,user_arr);
  EXPECT_TRUE(RegDeadIntsSize_ == 0);
  RegDeleteArray(new_user_arr);
  EXPECT_TRUE(RegStateOf(new_user_arr) == kArrayState_Dead);
  EXPECT_TRUE(RegDeadIntsSize_ == 1);
  EXPECT_EQ(get_int(RegDeadInts_,0),new_user_arr);

  int new_user_arr_again = RegNewArray(int_t);
  EXPECT_EQ(new_user_arr,new_user_arr_again);

  static_clear_Reg();
  return (TEST_END());

}

void test_pointer_add_my_name(int p = nullptr){
 SetString(GetString(p) + "My name is Anton.");
}

bool test_pointer(){
 // Create a string pointer and pass it to a function which mutates that string.
 int pstr = NewString("Hello World!");
 test_pointer_add_my_name(pstr);
 EXPECT_EQ_STRING(GetString(p),"Hello World!My Name is Anton.");

 Delete(pstr);
 EXPECT_EQ(IsNull(pstr),true);

}