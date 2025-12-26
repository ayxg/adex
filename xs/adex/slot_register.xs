///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright 2025 Anton Yashchenko
// Licensed under the MIT License.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// @project: Anton's AOE2 DE XS Script Extensions
// @author(s): Anton Yashchenko (Steam Name: DEJ)
// @website: https://www.acpp.dev
// @created: 2025/08/03
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// @file slot_register.xs
/// @brief Literal pointer registry
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

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