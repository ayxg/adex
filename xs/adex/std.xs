///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright 2025 Anton Yashchenko
// Licensed under the MIT License.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// @project: Anton's AOE2 DE XS Script Extensions
// @author(s): Anton Yashchenko (Steam Name: DEJ)
// @website: https://www.acpp.dev
// @created: 2025/08/03
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// @file std.xs
// @brief Fundamental language support functions
// Additional fundamental type manipulation/creation functions which are usually expected in a C-like language.
//  - Type Casting
//  - Integer Constants
//  - Negation operators
//  - Bitwise operations (WIP)
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "predef.xs"
#include "keywords.xs"

///////////////////////////////////////////////////////////////////////////////
// Type Casting
///////////////////////////////////////////////////////////////////////////////

// Float ->
@decl@ int ftoi(float v = required_float); /// Allows setting all int values by casting from float.
@decl@ bool ftob(float v = required_float);
@decl@ string ftos(float v = required_float);
@decl@ @Vec3@ ftov(float v = required_float);

// Integer ->
@decl@ int itof(int v = required_int);
@decl@ bool itob(int v = required_int);
@decl@ string itos(int v = required_int);
@decl@ @Vec3@ itov(int v = required_int);

// Bool ->
@decl@ int btoi(bool v = required_bool);
@decl@ float btof(bool v = required_bool);
@decl@ string btos(bool v = required_bool);
@decl@ @Vec3@ btov(bool v = required_bool);

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
extern const int kVec3Cast_X = 0;         ///> default := x
extern const int kVec3Cast_Y = 1;         ///> := y
extern const int kVec3Cast_Z = 2;         ///> := z
extern const int kVec3Cast_Add = 3;       ///> := x + y + z
extern const int kVec3Cast_Sub = 4;       ///> := x - y - z
extern const int kVec3Cast_Mul = 5;       ///> := x * y * z
extern const int kVec3Cast_Div = 6;       ///> := x / y / z
extern const int kVec3Cast_Rem = 7;       ///> := x % y % z
extern const int kVec3Cast_NormalX = 8;   ///> := normalized x
extern const int kVec3Cast_NormalY = 9;   ///> := normalized y
extern const int kVec3Cast_NormalZ = 10;  ///> := normalized z
extern const int kVec3Cast_Length = 11;   ///> := vec3 length
extern const int kVec3_XYZ = 12;          ///> string-> "($x,$y,$z)", same as kVec3Cast_Add for scalars.
extern const int kVec3_NormalXYZ = 13;    ///> string-> "($normal.x,$normal.y,$normal.z)",
                                          ///> Normalize then kVec3Cast_Add for scalars.

@decl@ int vtoi(@Vec3@ v = required_vec3,int vec3_cast_type = kVec3Cast_X);
@decl@ float vtof(@Vec3@ v = required_vec3,int vec3_cast_type = kVec3Cast_X);
@decl@ bool vtob(@Vec3@ v = required_vec3,int vec3_cast_type = kVec3Cast_X);
@decl@ string vtos(@Vec3@ v = required_vec3,int vec3_cast_type = kVec3Cast_X);


///////////////////////////////////////////////////////////////////////////////
// Integer support
///////////////////////////////////////////////////////////////////////////////

@decl@ int kIntSize(); // 4 - Integer size in bytes. Seems to always be a 32 bit int in XS.
@decl@ int kIntMax();  ///> 32-bit max constant.
@decl@ int kIntMin();  ///> 32-bit min constant.
@decl@ int kUint16Max();  ///> 16-bit unsigned max constant.
@decl@ int kUint8Max();  ///> 16-bit unsigned max constant.

///////////////////////////////////////////////////////////////////////////////
// XS Missing C-Language Operators
///////////////////////////////////////////////////////////////////////////////

// Unary Inversion
@decl@ bool not(bool x = required_bool);
@decl@ int negate(int x = required_int);
@decl@ float negate_float(float x = required_float);

