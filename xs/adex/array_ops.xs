///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright 2025 Anton Yashchenko
// Licensed under the MIT License.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// @project: Anton's AOE2 DE XS Script Extensions
// @author(s): Anton Yashchenko (Steam Name: DEJ)
// @website: https://www.acpp.dev
// @created: 2025/08/03
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// @file std.xs
/// @brief Additional array operations for xs-language.
/// Implemented operations:
///  - sizeof
///  - get_[T]
///  - set_[T]
///  - resize_[T]
///  - create_[T]
///  - is_empty
///  - is_nullid
///  - clear_[T]
///  - get_back_[T]
///  - get_front_[T]
///  - extend_[T]
///  - push_[T]
///  - pop_[T]
///  - append_range_[T]
///  - insert_[T]
///  - erase_[T]
///  - swap_[T]
///  - find_[T]
///  - sort_[int | float]
///
/// Other array algorithms planned for future:
/// Array algorithms
/// Search
///  - all_of_[T]
///  - any_of_[T]
///  - none_of_[T]
///  - find_[T]
///  - find_end_[T]
///  - find_first_of_[T]
///  - adjacent_find_[T]
///  - count_[T]
///  - mismatch_[T]
///  - equal_[T]
///  - search_[T]
///  - search_n_[T]
///  - starts_with_[T]
///  - ends_with_[T]
///
/// Copy operations
///  - copy_[T]
///  - copy_n_[T]
///  - copy_backward_[T]
///  - move_[T]
///  - move_backward_[T]
///  - swap_ranges_[T]
///
/// Generation
///  - fill_[T]
///  - fill_n_[T]
///
/// Removal
///  - unique_[T]
///  - unique_copy_[T]
///
/// Order
///  - reverse
///  - reverse_copy
///  - rotate
///  - rotate_copy
///  - shift_left
///  - shift_right
///  - random_shuffle
///  - sample
///  - sort
///  - partial_sort
///  - is_sorted
///  - is_sorted_until
///////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////
// aliases for xs-language core array operations
///////////////////////////////////////////////////////////////////////////////////////////////////
int sizeof(int id = nullptr){return (xsArrayGetSize(id));}

int get_int(int id = nullptr,int idx = 0) {return (xsArrayGetInt(id,idx));}
string get_string(int id = nullptr,int idx = 0) {return (xsArrayGetString(id,idx));}
bool get_bool(int id = nullptr,int idx = 0) {return (xsArrayGetBool(id,idx));}
float get_float(int id = nullptr,int idx = 0) {return (xsArrayGetFloat(id,idx));}
vector get_vector(int id = nullptr,int idx = 0) {return (xsArrayGetVector(id,idx));}

int resize_int(int id = nullptr, int size = 0){return (xsArrayResizeInt(id,size));}
int resize_string(int id = nullptr, int size = 0){return (xsArrayResizeString(id,size));}
int resize_bool(int id = nullptr, int size = 0){return (xsArrayResizeBool(id,size));}
int resize_float(int id = nullptr, int size = 0){return (xsArrayResizeFloat(id,size));}
int resize_vector(int id = nullptr, int size = 0){return (xsArrayResizeVector(id,size));}

int set_int(int id = nullptr,int idx = 0, int value = 0){return (xsArraySetInt(id,idx,value));}
int set_string(int id = nullptr,int idx = 0, string value = ""){return (xsArraySetString(id,idx,value));}
int set_bool(int id = nullptr,int idx = 0, bool value = false){return (xsArraySetBool(id,idx,value));}
int set_float(int id = nullptr,int idx = 0, float value = 0.0f){return (xsArraySetFloat(id,idx,value));}
int set_vector(int id = nullptr,int idx = 0, vector value = vector(0.0,0.0,0.0)){return (xsArraySetVector(id,idx,value));}

int create_int(int size = 0, int fill = 0){ return (xsArrayCreateInt(size,fill)); }
int create_string(int size = 0, string fill = "") { return (xsArrayCreateString(size,fill)); }
int create_bool(int size = 0, bool fill = false){ return (xsArrayCreateBool(size,fill)); }
int create_float(int size = 0, float fill = 0.0f){ return (xsArrayCreateFloat(size,fill)); }
int create_vector(int size = 0, vector fill = vector(0.0,0.0,0.0)){ return (xsArrayCreateVector(size,fill)); }

