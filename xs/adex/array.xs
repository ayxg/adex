// Alternative array interface to xsArray.
//
// Features :
//  - Additional xsArray operations such as append, remove, iteration, and much more.
//  - Improved array creation and deletion. Array liveleyness is tracked in a global xsArray lifetime registry, allows 
//    recycling of array IDs. Also, maintains track of array's type which can be queried at any time.
//    Allows user to iterate/dump all current live arrays at any point.
//  - Named xsArray map, keeps track of initialized named array IDs. Returns existing array upon re-init
//    instead of -1 like xsCreateArray. Allows refering back to array id by name if array was created with name.
//  - Static array virtual callback functions 'static_array_0'->'1023' (up to 1024 static arrays).
//    @see std/static_array
//
// !! This is the MOST important header to understand if you wish to have a comfortable time programming in XS.
//    While there are no pointers in XS, arrays are dynamic. Their equivalent in C would be a pointer - not
//    a C array. Can also be viewed as a C++ std::vector. 
//    Long story short, you are able to build and intiialize complex objects by chaining arrays of arrays.
//    For example to represent a theoretical structure like so:
/*
      struct Foo { int bar; float grok; };
*/
//    You may create an xs array equivalent constructor like so (everything is init separatley to make it clear...):
/*      
      int Foo(){
        static const int foo_size = 2;   // You may store these constants globally - or not at all. Its up to you.      
        static const int member_bar = 0;      
        static const int member_grok = 1;     
        int new_foo = xsCreateArrayInt(foo_size);               // Base Pointer : Size = 2
        xsArraySetInt(xsCreateArrayInt(member_bar));            // Base[0] -> bar
        xsArraySetInt(xsCreateArrayInt(member_grok));           // Base[1] -> grok
        return (new_foo);         
      }
*/
// Ofcourse, afterwards, you will need to create a deletion method if you are planning on creating this object often,
// or else you will leak memory and the scenario will become unplayable over time - and crash. This header aims to
// improve accessibility to the xsArray type, letting the user create complex objects with fewer 'low-level' concerns.