// Bitwise
@decl@ int band(int x = required_int, int y = required_int);
@decl@ int bor(int x = required_int, int y = required_int);
@decl@ int bxor(int x = required_int, int y = required_int);
@decl@ int bnot(int x = required_int);

// Bit Shift
@decl@ int blsh(int x = required_int, int shift = required_int); // left shift
@decl@ int brsh(int x = required_int, int shift = required_int); // right shift

// C++ Bit Manipulation Operations from <bit>
@decl@ float bitcast_itof(int x = required_int); // reinterpret the object representation of one type as that of another
@decl@ int bitcast_ftoi(float x = required_float);
@decl@ int byteswap(int x = required_int); // reverses the bytes in the given integer value

// Integral powers of 2
@decl@ bool has_single_bit(int x = required_int); // checks if a number is an integral pwr of 2
@decl@ int bit_ceil(int x = required_int); //finds the smallest integral pwr of 2 not less than the given value
@decl@ int bit_floor(int x = required_int); // finds the largest integral pwr of 2 not greater than the given value
@decl@ int bit_width(int x = required_int); // finds the smallest number of bits needed to represent the given value

// Rotating
@decl@ int rotl(int x = required_int, int shift = 0); // computes the rt of bitwise left-rotation
@decl@ int rotr(int x = required_int, int shift = 0); // computes the rt of bitwise right-rotation

// Counting
@decl@ int countl_zero(int x = required_int); // counts the number of consecutive ​0​ bits, starting from the most significant bit
@decl@ int countl_one(int x = required_int); // counts the number of consecutive 1 bits, starting from the most significant bit
@decl@ int countr_zero(int x = required_int); // counts the number of consecutive ​0​ bits, starting from the least significant bit
@decl@ int countr_one(int x = required_int); // counts the number of consecutive 1 bits, starting from the least significant bit
@decl@ int popcount(int x = required_int); // counts the number of 1 bits in an unsigned integer

// Endian
@decl@ bool is_little_endian();

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// impl
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

int kUint8Max(){ return (255); }

bool not(bool x = required_bool){
	if(x) return (false);
	return (true);
}

int negate(int x = required_int) {
  return (0 - x);
}

float negate_float(float x = required_float){
  return (0.0 - x);
}

int band(int x = required_int, int y = required_int) {
  int rt = 0;
  int pwr = 1;
  while (x > 0 && y > 0) {
    int x_bit = x % 2;
    int y_bit = y % 2;
    if (x_bit == 1 && y_bit == 1) rt = rt + pwr;
    x = x / 2;
    y = y / 2;
    pwr = pwr * 2;
  }
  return (rt);
}

int bor(int x = required_int, int y = required_int) {
  int rt = 0;
  int pwr = 1;
  while (x > 0 || y > 0) {
    int x_bit = x % 2;
    int y_bit = y % 2;
    if (x_bit == 1 || y_bit == 1) rt = rt + pwr;
    x = x / 2;
    y = y / 2;
    pwr = pwr * 2;
  }
  return (rt);
}

int bxor(int x = required_int, int y = required_int) {
  int rt = 0;
  int pwr = 1;
  while (x > 0 || y > 0) {
    int x_bit = x % 2;
    int y_bit = y % 2;
    if ((x_bit == 1 && y_bit == 0) || (x_bit == 0 && y_bit == 1)) rt = rt + pwr;
    x = x / 2;
    y = y / 2;
    pwr = pwr * 2;
  }
  return (rt);
}

int bnot(int x = required_int) {
  return (negate(x) - 1);
}

@forward-decl@ int blsh(int x = required_int, int shift = required_int){return (-1);}
@forward-decl@ int brsh(int x = required_int, int shift = required_int){return (-1);}

int ipow2(int n = 0) {
  int result = 1;
  for (i = 0; < n) {
    result = result * 2;
  }
  return (result);
}