///////////////////////////////////////////////////////////////////////////////////////////////////
// Extended array operations
///////////////////////////////////////////////////////////////////////////////////////////////////

// xsArrayGetSize(id) == 0
@decl@ bool is_empty(int id = nullid);

// id < 0
@decl@ bool is_nullid(int id = nullid);

// clear_[T] : Set array size to 0.
@decl@ void clear_int(int id = nullid);
@decl@ void clear_bool(int id = nullid);
@decl@ void clear_float(int id = nullid);
@decl@ void clear_string(int id = nullid);
@decl@ void clear_vector(int id = nullid);

// get_back_[T]
@decl@ int get_back_int(int id = nullid);
@decl@ bool get_back_bool(int id = nullid);
@decl@ float get_back_float(int id = nullid);
@decl@ string get_back_string(int id = nullid);
@decl@ vector get_back_vector(int id = nullid);

// get_front_[T]
@decl@ int get_front_int(int id = nullid);
@decl@ bool get_front_bool(int id = nullid);
@decl@ float get_front_float(int id = nullid);
@decl@ string get_front_string(int id = nullid);
@decl@ vector get_front_vector(int id = nullid);

// xsArrayExtend[T] : Increase array size by arg 'by'.
// Given no 'by' array size doubles.
// Given a negative by, array size will decrease by value.
// Returns new array size.
@decl@ int extend_int(int id = nullid, int by = 0);
@decl@ int extend_bool(int id = nullid, int by = 0);
@decl@ int extend_float(int id = nullid, int by = 0);
@decl@ int extend_string(int id = nullid, int by = 0);
@decl@ int extend_vector(int id = nullid, int by = 0);

// xsArrayPush[T]
// Increase array size by 1 and set last element.
// !!Extend first, then set new elements for more efficient insertion.
// Returns the passed array ID.
@decl@ int push_int(int id = nullid, int value = 0);
@decl@ int push_float(int id = nullid, float value = 0.0);
@decl@ int push_bool(int id = nullid, bool value = false);
@decl@ int push_string(int id = nullid, string value = "");
@decl@ int push_vector(int id = nullid, vector value = vector(0.0,0.0,0.0));

// pop_[T]
// Reduce array size by 1. Returns the element removed from the array.
@decl@ int pop_int(int id = nullid);
@decl@ int pop_float(int id = nullid);
@decl@ int pop_bool(int id = nullid);
@decl@ int pop_string(int id = nullid);
@decl@ int pop_vector(int id = nullid);

// append_range_[T]
@decl@ int append_range_int(int id = nullid, range_id = nullid);
@decl@ int append_range_float(int id = nullid, range_id = nullid);
@decl@ int append_range_bool(int id = nullid, range_id = nullid);
@decl@ int append_range_string(int id = nullid, range_id = nullid);
@decl@ int append_range_vector(int id = nullid, range_id = nullid);

// insert_[T]
@decl@ int insert_int(int id = nullid, int from = nosize);
@decl@ int insert_bool(int id = nullid, int from = nosize);
@decl@ int insert_float(int id = nullid, int from = nosize);
@decl@ int insert_string(int id = nullid, int from = nosize);
@decl@ int insert_vector(int id = nullid, int from = nosize);

// insert_[T]
@decl@ int insert_range_int(int id = nullid, range_id = nullid);
@decl@ int insert_range_bool(int id = nullid, range_id = nullid);
@decl@ int insert_range_float(int id = nullid, range_id = nullid);
@decl@ int insert_range_string(int id = nullid, range_id = nullid);
@decl@ int insert_range_vector(int id = nullid, range_id = nullid);

