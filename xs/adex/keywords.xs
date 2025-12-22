///////////////////////////////////////////////////////////
// Pseudo-keyword constants
///////////////////////////////////////////////////////////
extern const int nullptr = -1;  ///< Null pointer constant.

// XS Fundamental Types Enum
// Literal | Scalar.
extern const int int_t = 0;
extern const int float_t = 1;
extern const int bool_t = 2;
// Literal | Heap storage. Storing a mutable var in static scope initializes garbage.
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

extern const int type_begin = 0;
extern const int scalar_types_begin = 3;
extern const int heap_type_begin = 3;
extern const int array_types_begin = 5;

extern const int type_count = 10;
extern const int scalar_types_count = 3;
extern const int heap_type_count = 3;
extern const int literal_types_count = 5;

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