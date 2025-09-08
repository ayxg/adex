// Literal pointer registry
int int_vals = nullptr;
int bool_vals = nullptr;
int float_vals = nullptr;
int string_vals = nullptr;
int vec3_vals = nullptr;

void __StaticNewRegV(){
 int_vals = NewIntArray();
 bool_vals = NewBoolArray();
 float_vals = NewFloatArray();
 string_vals = NewStringArray();
 vec3_vals = NewVec3Array();

 ArrayReserve(int_vals,256);
 ArrayReserve(bool_vals,256);
 ArrayReserve(float_vals,256);
 ArrayReserve(string_vals,256);
 ArrayReserve(vec3_vals,256);
}

void __StaticDeleteRegV(){
 DeleteIntArray(int_vals);
 DeleteBoolArray(bool_vals);
 DeleteFloatArray(float_vals);
 DeleteStringArray(string_vals);
 DeleteVec3Array(vec3_vals);
}

int Registry_GetValueStack(int type = int_t){
  switch(type){
    case int_t: return int_vals;
    
  }
}

int Registry_AllocInt(int init = default_int,int size = nosize, int at = nosize){
  return (PushBackInt(rix,init));
}

int Registry_AllocBool(bool init = default_int){
  return (PushBackInt(rix,init));
}

int Registry_AllocFloat(float init = default_int){
  return (PushBackInt(rix,init));
}

int Registry_AllocString(string init = default_int){
  return (PushBackInt(rix,init));
}

int Registry_AllocVec3(vector init = default_int){
  return (PushBackInt(rix,init));
}


int register(int type = int_t, int ptr = nullptr){
  if(ptr == nullptr) {
    xsArrayPushInt(IntRegs_,default_int)
    switch(type){
     case int_t: 
      xsArrayPushInt(IntRegs_,default_int);
      return (xsArrayGetSize(IntRegs_) - 1);
     case bool_t: 
      xsArrayPushBool(IntRegs_,default_int);
      return (xsArrayGetSize(BoolRegisters) - 1);
     case string_t: 
      xsArrayPushString(IntRegs_,default_int);
      return (xsArrayGetSize(FloatRegisters) - 1);
     case float_t: 
      xsArrayPushFloat(IntRegs_,default_int);
      return (xsArrayGetSize(StringRegisters) - 1);
     case vec3_t: 
      xsArrayPushVec3(IntRegs_,default_int);
      return (xsArrayGetSize(Vec3Registers) - 1);
    }  
  }

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



