// erase_[T]
// Erase elements from index [from...to - 1].
// Re-align all other elements and shrink array to fit.
// No re-alignment occurs if elements are a range from the end of the array.
// If arg 'to' is not set. Erases element at index arg 'from'.
// Returns true if element was erase, false if out of bounds.
@decl@ bool erase_int(int id = nullid, int from = nosize,int to = nosize);
@decl@ bool erase_bool(int id = nullid, int from = nosize,int to = nosize);
@decl@ bool erase_float(int id = nullid, int from = nosize,int to = nosize);
@decl@ bool erase_string(int id = nullid, int from = nosize,int to = nosize);
@decl@ bool erase_vector(int id = nullid, int from = nosize,int to = nosize);

// swap_[T]
// Swap element 'a' and 'b' postions within the given array.
@decl@ void swap_int(int id = nullid, int a = nosize, int b = nosize);
@decl@ void swap_float(int id = nullid, int a = nosize, int b = nosize);
@decl@ void swap_bool(int id = nullid, int a = nosize, int b = nosize);
@decl@ void swap_string(int id = nullid, int a = nosize, int b = nosize);
@decl@ void swap_vector(int id = nullid, int a = nosize, int b = nosize);

// xsArrayFind[T]
// Linear search for element and return the index of first occurrence.
// Returns -1 if not found.
@decl@ int find_int(int id = nullid, int what = nullid);
@decl@ int find_bool(int id = nullid, int what = nullid);
@decl@ int find_float(int id = nullid, int what = nullid);
@decl@ int find_string(int id = nullid, int what = nullid);
@decl@ int find_vector(int id = nullid, int what = nullid);

// xsArraySort[T]
// Sort array in ascending order using quicksort(Lomuto partition)
@decl@ int sort_int(int id = nullid);
@decl@ int sort_float(int id = nullid);

//////////////////////////////////////////////////
// impl
//////////////////////////////////////////////////

bool is_empty(int id = nullid){
  return (xsArrayGetSize(id) == 0);
}

bool is_nullid(int id = nullid){
  return (id < 0);
}

void clear_int(int id = nullid){
  resize_int(id, 0);
}

void clear_string(int id = nullid){
  resize_string(id, 0);
}

void clear_bool(int id = nullid){
  resize_bool(id, 0);
}

void clear_float(int id = nullid){
  resize_float(id, 0);
}

void clear_vector(int id = nullid){
  resize_vector(id, 0);
}

int get_back_int(int id = nullid){
  return get_int(id,sizeof(id) - 1);
}

bool get_back_bool(int id = nullid){
  return get_bool(id,sizeof(id) - 1);
}

float get_back_float(int id = nullid){
  return get_float(id,sizeof(id) - 1);
}

string get_back_string(int id = nullid){
  return get_string(id,sizeof(id) - 1);
}

vector get_back_vector(int id = nullid){
  return get_vector(id,sizeof(id) - 1);
}

int get_front_int(int id = nullid){
  return get_int(id,0);
}

bool get_front_bool(int id = nullid){
  return get_bool(id,0);
}

float get_front_float(int id = nullid){
  return get_float(id,0);
}

string get_front_string(int id = nullid){
  return get_string(id,0);
}

vector get_front_vector(int id = nullid){
  return get_vector(id,0);
}

int extend_int(int id = nullid, int by = 0){
  if(by == 0) return (sizeof(id));
  else resize_int(id,sizeof(id) + by);
  return (sizeof(id));
}

int extend_bool(int id = nullid, int by = 0){
  if(by == 0) return (sizeof(id));
  else resize_bool(id,sizeof(id) + by);
  return (sizeof(id));
}

int extend_float(int id = nullid, int by = 0){
  if(by == 0) return (sizeof(id));
  else resize_float(id,sizeof(id) + by);
  return (sizeof(id));
}

int extend_string(int id = nullid, int by = 0){
  if(by == 0) return (sizeof(id));
  else resize_string(id,sizeof(id) + by);
  return (sizeof(id));
}

int extend_vector(int id = nullid, int by = 0){
  if(by == 0) return (sizeof(id));
  else resize_vector(id,sizeof(id) + by);
  return (sizeof(id));
}

int push_int(int id = nullid, int value = 0){
  int size = sizeof(id);
  resize_int(id, size + 1);
  set_int(id, size, value);
  return (id);
}

