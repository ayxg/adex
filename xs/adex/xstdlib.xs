///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Fundamental language support functions
// Additional fundamental type manipulation/creation functions which are usually expected in a C-like language.
//  - Type Casting
//  - Integer Support
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Type Casting
///////////////////////////////////////////////////////////////////////////////
// Float ->
mutable int ftoi(float v = required_float) @fn-decl-int@  ///> Allows setting all int values by casting from float.
mutable bool ftob(float v = required_float) @fn-decl-bool@  
mutable string ftos(float v = required_float) @fn-decl-string@  
mutable @Vec3@ ftov(float v = required_float) @fn-decl-vec3@  
// Integer ->
mutable int itof(int v = required_int) @fn-decl-int@  
mutable bool itob(int v = required_int) @fn-decl-bool@  
mutable string itos(int v = required_int) @fn-decl-string@  
mutable @Vec3@ itov(int v = required_int) @fn-decl-vec3@ 
// Bool ->
mutable int btoi(bool v = required_bool) @fn-decl-int@  
mutable float btof(bool v = required_bool) @fn-decl-float@  
mutable string btos(bool v = required_bool) @fn-decl-string@  
mutable @Vec3@ btov(bool v = required_bool) @fn-decl-vec3@ 
// String -> ? not possible with the xs string. Wait until I implement a string class. 
// How to implement :
// In theory you could have an int array which stores "characters". 
// Upon getting or setting the int value is looked up in a switch which enumerates all characters.
// The real issue is initializing such a string would be ugly. 
// You would have toset each character separatley.
/* eg. Init the string "Anton":
    str(5); 
    int idx = 0;
    set_str(idx,"A");  
    set_str(idx++,"n");  
    set_str(idx++,"t");  
    set_str(idx++,"o");  
    set_str(idx++,"n");
*/ 
// Vec3(vector) ->
// Additional 'vec3_cast_type' argument indiciates how to interpret the vec3's values.

extern const int kVec3Cast_X = 0; ///> default := x
extern const int kVec3Cast_Y = 1; ///> := y
extern const int kVec3Cast_Z = 2; ///> := y
extern const int kVec3Cast_Add = 3; ///> := x + y + z
extern const int kVec3Cast_Sub = 4; ///> := x - y - z
extern const int kVec3Cast_Mul = 5; ///> := x * y * z
extern const int kVec3Cast_Div = 6; ///> := x / y / z
extern const int kVec3Cast_Rem = 7; ///> := x % y % z
extern const int kVec3Cast_NormalX = 8; ///> := normalized x
extern const int kVec3Cast_NormalY = 9; ///> := normalized y
extern const int kVec3Cast_NormalZ = 10; ///> := normalized z
extern const int kVec3Cast_Length = 11; ///> := vec3 length
extern const int kVec3_XYZ = 12; ///> string-> "($x,$y,$z)", same as kVec3Cast_Add for scalars.
extern const int kVec3_NormalXYZ = 13; ///> string-> "($normal.x,$normal.y,$normal.z)", 
                                       ///> Normalize then kVec3Cast_Add for scalars.  

mutable int vtoi(@Vec3@ v = required_vec3,int vec3_cast_type = kVec3Cast_X) @fn-decl-int@  
mutable float vtof(@Vec3@ v = required_vec3,int vec3_cast_type = kVec3Cast_X) @fn-decl-float@  
mutable bool vtob(@Vec3@ v = required_vec3,int vec3_cast_type = kVec3Cast_X) @fn-decl-bool@
mutable string vtos(@Vec3@ v = required_vec3,int vec3_cast_type = kVec3Cast_X) @fn-decl-string@  


///////////////////////////////////////////////////////////////////////////////
// Integer support
///////////////////////////////////////////////////////////////////////////////
mutable int kIntSize() @fn-decl-int@ // 4 - Integer size in bytes. Seems to always be a 32 bit int in XS.
mutable int kIntMax() @fn-decl-int@  ///> 32-bit max constant.
mutable int kIntMin() @fn-decl-int@  ///> 32-bit min constant.
mutable int kUint16Max() @fn-decl-int@  ///> 16-bit unsigned max constant.
mutable int kUint8Max() @fn-decl-int@  ///> 16-bit unsigned max constant.


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// @impl xstdlib
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int ftoi(float v = required_float) { 
  return (0 + v); 
}

bool ftob(float v = required_float) { 
  return ((0 + v) > 0); 
} 

string ftos(float v = required_float) { 
  return ("" + v); 
}  

@Vec3@ ftov(float v = required_float) { 
  return (xsVectorSet(v,0.0,0.0)); 
} 
 
// Integer ->
int itof(int v = required_int) { 
  return (0.0 + v); 
}

