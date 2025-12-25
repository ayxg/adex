///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright 2025 Anton Yashchenko
// Licensed under the MIT License.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// @project: Anton's AOE2 DE XS Script Extensions
// @author(s): Anton Yashchenko (Steam Name: DEJ)
// @website: https://www.acpp.dev
// @created: 2025/08/03
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// @file xxPredef.xs
/// @brief ADEX Library pseudo-keyword constants, fundamental type enums, and default function argument category tag
///        values.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////
// Pseudo-keyword constants
///////////////////////////////////////////////////////////
extern const int nullptr = -1;  ///< Null slot constant.
extern const int nullid = -1;   ///< Null array id.
extern const int nosize = -1;   ///< Invalid index constant.

// XS Fundamental Types Enum
// Literal | Scalar.
extern const int int_t = 0;
extern const int float_t = 1;
extern const int bool_t = 2;
// Literal | Heap storage.
// !!Note : Storing a mutable heap var in static scope initializes garbage.
extern const int string_t = 3;
// !!Note: In the entire std library vec3 refers to xs's 'vector' type.
//         This gives me an anneurism, due to being used to C++'s vector(dynamic array).
//         Furthermore, why name it vector if its a vec3, what about vec4? :|
extern const int vec3_t = 4;

// Array(dynamic).
extern const int int_array_t = 5;
extern const int float_array_t = 6;
extern const int bool_array_t = 7;
extern const int string_array_t = 8;
extern const int vec3_array_t = 9;

// Type properties
extern const int type_begin = 0;
extern const int type_end = 10;
extern const int type_count = 10;

///////////////////////////////////////////////////////////
// Default function argument category tag values.
// All func args require a default. Value tags may be used in a default arg to indicate intended usage to the caller.
// All tags are the initial type value:
//  - For int, float, bool it is 0.
//  - For string its an empty "".
//  - For vector it is vector(0,0,0).
///////////////////////////////////////////////////////////

// Argument is optional
extern const int optional_int = 0;
extern const float optional_float = 0.0;
extern const bool optional_bool = false;
extern const string optional_str = "";
extern const vector optional_vec3 = vector(0,0,0);
extern const int optional_ptr = nullptr;

// Argument is explicitly required
extern const int required_int = 0;
extern const float required_float = 0.0;
extern const bool required_bool = false;
extern const string required_str = "";
extern const vector required_vec3 = vector(0,0,0);
extern const int required_ptr = nullptr;

// Argument will be given (callback)
extern const int forward_int = 0;
extern const float forward_float = 0.0;
extern const bool forward_bool = false;
extern const string forward_str = "";
extern const vector forward_vec3 = vector(0,0,0);
extern const int forward_ptr = nullptr;

// Explicitly indicate to a function user the argument will default initialize.
extern const int default_int = 0;
extern const float default_float = 0.0;
extern const bool default_bool = false;
extern const string default_string = "";
extern const vector default_vec3 = vector(0,0,0);
extern const int default_ptr = nullptr;

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