int push_float(int id = nullid, float value = 0.0){
  int size = sizeof(id);
  resize_float(id, size + 1);
  set_float(id, size, value);
  return (id);
}

int push_bool(int id = nullid, bool value = false){
  int size = sizeof(id);
  resize_bool(id, size + 1);
  set_bool(id, size, value);
  return (id);
}

int push_string(int id = nullid, string value = ""){
  int size = sizeof(id);
  resize_string(id, size + 1);
  set_string(id, size, value);
  return (id);
}

int push_vector(int id = nullid, vector value = vector(0.0,0.0,0.0)){
  int size = sizeof(id);
  resize_vector(id, size + 1);
  set_vector(id, size, value);
  return (id);
}

int pop_int(int id = nullid) {
  int popped = get_int(id,sizeof(id) - 1);
  resize_int(id,sizeof(id) - 1);
  return (popped);
}

float pop_float(int id = nullid) {
  int popped = get_float(id,sizeof(id) - 1);
  resize_float(id,sizeof(id) - 1);
  return (popped);
}

bool pop_bool(int id = nullid) {
  int popped = get_bool(id,sizeof(id) - 1);
  resize_bool(id,sizeof(id) - 1);
  return (popped);
}

string pop_string(int id = nullid) {
  int popped = get_string(id,sizeof(id) - 1);
  resize_string(id,sizeof(id) - 1);
  return (popped);
}

vector pop_vector(int id = nullid) {
  int popped = get_vector(id,sizeof(id) - 1);
  resize_vector(id,sizeof(id) - 1);
  return (popped);
}

int append_range_int(int id = nullid, range_id = nullid){
  int range_size = sizeof(range_id);
  if (range_size <= 0) return (id);
  int original_size = sizeof(id);
  resize_int(id, original_size + range_size);
  for(int i = 0; < range_size){
    set_int(id, original_size + i, get_int(range_id, i));
  }
  return (id);
}

int append_range_float(int id = nullid, range_id = nullid){
  int range_size = sizeof(range_id);
  if (range_size <= 0) return (id);
  int original_size = sizeof(id);
  resize_float(id, original_size + range_size);
  for(int i = 0; < range_size){
    set_float(id, original_size + i, get_float(range_id, i));
  }
  return (id);
}

int append_range_bool(int id = nullid, range_id = nullid){
  int range_size = sizeof(range_id);
  if (range_size <= 0) return (id);
  int original_size = sizeof(id);
  resize_bool(id, original_size + range_size);
  for(int i = 0; < range_size){
    set_bool(id, original_size + i, get_bool(range_id, i));
  }
  return (id);
}

int append_range_string(int id = nullid, range_id = nullid){
  int range_size = sizeof(range_id);
  if (range_size <= 0) return (id);
  int original_size = sizeof(id);
  resize_string(id, original_size + range_size);
  for(int i = 0; < range_size){
    set_string(id, original_size + i, get_string(range_id, i));
  }
  return (id);
}

int append_range_vector(int id = nullid, range_id = nullid){
  int range_size = sizeof(range_id);
  if (range_size <= 0) return (id);
  int original_size = sizeof(id);
  resize_vector(id, original_size + range_size);
  for(int i = 0; < range_size){
    set_vector(id, original_size + i, get_vector(range_id, i));
  }
  return (id);
}

int insert_int(int id = nullid, int from = nosize){
  int size = sizeof(id);
  if (from < 0 || from > size) from = size;
  resize_int(id, size + 1);
  for(int i = size; > from; ){
    set_int(id, i, get_int(id, i - 1));
    i--;
  }
  return (id);
}

int insert_bool(int id = nullid, int from = nosize){
  int size = sizeof(id);
  if (from < 0 || from > size) from = size;
  resize_bool(id, size + 1);
  for(int i = size; > from; ){
    set_bool(id, i, get_bool(id, i - 1));
    i--;
  }
  return (id);
}

int insert_float(int id = nullid, int from = nosize){
  int size = sizeof(id);
  if (from < 0 || from > size) from = size;
  resize_float(id, size + 1);
  for(int i = size; > from; ){
    set_float(id, i, get_float(id, i - 1));
    i--;
  }
  return (id);
}

