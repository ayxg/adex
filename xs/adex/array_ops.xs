// xs-language core array operations
@decl@ int sizeof(int ptr = nullptr);

@decl@ int get_int(int ptr = nullptr,int idx = 0);
@decl@ string get_str(int ptr = nullptr,int idx = 0);
@decl@ bool get_bool(int ptr = nullptr,int idx = 0);
@decl@ float get_float(int ptr = nullptr,int idx = 0);

@decl@ int resize_int(int ptr = nullptr, int size = 0);
@decl@ int resize_str(int ptr = nullptr, int size = 0);
@decl@ int resize_bool(int ptr = nullptr, int size = 0);
@decl@ int resize_float(int ptr = nullptr, int size = 0);

@decl@ int set_int(int ptr = nullptr,int idx = 0, int value = 0);
@decl@ int set_str(int ptr = nullptr,int idx = 0, string value = "");
@decl@ int set_bool(int ptr = nullptr,int idx = 0, bool value = false);
@decl@ int set_float(int ptr = nullptr,int idx = 0, float value = 0.0f);

@decl@ int create_int(int size = 0, int fill = 0);
@decl@ int create_str(int size = 0, string fill = "");
@decl@ int create_bool(int size = 0, bool fill = false);
@decl@ int create_float(int size = 0, float fill = 0.0f);

///////////////////////////////////////////////////////////////////////////////////////////////////
// Extended array operations
///////////////////////////////////////////////////////////////////////////////////////////////////

// xsArrayGetSize(id) == 0
@decl@ bool is_empty(int id = nullid);

// id < 0 
@decl@ bool is_nullid(int id = nullid);    

// xsArrayClear[T] : Set array size to 0.
@decl@ void clear_int(int id = nullid);
@decl@ void clear_bool(int id = nullid);
@decl@ void clear_float(int id = nullid);
@decl@ void clear_string(int id = nullid);
@decl@ void clear_vector(int id = nullid);

// get_back_[T]
@decl@ void get_back_int(int id = nullid);
@decl@ void get_back_bool(int id = nullid);
@decl@ void get_back_float(int id = nullid);
@decl@ void get_back_string(int id = nullid);
@decl@ void get_back_vector(int id = nullid);

// get_front_[T]
@decl@ void get_front_int(int id = nullid);
@decl@ void get_front_bool(int id = nullid);
@decl@ void get_front_float(int id = nullid);
@decl@ void get_front_string(int id = nullid);
@decl@ void get_front_vector(int id = nullid);

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
@decl@ bool insert_int(int id = nullid, int from = nosize,int to = nosize);
@decl@ bool insert_bool(int id = nullid, int from = nosize,int to = nosize);
@decl@ bool insert_float(int id = nullid, int from = nosize,int to = nosize);
@decl@ bool insert_string(int id = nullid, int from = nosize,int to = nosize);
@decl@ bool insert_vector(int id = nullid, int from = nosize,int to = nosize);

// insert_[T]
@decl@ bool insert_range_int(int id = nullid, int from = nosize,int to = nosize);
@decl@ bool insert_range_bool(int id = nullid, int from = nosize,int to = nosize);
@decl@ bool insert_range_float(int id = nullid, int from = nosize,int to = nosize);
@decl@ bool insert_range_string(int id = nullid, int from = nosize,int to = nosize);
@decl@ bool insert_range_vector(int id = nullid, int from = nosize,int to = nosize);

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
void swap_int(int id = nullid, int a = nosize, int b = nosize);
void swap_float(int id = nullid, int a = nosize, int b = nosize);
void swap_bool(int id = nullid, int a = nosize, int b = nosize);
void swap_string(int id = nullid, int a = nosize, int b = nosize);
void swap_vector(int id = nullid, int a = nosize, int b = nosize);