int blsh(int x = required_int, int shift = required_int) {
  if (shift < 0) return (brsh(x, negate(shift)));
  return (x * ipow2(shift));
}

int brsh(int x = required_int, int shift = required_int) {
  if (shift < 0) return (blsh(x, negate(shift)));
  return (x / ipow2(shift));
}

float bitcast_itof(int x = required_int) {
  return (bitCastToFloat(x)); // Available from 1.55! :)
}

int bitcast_ftoi(float x = required_float) {
    return (bitCastToInt(x)); // Available from 1.55! :)
}

int byteswap(int x = required_int) {
  int rt = 0;
  int i = 0;

  for (i = 0; < kIntSize()) {
    int byte_val = x % 256;
    if (byte_val < 0) byte_val = byte_val + 256;

    rt = rt * 256 + byte_val;

    if (x < 0)
      x = (x - 255) / 256;
    else
      x = x / 256;
  }

  return (rt);
}

bool has_single_bit(int x = required_int) {
  return (x > 0 && band(x, x - 1) == 0);
}

int bit_ceil(int x = required_int) {
  if (x <= 1) return (1);
  if (x < 0) return (0);

  int rt = 1;
  int max_pow = blsh(1,(kIntSize() * 8 - 2)); // highest safe power-of-two

  while (rt < x) {
    if (rt > max_pow) return (0); // overflow
    rt = rt * 2;
  }

  return (rt);
}

int bit_floor(int x = required_int) {
  if (x <= 0) return (0);
  int rt = 1;
  while (blsh(rt, 1) <= x) rt = blsh(rt, 1);
  return (rt);
}

int bit_width(int x = required_int) {
  if (x == 0) return (0);
  int width = 0;
  int temp = x;
  while (temp > 0) {
    width++;
    temp = brsh(temp, 1);
  }
  return (width);
}

int rotl(int x = required_int, int shift = required_int) {
  int n = kIntSize() * 8;
  shift = shift % n;
  if (shift < 0) shift = shift + n;
  int left_part = blsh(x, shift);
  int right_part = brsh(x, n - shift);
  return (bor(left_part, right_part));
}

int rotr(int x = required_int, int shift = required_int) {
  int n = kIntSize() * 8;
  shift = shift % n;
  if (shift < 0) shift = shift + n;
  int right_part = brsh(x, shift);
  int left_part = blsh(x, n - shift);
  return (bor(left_part, right_part));
}

int countl_zero(int x = required_int) {
  if (x == 0) return (kIntSize() * 8);
  int count = 0;
  int mask = blsh(1, kIntSize() * 8 - 1);
  while (band(x, mask) == 0) {
    count++;
    mask = brsh(mask, 1);
    if (mask == 0) break;
  }
  return (count);
}

int countl_one(int x = required_int) {
  int count = 0;
  int mask = blsh(1, kIntSize() * 8 - 1);
  while (band(x, mask) != 0) {
    count++;
    mask = brsh(mask, 1);
    if (mask == 0) break;
  }
  return (count);
}

int countr_zero(int x = required_int) {
  if (x == 0) return (kIntSize() * 8);
  int count = 0;
  int mask = 1;
  while (band(x, mask) == 0) {
    count++;
    mask = blsh(mask, 1);
    if (mask == 0) break;
  }
  return (count);
}

int countr_one(int x = required_int) {
  int count = 0;
  int mask = 1;
  while (band(x, mask) != 0) {
    count++;
    mask = blsh(mask, 1);
    if (mask == 0) break;
  }
  return (count);
}

int popcount(int x = required_int) {
  int count = 0;
  while (x != 0) {
    if (band(x, 1) != 0) count++;
    x = brsh(x, 1);
  }
  return (count);
}

bool is_little_endian() {
  return (band(1, kUint8Max()) == 1); // Check if least significant byte is first
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