int insert_string(int id = nullid, int from = nosize){
  int size = sizeof(id);
  if (from < 0 || from > size) from = size;
  resize_string(id, size + 1);
  for(int i = size; > from; ){
    set_string(id, i, get_string(id, i - 1));
    i--;
  }
  return (id);
}

int insert_vector(int id = nullid, int from = nosize){
  int size = sizeof(id);
  if (from < 0 || from > size) from = size;
  resize_vector(id, size + 1);
  for(int i = size; > from; ){
    set_vector(id, i, get_vector(id, i - 1));
    i--;
  }
  return (id);
}

bool erase_int(int id = nullid, int from = nosize,int to = nosize){
  int size = sizeof(id);
  if (size <= 0) return(false);
  if (from < 0 || from >= size) return(false);

  if (to == -1) {
    if (from == size - 1) {
        resize_int(id, size - 1);
        return(true);
    }

    for(int i = from; < size - 1) {
      set_int(id, i, get_int(id, i + 1));
    }
    resize_int(id, size - 1);
    return(true);
  }

  if (to <= from) return(false);
  if (to > size) to = size;
  int count = to - from;

  if (to == size) {
      resize_int(id, size - count);
      return(true);
  }

  for(int j = from; < size - count){ // shift remaining elements
      set_int(id, j, get_int(id, j + count));
  }
  resize_int(id, size - count);
  return(true);
}

bool erase_bool(int id = nullid, int from = nosize,int to = nosize){
  int size = sizeof(id);
  if (size <= 0) return(false);
  if (from < 0 || from >= size) return(false);

  if (to == -1) {
    if (from == size - 1) {
        resize_bool(id, size - 1);
        return(true);
    }

    for(int i = from; < size - 1) {
      set_bool(id, i, get_bool(id, i + 1));
    }
    resize_bool(id, size - 1);
    return(true);
  }

  if (to <= from) return(false);
  if (to > size) to = size;
  int count = to - from;

  if (to == size) {
      resize_bool(id, size - count);
      return(true);
  }

  for(int j = from; < size - count){ // shift remaining elements
      set_bool(id, j, get_bool(id, j + count));
  }
  resize_bool(id, size - count);
  return(true);
}

bool erase_float(int id = nullid,  int from = nosize,int to = nosize){
  int size = sizeof(id);
  if (size <= 0) return(false);
  if (from < 0 || from >= size) return(false);

  if (to == -1) {
    if (from == size - 1) {
        resize_float(id, size - 1);
        return(true);
    }

    for(int i = from; < size - 1) {
      set_float(id, i, get_float(id, i + 1));
    }
    resize_float(id, size - 1);
    return(true);
  }

  if (to <= from) return(false);
  if (to > size) to = size;
  int count = to - from;

  if (to == size) {
      resize_float(id, size - count);
      return(true);
  }

  for(int j = from; < size - count){ // shift remaining elements
      set_float(id, j, get_float(id, j + count));
  }
  resize_float(id, size - count);
  return(true);

}

bool erase_string(int id = nullid,  int from = nosize,int to = nosize){
  int size = sizeof(id);
  if (size <= 0) return(false);
  if (from < 0 || from >= size) return(false);

  if (to == -1) {
    if (from == size - 1) {
        resize_string(id, size - 1);
        return(true);
    }

    for(int i = from; < size - 1) {
      set_string(id, i, get_string(id, i + 1));
    }
    resize_string(id, size - 1);
    return(true);
  }

  if (to <= from) return(false);
  if (to > size) to = size;
  int count = to - from;

  if (to == size) {
      resize_string(id, size - count);
      return(true);
  }

  for(int j = from; < size - count){ // shift remaining elements
      set_string(id, j, get_string(id, j + count));
  }
  resize_string(id, size - count);
  return(true);

}

