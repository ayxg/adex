// - bitwise operators : `band`, `bor`, `bxor`, `bnot`, `blsh`, `brsh`
// - unary negation operators : `not` 'negate' 'negate_float'
// - C++ Bit Manipulation Operations from <bit> : 
include "@xs-local@/xstdlib";

// XS Missing C-Language Operators
  // Unary Inversion
mutable bool not(bool x = required_bool) @fn-decl-bool@
mutable int negate(int x = required_int) @fn-decl-int@
mutable float negate_float(float x = required_float) @fn-decl-float@
  // Bitwise
mutable int band(int x = required_int, int y = required_int) @fn-decl-int@
mutable int bor(int x = required_int, int y = required_int) @fn-decl-int@
mutable int bxor(int x = required_int, int y = required_int) @fn-decl-int@
mutable int bnot(int x = required_int) @fn-decl-int@
  // Bit Shift
mutable int blsh(int x = required_int, int shift = required_int) @fn-decl-int@ // left shift
mutable int brsh(int x = required_int, int shift = required_int) @fn-decl-int@ // right shift
// C++ Bit Manipulation Operations from <bit>
mutable float bitcast_itof(int x = required_int) @fn-decl-float@ // reinterpret the object representation of one type as that of another
mutable int bitcast_ftoi(float x = required_float) @fn-decl-int@

mutable int byteswap(int x = required_int) @fn-decl-int@ // reverses the bytes in the given integer value
  // Integral powers of 2
mutable bool has_single_bit(int x = required_int) @fn-decl-bool@ // checks if a number is an integral pwr of 2
mutable int bit_ceil(int x = required_int) @fn-decl-int@ //finds the smallest integral pwr of 2 not less than the given value
mutable int bit_floor(int x = required_int) @fn-decl-int@ // finds the largest integral pwr of 2 not greater than the given value
mutable int bit_width(int x = required_int) @fn-decl-int@ // finds the smallest number of bits needed to represent the given value
  // Rotating
mutable int rotl(int x = required_int, int shift = 0) @fn-decl-int@ // computes the rt of bitwise left-rotation
mutable int rotr(int x = required_int, int shift = 0) @fn-decl-int@// computes the rt of bitwise right-rotation
  // Counting
mutable int countl_zero(int x = required_int) @fn-decl-int@ // counts the number of consecutive ​0​ bits, starting from the most significant bit
mutable int countl_one(int x = required_int) @fn-decl-int@ // counts the number of consecutive 1 bits, starting from the most significant bit
mutable int countr_zero(int x = required_int) @fn-decl-int@ // counts the number of consecutive ​0​ bits, starting from the least significant bit
mutable int countr_one(int x = required_int) @fn-decl-int@ // counts the number of consecutive 1 bits, starting from the least significant bit
mutable int popcount(int x = required_int) @fn-decl-int@ // counts the number of 1 bits in an unsigned integer
  // Endian
mutable bool is_little_endian()@fn-decl-bool@

bool not(bool x = required_bool){
	if(x) return (false);
	return (true);
}

mutable int negate(int x = required_int) {
  return (-1 * x);
}

mutable float negate_float(float x = required_float){
  return (-1.0 * x);
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
  // find the next pwr of two greater than a to determine bit width
  int mask = 1;
  while (mask <= kIntMax() / 2 && mask <= x) mask = mask * 2;
  if (mask <= kIntMax() / 2) mask = mask * 2 - 1;
  else mask = kIntMax();
  return (mask - x);
}

int blsh(int x = required_int, int shift = required_int) {
  if (shift < 0) return (brsh(x, negate(shift)));
  return (x * ftoi(pow(2, shift)));
}

int brsh(int x = required_int, int shift = required_int) {
  if (shift < 0) return (blsh(x, negate(shift)));
  return (x / ftoi(pow(2, shift)));
}

float bitcast_itof(int x = required_int) {
  return (bitCastToFloat(x)); // Available from 1.55! :)
}

int bitcast_ftoi(float x = required_float) {
    return (bitCastToInt(x)); // Available from 1.55! :)
}

int byteswap(int x = required_int) {
  int rt = 0;
  for(i = 0; < kIntSize()) {
    int byte_val = band(brsh(x, i * 8), kUint8Max());
    rt = bor(rt, blsh(byte_val, (kIntSize() - 1 - i) * 8));
  }
  return (rt);
}

bool has_single_bit(int x = required_int) {
  return (x > 0 && band(x, x - 1) == 0);
}

int bit_ceil(int x = required_int) {
  if (x <= 1) return (1);
  int rt = 1;
  while (rt < x) {
    // Check for overflow
    if (rt > kIntMax() / 2) return (rt);
    rt = blsh(rt, 1);
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