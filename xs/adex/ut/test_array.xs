mutable void test_array() @fn-decl-void@
mutable void test_array_max_count10000() @fn-decl-void@
mutable void test_array_max_count32767() @fn-decl-void@
mutable void test_array_max_count65535() @fn-decl-void@
mutable void test_array_max_count100000() @fn-decl-void@
mutable void test_array_max_count1000000() @fn-decl-void@
mutable bool test_array_unique_name_index() @fn-decl-bool@

void test_array(){
  /////////////////////////////////////////////////////////////////////////////
  // Test how many arrays we can initialize before exploding the game.
  // ONLY un-comment one func to test.
  /////////////////////////////////////////////////////////////////////////////
  //test_array_max_count10000();
  //test_array_max_count32767();
  //test_array_max_count65535();
  //test_array_max_count100000();
  //test_array_max_count1000000();
  //xsEnableRule("test_array_max_count100000staggered");
  //xsEnableRule("test_array_max_count1000000staggered");

  /////////////////////////////////////////////////////////////////////////////
  // Test array semantics
  /////////////////////////////////////////////////////////////////////////////
  // Does a named array which is re-initialized return the same index as the previous name ? or garbage?
  test_array_unique_name_index();
  test_array_get_set();
  test_array_init_ids();
}

// 10k Arrays : Ok - minor load lag.
void test_array_max_count10000(){
  string indices = "";
  for(i = 0; < 10000){
    indices = indices + "["+ xsArrayCreateInt(0) +"]";
  }
}

// 32767 Arrays : Ok - significant load lag.
void test_array_max_count32767(){
    string indices = "";
    for(i = 0; < 65535){
      indices = indices + "["+ xsArrayCreateInt(0) +"]";
    }
}

// 65535(16bits) Arrays : Ok - significant load lag.
void test_array_max_count65535(){
    string indices = "";
    for(i = 0; < 65535){
      indices = indices + "["+ xsArrayCreateInt(0) +"]";
    }
}


void test_array_max_count100000(){
  // 100k Arrays : CRASH.
  string indices = "";
  for(i = 0; < 100000){
      indices = indices + "["+ xsArrayCreateInt(0) +"]";
  }
}


void test_array_max_count1000000(){
  // 1kk Arrays : CRASH.
  string indices = "";
  for(i = 0; < 1000000){
    indices = indices + "["+ xsArrayCreateInt(0) +"]";
  }
}


rule test_array_max_count100000staggered inactive highFrequency group group_stdlib_unit_test {
  // Works fine ! Bit of startup lag.
  static int narrays = 0;
  narrays = narrays + 1;
  if(narrays < 10){
    string indices = "";
    for(i = 0; < 10000){
      indices = indices + "["+ xsArrayCreateInt(0) +"]";
    }
  }
  else xsDisableSelf();
}


rule test_array_max_count1000000staggered inactive highFrequency group group_stdlib_unit_test {
  // Game becomes impossibly laggy but doesent crash.
  static int narrays = 0;
  narrays = narrays + 1;
  if(narrays < 101){
    string indices = "";
    for(i = 0; < 10000){
      indices = indices + "["+ xsArrayCreateInt(0) +"]";
    }
  }
  else xsDisableSelf();
}


bool test_array_unique_name_index(){
  // Does a named array which is re-initialized return the same index as the previous name ? or garbage?
  TEST(string name = "test_array_unique_name_index");
  @IntArray@ dummy = xsArrayCreateInt(0,0,"__test_array_unique_name_index_dummy"); // Init dummy so we arent at 0
  @IntArray@ foo = xsArrayCreateInt(0,0,"__test_array_unique_name_index_foo_array");
  @IntArray@ bar = xsArrayCreateInt(0,0,"__test_array_unique_name_index_bar_array");
  EXPECT_EQ(bar, -1); // !!-> When an array with the same name is re-initialized, xsArrayCreate returns -1.
  return (TEST_END());
}

bool test_array_get_set(){
	//test_standard_library();
	TEST("test_array_get_set")

	// Integer array
	int foo = array(256);
	int  r1 = xsArraySetInt(foo,0,42);                  // Returns 1.
	int  r2 = xsArraySetFloat(foo,1,100.0);  			// Not Possible, returns 1.
	int  r3 = xsArraySetBool(foo,2,true);  				// Not Possible, returns 1.
	int  r4 = xsArraySetString(foo,3,"Hello World"); 	// Not Possible, returns 1.
	EXPECT_EQ(r1,1);
	EXPECT_EQ(r2,1);
	EXPECT_EQ(r3,1);
	EXPECT_EQ(r4,1);

	int r5 = xsArrayGetFloat(foo,1);
	float r6 = xsArrayGetFloat(foo,1); // Not possible, returns -1.0.
	bool r7 = xsArrayGetBool(foo,2);   // Not possible, returns false.
	string r8 = "";
	for(i = 0; < 256){
		r8 = xsArrayGetString(foo,i); // Not possible, returns empty string.
		if(r8 != "") break;
	}

	EXPECT_EQ(r5,42);
	EXPECT_EQ(r2,-1);
	EXPECT_EQ(r3,0);
	EXPECT_EQ_STRING(r4,"");

	int bar = xsArrayCreateString(1,"Hello World");
	for(i = 0; < 256){
		xsArraySetInt(bar,i,44); // set all to $ ... Not possible. NO effect.
	}
	EXPECT_EQ_STRING(xsArrayGetString(bar,0),"Hello World");

	return TEST_END();
}

bool test_array_init_ids(){
  // !!@note The stdlib contains arrays.
  //   The first user array ID is given by the constant 'baseptr'.
  TEST("test_array_init_ids");

  // Create array ID #1 : contains 256 arrays of diffrent type.
  int array_ids = xsArrayCreateInt(256);
  for(i = 0; < xsArrayGetSize(array_ids)) {
    if(i % 5 == 0)
      xsArraySetInt(array_ids, i, xsArrayCreateInt(0));
    else if(i % 4 == 0)
      xsArraySetInt(array_ids, i, xsArrayCreateBool(0));
    else if(i % 3 == 0)
      xsArraySetInt(array_ids, i, xsArrayCreateFloat(0));
    else if(i % 2 == 0)
      xsArraySetInt(array_ids, i, xsArrayCreateString(0));
    else
      xsArraySetInt(array_ids, i, xsArrayCreateVector(0));
  }

  // Check if all array IDs are aligned in ascending order [2...N - 1]
  // 0 is the test framework's array. 1 is the 'array_ids' array.
  string dump_arrays = "";
  int curr_id = 0;
  bool failed = false;
  for(i = 0; < (xsArrayGetSize(array_ids))){
    curr_id = (i + baseptr); // ID must be offset by the user's base pointer to realign it to 0.
    dump_arrays = dump_arrays + "[" + xsArrayGetInt(array_ids,i) + "]";
    if((not(EXPECT_TRUE(xsArrayGetInt(array_ids,i) == (curr_id))))) failed = true;
    if(xsArrayGetInt(array_ids,i) != (curr_id))
      xsChatData("invalid index: " + xsArrayGetInt(array_ids,i) + "!=" + (curr_id));
  }
  if(failed) xsChatData(dump_arrays);
  return (TEST_END());
}