bool itob(int v = required_int) { 
  return ((0 + v) > 0); 
} 

string itos(int v = required_int) { 
  return ("" + v); 
}  

@Vec3@ itov(int v = required_int) { 
  return (xsVectorSet(0.0 + v,0.0,0.0)); 
}  

int btoi(bool v = required_bool)   { 
  if(v) return (1);
  return (0); 
}

float btof(bool v = required_bool) {   
  if(v) return (1.0);
  return (0.0); 
} 
  
string btos(bool v = required_bool) {
  if(v) return ("true");
  return ("false");  
} 
  
@Vec3@ btov(bool v = required_bool) {
  if(v) return (xsVectorSet(1.0,1.0,1.0));
  return (xsVectorSet(0.0,0.0,0.0)); 
}  

int vtoi(@Vec3@ v = required_vec3,int vec3_cast_type = kVec3Cast_X) {
  switch(vec3_cast_type){
    case kVec3Cast_X:
      return (0 + xsVectorGetX(v));
    case kVec3Cast_Y:
      return (0 + xsVectorGetY(v));
    case kVec3Cast_Z:
      return (0 + xsVectorGetZ(v));
    case kVec3Cast_Add:
      return (0 + xsVectorGetX(v) + xsVectorGetY(v) + xsVectorGetZ(v));
    case kVec3Cast_Sub:
      return (0 + xsVectorGetX(v) - xsVectorGetY(v) - xsVectorGetZ(v));
    case kVec3Cast_Mul:
      return (0 + xsVectorGetX(v) * xsVectorGetY(v) * xsVectorGetZ(v));
    case kVec3Cast_Div:
      return (0 + xsVectorGetX(v) / xsVectorGetY(v) / xsVectorGetZ(v));
    case kVec3Cast_Rem:
      return (0 + xsVectorGetX(v) % xsVectorGetY(v) % xsVectorGetZ(v));
    case kVec3Cast_NormalX:
      return (0 + xsVectorGetX(xsVectorNormalize(v)));
    case kVec3Cast_NormalY:
      return (0 + xsVectorGetY(xsVectorNormalize(v)));
    case kVec3Cast_NormalZ:
      return (0 + xsVectorGetZ(xsVectorNormalize(v)));
    case kVec3Cast_Length:
      return (0 + xsVectorLength(v));
    case kVec3_XYZ:
      return (0 + xsVectorGetX(v) + xsVectorGetY(v) + xsVectorGetZ(v));
    case kVec3_NormalXYZ: {
      @Vec3@ vn = xsVectorNormalize(v);
      return (0 + xsVectorGetX(vn) + xsVectorGetY(vn) + xsVectorGetZ(vn));
    }
    default:
      return (0 + xsVectorGetX(v));
  }
  return (0 + xsVectorGetX(v)); // unreachable  
}
  
float vtof(@Vec3@ v = required_vec3,int vec3_cast_type = kVec3Cast_X) {
  switch(vec3_cast_type){
    case kVec3Cast_X:
      return (0.0 + xsVectorGetX(v));
    case kVec3Cast_Y:
      return (0.0 + xsVectorGetY(v));
    case kVec3Cast_Z:
      return (0.0 + xsVectorGetZ(v));
    case kVec3Cast_Add:
      return (0.0 + xsVectorGetX(v) + xsVectorGetY(v) + xsVectorGetZ(v));
    case kVec3Cast_Sub:
      return (0.0 + xsVectorGetX(v) - xsVectorGetY(v) - xsVectorGetZ(v));
    case kVec3Cast_Mul:
      return (0.0 + xsVectorGetX(v) * xsVectorGetY(v) * xsVectorGetZ(v));
    case kVec3Cast_Div:
      return (0.0 + xsVectorGetX(v) / xsVectorGetY(v) / xsVectorGetZ(v));
    case kVec3Cast_Rem:
      return (0.0 + xsVectorGetX(v) % xsVectorGetY(v) % xsVectorGetZ(v));
    case kVec3Cast_NormalX:
      return (0.0 + xsVectorGetX(xsVectorNormalize(v)));
    case kVec3Cast_NormalY:
      return (0.0 + xsVectorGetY(xsVectorNormalize(v)));
    case kVec3Cast_NormalZ:
      return (0.0 + xsVectorGetZ(xsVectorNormalize(v)));
    case kVec3Cast_Length:
      return (0.0 + xsVectorLength(v));
    case kVec3_XYZ:
      return (0.0 + xsVectorGetX(v) + xsVectorGetY(v) + xsVectorGetZ(v));
    case kVec3_NormalXYZ: {
      @Vec3@ vn = xsVectorNormalize(v);
      return (0.0 + xsVectorGetX(vn) + xsVectorGetY(vn) + xsVectorGetZ(vn));
    }
    default:
      return (0.0 + xsVectorGetX(v));
  }
  return (0.0 + xsVectorGetX(v)); // unreachable  
} 
 
