include "std/operators";

mutable void test_bitwise() @fn-decl-void@
mutable bool test_bitwise_basic() @fn-decl-bool@
mutable bool test_byteswap() @fn-decl-bool@
mutable bool test_power_of_2() @fn-decl-bool@
mutable bool test_rotation() @fn-decl-bool@
mutable bool test_count() @fn-decl-bool@
mutable bool test_endian() @fn-decl-bool@

bool test_bitwise_basic() {
    TEST("test_bitwise_basic");
    EXPECT_EQ(band(10, 12), 8);    // 1010 & 1100 = 1000 (8)
    EXPECT_EQ(band(255, 15), 15);  // 11111111 & 00001111 = 00001111 (15)
    EXPECT_EQ(band(0, 65535), 0);  // 0 & 1111111111111111 = 0

    EXPECT_EQ(bor(10, 12), 14);    // 1010 | 1100 = 1110 (14)
    EXPECT_EQ(bor(240, 15), 255);  // 11110000 | 00001111 = 11111111 (255)
    EXPECT_EQ(bor(0, 65535), 65535); // 0 | 1111111111111111 = 65535

    EXPECT_EQ(bxor(10, 12), 6);    // 1010 ^ 1100 = 0110 (6)
    EXPECT_EQ(bxor(255, 255), 0);  // 11111111 ^ 11111111 = 0
    EXPECT_EQ(bxor(170, 85), 255); // 10101010 ^ 01010101 = 11111111 (255)

    EXPECT_EQ(bnot(0), -1);
    EXPECT_EQ(bnot(-1), 0);
    EXPECT_EQ(bnot(43690), 21845); // 1010101010101010 (43690) -> 0101010101010101 (21845)

    EXPECT_EQ(blsh(1, 3), 8);      // 1 << 3 = 8
    EXPECT_EQ(blsh(5, 2), 20);     // 101 << 2 = 10100 (20)
    EXPECT_EQ(brsh(8, 3), 1);      // 8 >> 3 = 1
    EXPECT_EQ(brsh(20, 2), 5);     // 10100 >> 2 = 101 (5)

    return (TEST_END());
}

bool test_byteswap() {
    TEST("test_byteswap");
    EXPECT_EQ(byteswap(305419896), 2018915346);  // 0x12345678 -> 0x78563412
    EXPECT_EQ(byteswap(1), 16777216);            // 0x00000001 -> 0x01000000
    EXPECT_EQ(byteswap(byteswap(305419896)), 305419896); // Double swap
    return (TEST_END());
}

bool test_power_of_2() {
    TEST("test_power_of_2");

    EXPECT_TRUE(has_single_bit(1));
    EXPECT_TRUE(has_single_bit(2));
    EXPECT_TRUE(has_single_bit(4));
    EXPECT_TRUE(has_single_bit(256));
    EXPECT_FALSE(has_single_bit(0));
    EXPECT_FALSE(has_single_bit(3));
    EXPECT_FALSE(has_single_bit(5));
    EXPECT_FALSE(has_single_bit(255));

    EXPECT_EQ(bit_ceil(0), 1);
    EXPECT_EQ(bit_ceil(1), 1);
    EXPECT_EQ(bit_ceil(2), 2);
    EXPECT_EQ(bit_ceil(3), 4);
    EXPECT_EQ(bit_ceil(5), 8);
    EXPECT_EQ(bit_ceil(255), 256);

    EXPECT_EQ(bit_floor(0), 0);
    EXPECT_EQ(bit_floor(1), 1);
    EXPECT_EQ(bit_floor(2), 2);
    EXPECT_EQ(bit_floor(3), 2);
    EXPECT_EQ(bit_floor(5), 4);
    EXPECT_EQ(bit_floor(255), 128);

    EXPECT_EQ(bit_width(0), 0);
    EXPECT_EQ(bit_width(1), 1);
    EXPECT_EQ(bit_width(2), 2);
    EXPECT_EQ(bit_width(3), 2);
    EXPECT_EQ(bit_width(4), 3);
    EXPECT_EQ(bit_width(255), 8);

    return (TEST_END());
}

bool test_rotation() {
    TEST("test_rotation");

    EXPECT_EQ(rotl(128, 1), 1);      // 10000000 << 1 = 00000001 (1)
    EXPECT_EQ(rotl(176, 2), 194);    // 10110000 << 2 = 11000010 (194)
    EXPECT_EQ(rotl(2147483648, 1), 1); // 10000000000000000000000000000000 << 1 = 1

    EXPECT_EQ(rotr(1, 1), 2147483648); // 00000000000000000000000000000001 >> 1 = 10000000000000000000000000000000
    EXPECT_EQ(rotr(194, 2), 176);    // 11000010 >> 2 = 10110000 (176)
    EXPECT_EQ(rotr(1, 1), 2147483648); // 1 >> 1 = 2147483648

    return (TEST_END());
}

bool test_count() {
    TEST("test_count");

    EXPECT_EQ(countl_zero(0), 32);           // All zeros
    EXPECT_EQ(countl_zero(1), 31);           // 000...001
    EXPECT_EQ(countl_zero(2147483648), 0);   // MSB set (10000000000000000000000000000000)

    EXPECT_EQ(countl_one(-1), 32);           // All ones (two's complement)
    EXPECT_EQ(countl_one(-16777216), 8);     // First 8 bits are ones

    EXPECT_EQ(countr_zero(0), 32);           // All zeros
    EXPECT_EQ(countr_zero(1), 0);            // LSB set
    EXPECT_EQ(countr_zero(2147483648), 31);  // Only MSB set

    EXPECT_EQ(countr_one(-1), 32);           // All ones
    EXPECT_EQ(countr_one(15), 4);            // Last 4 bits are ones

    EXPECT_EQ(popcount(0), 0);               // No ones
    EXPECT_EQ(popcount(-1), 32);             // All ones
    EXPECT_EQ(popcount(15), 4);              // 4 ones
    EXPECT_EQ(popcount(2863311530), 16);     // 16 ones (pattern: 10101010101010101010101010101010)

    return (TEST_END());
}

bool test_endian() {
    TEST("test_endian");
    EXPECT_TRUE(true == is_little_endian());
    return (TEST_END());
}