///////////////////////////////////////////////////////////////////////////////////////////////////
// Array algorithms
// Search
//  - all_of_[T]
//  - any_of_[T]
//  - none_of_[T]
//  - find_[T]
//  - find_end_[T]
//  - find_first_of_[T]
//  - adjacent_find_[T]
//  - count_[T]
//  - mismatch_[T]
//  - equal_[T]
//  - search_[T]
//  - search_n_[T]
//  - starts_with_[T]
//  - ends_with_[T]
//
// Copy operations
//  - copy_[T]
//  - copy_n_[T]
//  - copy_backward_[T]
//  - move_[T]
//  - move_backward_[T]
//  - swap_ranges_[T]
//
// Generation
//  - fill_[T]
//  - fill_n_[T]
// 
// Removal
//  - unique_[T]
//  - unique_copy_[T]
//
// Order
//  - reverse
//  - reverse_copy
//  - rotate
//  - rotate_copy
//  - shift_left
//  - shift_right
//  - random_shuffle
//  - sample
//  - sort
//  - partial_sort
//  - is_sorted
//  - is_sorted_until
//  - 
///////////////////////////////////////////////////////////////////////////////////////////////////

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

int clear_int(int id = nullid){
  xsArrayResizeInt(id, 0);
}

int clear_string(int id = nullid){
  xsArrayResizeString(id, 0);
}

int clear_bool(int id = nullid){
  xsArrayResizeBool(id, 0);
}

int clear_float(int id = nullid){
  xsArrayResizeFloat(id, 0);
}

int clear_vector(int id = nullid){
  xsArrayResizeVector(id, 0);
}

int extend_int(int id = nullid, int by = 0){
  if(by == 0) xsArrayResizeInt(id,xsArrayGetSize(id) * 2);
  else xsArrayResizeInt(id,xsArrayGetSize(id) + by);
  return (xsArrayGetSize(id));
}

int extend_bool(int id = nullid, int by = 0){
  if(by == 0) xsArrayResizeBool(id,xsArrayGetSize(id) * 2); 
  else xsArrayResizeBool(id,xsArrayGetSize(id) + by);
  return (xsArrayGetSize(id));
}

int extend_float(int id = nullid, int by = 0){
  if(by == 0) xsArrayResizeFloat(id,xsArrayGetSize(id) * 2);
  else xsArrayResizeFloat(id,xsArrayGetSize(id) + by);
  return (xsArrayGetSize(id));
}

int extend_string(int id = nullid, int by = 0){
  if(by == 0) xsArrayResizeString(id,xsArrayGetSize(id) * 2); 
  else xsArrayResizeString(id,xsArrayGetSize(id) + by);
  return (xsArrayGetSize(id));
}

int extend_vector(int id = nullid, int by = 0){
  if(by == 0) xsArrayResizeVector(id,xsArrayGetSize(id) * 2);
  else xsArrayResizeVector(id,xsArrayGetSize(id) + by);
  return (xsArrayGetSize(id));
}

int push_int(int id = nullid, int value = 0){
  int size = xsArrayGetSize(id);
  xsArrayResizeInt(id, size + 1);
  xsArraySetInt(id, size, value);
  return (id);
}

int push_float(int id = nullid, float value = 0.0){
  int size = xsArrayGetSize(id);
  xsArrayResizeFloat(id, size + 1);
  xsArraySetFloat(id, size, value);
  return (id);
}

int push_bool(int id = nullid, bool value = false){
  int size = xsArrayGetSize(id);
  xsArrayResizeBool(id, size + 1);
  xsArraySetBool(id, size, value);
  return (id);
}

int push_string(int id = nullid, string value = ""){
  int size = xsArrayGetSize(id);
  xsArrayResizeString(id, size + 1);
  xsArraySetString(id, size, value);
  return (id);
}

int push_vector(int id = nullid, vector value = vector(0.0,0.0,0.0)){
  int size = xsArrayGetSize(id);
  xsArrayResizeVector(id, size + 1);
  xsArraySetVector(id, size, value);
  return (id);
}

int pop_int(int id = nullid) {
  int popped = xsArrayGetInt(xsArrayGetSize(id) - 1);
  xsArrayResizeInt(id,xsArrayGetSize(id) - 1); 
  return (popped);
}

float pop_float(int id = nullid) {
  int popped = xsArrayGetFloat(xsArrayGetSize(id) - 1);
  xsArrayResizeFloat(id,xsArrayGetSize(id) - 1); 
  return (popped);
}