bool erase_vector(int id = nullid,  int from = nosize,int to = nosize){
  int size = sizeof(id);
  if (size <= 0) return(false);
  if (from < 0 || from >= size) return(false);

  if (to == -1) {
    if (from == size - 1) {
        resize_vector(id, size - 1);
        return(true);
    }

    for(int i = from; < size - 1) {
      set_vector(id, i, get_vector(id, i + 1));
    }
    resize_vector(id, size - 1);
    return(true);
  }

  if (to <= from) return(false);
  if (to > size) to = size;
  int count = to - from;

  if (to == size) {
      resize_vector(id, size - count);
      return(true);
  }

  for(int j = from; < size - count){ // shift remaining elements
      set_vector(id, j, get_vector(id, j + count));
  }
  resize_vector(id, size - count);
  return(true);

}

int find_int(int id = nullid, int what = nullid) {
  int size = sizeof(id);
  if(size <= 0) return (-1);
  for(idx = 0; < size){
    if(xsArrayGetInt(id,idx) == what) return (idx);
  }
  return (-1)
}

int find_bool(int id = nullid, bool what = nullid) {
  int size = sizeof(id);
  if(size <= 0) return (-1);
  for(idx = 0; < size){
    if(xsArrayGetBool(id,idx) == what) return (idx);
  }
  return (-1)
}

int find_float(int id = nullid, float what = nullid) {
  int size = sizeof(id);
  if(size <= 0) return (-1);
  for(idx = 0; < size){
    if(xsArrayGetFloat(id,idx) == what) return (idx);
  }
  return (-1)
}

int find_string(int id = nullid, string what = nullid) {
  int size = sizeof(id);
  if(size <= 0) return (-1);
  for(idx = 0; < size){
    if(xsArrayGetString(id,idx) == what) return (idx);
  }
  return (-1)
}

int find_vector(int id = nullid, @Vec3@ what = nullid) {
  int size = sizeof(id);
  if(size <= 0) return (-1);
  for(idx = 0; < size){
    if(xsArrayGetVector(id,idx) == what) return (idx);
  }
  return (-1)
}

void swap_int(int id = nullid, int a = nosize, int b = nosize){
  int tmp = xsArrayGetInt(id,a);
  xsArraySetInt(id,a,b);
  xsArraySetInt(id,b,tmp);
}

void swap_float(int id = nullid, int a = nosize, int b = nosize){
  int tmp = xsArrayGetInt(id,a);
  xsArraySetInt(id,a,b);
  xsArraySetInt(id,b,tmp);
}

void swap_bool(int id = nullid, int a = nosize, int b = nosize){
  bool tmp = xsArrayGetBool(id,a);
  xsArraySetBool(id,a,b);
  xsArraySetBool(id,b,tmp);
}

void swap_string(int id = nullid, int a = nosize, int b = nosize){
  string tmp = xsArrayGetString(id,a);
  xsArraySetString(id,a,b);
  xsArraySetString(id,b,tmp);
}

void swap_vector(int id = nullid, int a = nosize, int b = nosize){
  vector tmp = xsArrayGetVector(id,a);
  xsArraySetVector(id,a,b);
  xsArraySetVector(id,b,tmp);
}

int sort_int(int id = nullid, int from = nosize, int to = nosize) {
  if(from < to) {
    int pivot = xsArrayGetInt(to);
    int i = from - 1;
    int swap_holder = 0;
    for(int j = from; < to){
      if(xsArrayGetInt(j) <= pivot){
        i++;
        xsArraySwapInt(id,i,j);
      }
    }
    partition = i + 1;
    xsArraySwapInt(id,partition,to);
    xsArraySortInt(id,from,p - 1);
    xsArraySortInt(id,p + 1, to);
  }
}

int sort_float(int id = nullid, int from = nosize, int to = nosize) {
  if(from < to) {
    float pivot = xsArrayGetFloat(to);
    int i = from - 1;
    float swap_holder = 0;
    for(int j = from; < to){
      if(xsArrayGetFloat(j) <= pivot){
        i++;
        xsArraySwapFloat(id,i,j);
      }
    }
    partition = i + 1;
    xsArraySwapFloat(id,partition,to);
    xsArraySortFloat(id,from,p - 1);
    xsArraySortFloat(id,p + 1, to);
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