bool vtob(@Vec3@ v = required_vec3,int vec3_cast_type = kVec3Cast_X) {
  switch(vec3_cast_type){
    case kVec3Cast_X:
      return (ftob(xsVectorGetX(v)));
    case kVec3Cast_Y:
      return (ftob(xsVectorGetY(v)));
    case kVec3Cast_Z:
      return (ftob(xsVectorGetZ(v)));
    case kVec3Cast_Add:
      return (ftob(xsVectorGetX(v) + xsVectorGetY(v) + xsVectorGetZ(v)));
    case kVec3Cast_Sub:
      return (ftob(xsVectorGetX(v) - xsVectorGetY(v) - xsVectorGetZ(v)));
    case kVec3Cast_Mul:
      return (ftob(xsVectorGetX(v) * xsVectorGetY(v) * xsVectorGetZ(v)));
    case kVec3Cast_Div:
      return (ftob(xsVectorGetX(v) / xsVectorGetY(v) / xsVectorGetZ(v)));
    case kVec3Cast_Rem:
      return (ftob(xsVectorGetX(v) % xsVectorGetY(v) % xsVectorGetZ(v)));
    case kVec3Cast_NormalX:
      return (ftob(xsVectorGetX(xsVectorNormalize(v))));
    case kVec3Cast_NormalY:
      return (ftob(xsVectorGetY(xsVectorNormalize(v))));
    case kVec3Cast_NormalZ:
      return (ftob(xsVectorGetZ(xsVectorNormalize(v))));
    case kVec3Cast_Length:
      return (ftob(xsVectorLength(v)));
    case kVec3_XYZ:
      return (ftob(xsVectorGetX(v) + xsVectorGetY(v) + xsVectorGetZ(v)));
    case kVec3_NormalXYZ: {
      @Vec3@ vn = xsVectorNormalize(v);
      return (ftob(xsVectorGetX(vn) + xsVectorGetY(vn) + xsVectorGetZ(vn)));
    }
    default:
      return (ftob(xsVectorGetX(v)));
  }
  return (ftob(xsVectorGetX(v))); // unreachable  
}

string vtos(@Vec3@ v = required_vec3,int vec3_cast_type = kVec3Cast_X) {
  switch(vec3_cast_type){
    case kVec3Cast_X:
      return ("" + xsVectorGetX(v));
    case kVec3Cast_Y:
      return ("" + xsVectorGetY(v));
    case kVec3Cast_Z:
      return ("" + xsVectorGetZ(v));
    case kVec3Cast_Add:
      return ("" + (xsVectorGetX(v) + xsVectorGetY(v) + xsVectorGetZ(v)));
    case kVec3Cast_Sub:
      return ("" + (xsVectorGetX(v) - xsVectorGetY(v) - xsVectorGetZ(v)));
    case kVec3Cast_Mul:
      return ("" + (xsVectorGetX(v) * xsVectorGetY(v) * xsVectorGetZ(v)));
    case kVec3Cast_Div:
      return ("" + (xsVectorGetX(v) / xsVectorGetY(v) / xsVectorGetZ(v)));
    case kVec3Cast_Rem:
      return ("" + (xsVectorGetX(v) % xsVectorGetY(v) % xsVectorGetZ(v)));
    case kVec3Cast_NormalX:
      return ("" + xsVectorGetX(xsVectorNormalize(v)));
    case kVec3Cast_NormalY:
      return ("" + xsVectorGetY(xsVectorNormalize(v)));
    case kVec3Cast_NormalZ:
      return ("" + xsVectorGetZ(xsVectorNormalize(v)));
    case kVec3Cast_Length:
      return ("" + xsVectorLength(v));
    case kVec3_XYZ:
      return ("(" + xsVectorGetX(v) + ", " + xsVectorGetY(v) + ", " + xsVectorGetZ(v) + ")");
    case kVec3_NormalXYZ: {
      @Vec3@ vn = xsVectorNormalize(v);
      return ("(" + xsVectorGetX(vn) + ", " + xsVectorGetY(vn) + ", " + xsVectorGetZ(vn) + ")");
    }
    default:
      return ("" + xsVectorGetX(v));
  }
  return ("" + xsVectorGetX(v)); // unreachable  
}  

int kIntSize(){ return (4); }

int kIntMax(){ return (ftoi(2147483647.0)); }

int kIntMin(){ return (ftoi(-2147483648.0)); }

int kUint16Max(){ return (65535); }

int kUint8Max(){ return (256); }