bool pop_bool(int id = nullid) {
  int popped = xsArrayGetBool(xsArrayGetSize(id) - 1);
  xsArrayResizeBool(id,xsArrayGetSize(id) - 1);
  return (popped);
}

string pop_string(int id = nullid) {
  int popped = xsArrayGetString(xsArrayGetSize(id) - 1); 
  xsArrayResizeString(id,xsArrayGetSize(id) - 1);
  return (popped);
}

vector pop_vector(int id = nullid) { 
  int popped = xsArrayGetVector(xsArrayGetSize(id) - 1);
  xsArrayResizeVector(id,xsArrayGetSize(id) - 1);
  return (popped);
}

bool erase_int(int id = nullid, int from = nosize,int to = nosize){
   int size = xsArrayGetSize(id);
    if (size <= 0) return(false);
    if (from < 0 || from >= size) return(false);

    if (to == -1) {
      if (from == size - 1) {
          xsArrayResizeInt(id, size - 1);
          return(true);
      }
      
      for(int i = from; < size - 1) {
        xsArraySetInt(id, i, xsArrayGetInt(id, i + 1));
      }
      xsArrayResizeInt(id, size - 1);
      return(true);
    }

    if (to <= from) return(false);
    if (to > size) to = size;
    int count = to - from;

    if (to == size) {
        xsArrayResizeInt(id, size - count);
        return(true);
    }
 
    for(int i = from; < size - count){ // shift remaining elements
        xsArraySetInt(id, j, xsArrayGetInt(id, j + count));
    }
    xsArrayResizeInt(id, size - count);
    return(true);
}

bool erase_bool(int id = nullid, int from = nosize,int to = nosize){
  int size = xsArrayGetSize(id);
  if(idx < 0 || idx >= size) return (false);
  while(idx < size){
      xsArraySetBool(id, idx, xsArrayGetBool(id, idx + 1));
      idx++;
  }
  xsArrayResizeBool(id, size - 1);
  return (true);
}

bool erase_float(int id = nullid,  int from = nosize,int to = nosize){
  int size = xsArrayGetSize(id);
  if(idx < 0 || idx >= size) return (false);
  while(idx < size){
      xsArraySetFloat(id, idx, xsArrayGetFloat(id, idx + 1));
      idx++;
  }
  xsArrayResizeFloat(id, size - 1);
  return (true);
}

bool erase_string(int id = nullid,  int from = nosize,int to = nosize){
  int size = xsArrayGetSize(id);
  if(idx < 0 || idx >= size) return (false);
  while(idx < size){
      xsArraySetString(id, idx, xsArrayGetString(id, idx + 1));
      idx++;
  }
  xsArrayResizeString(id, size - 1);
  return (true);
}

bool erase_vector(int id = nullid,  int from = nosize,int to = nosize){
  int size = xsArrayGetSize(id);
  if(idx < 0 || idx >= size) return (false);
  while(idx < size){
      xsArraySetVector(id, idx, xsArrayGetVector(id, idx + 1));
      idx++;
  }
  xsArrayResizeVector(id, size - 1);
  return (true);
}

int find_int(int id = nullid, int what = nullid) {
  int size = xsArrayGetSize(id);
  if(size <= 0) return (-1);
  for(idx = 0; < size){
    if(xsArrayGetInt(id,idx) == what) return (idx);
  }
  return (-1)
} 

int find_bool(int id = nullid, bool what = nullid) {
  int size = xsArrayGetSize(id);
  if(size <= 0) return (-1);
  for(idx = 0; < size){
    if(xsArrayGetBool(id,idx) == what) return (idx);
  }
  return (-1)
}

int find_float(int id = nullid, float what = nullid) {
  int size = xsArrayGetSize(id);
  if(size <= 0) return (-1);
  for(idx = 0; < size){
    if(xsArrayGetFloat(id,idx) == what) return (idx);
  }
  return (-1)
}

int find_string(int id = nullid, string what = nullid) {
  int size = xsArrayGetSize(id);
  if(size <= 0) return (-1);
  for(idx = 0; < size){
    if(xsArrayGetString(id,idx) == what) return (idx);
  }
  return (-1)
}

int find_vector(int id = nullid, @Vec3@ what = nullid) {
  int size = xsArrayGetSize(id);
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