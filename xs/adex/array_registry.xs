// Array state enum.
extern const int kArrayState_Live = 0;
extern const int kArrayState_Dead = 1;
extern const int kArrayState_Allocated = 2;

// Array deletion result enum.
extern const int kDeleteResult_OutOfBounds = -1;
extern const int kDeleteResult_AlreadyDeleted = 0;
extern const int kDeleteResult_Success = 1;

// RegA : Registry of Arrays
// Static xsArray ID registry.
// This class ptr should be the first array init, and the last array destroyed.
class __class__RegA {
  const int __size__ = 17;
  // Global array stack.
  // Ever-growing array of arrays(pointers). Arrays in xs cannot be de-allocated.
  // Stdlib manually tracks array and frees slots upon call to `del`.
  //
  // @update: Might not have to store this as an array IF it is guaranteed than every
  //        newly created array is exactly 1 index after the previous and not negative.
  //        Did some tests - this seems to be TRUE!
  // @update2: stored as the id of the last created array.
  int Rbp_ = nullptr;            // Stack base pointer.
  int Rsp_ = nullptr;            // Stack end pointer.
  int Capacity_ = nullptr;       // Auto-extends owned arrays on allocation.
  
  // Array type tracker stack. Arrays cannot change type after creation.
  // Maintains type of all array id types set upon first init of given id.
  int Types_ = nullptr;
  
  // Maintains current array state.
  // @see kArrayState
  int States_ = nullptr;  
  
  // Maintains track of currently dead arrays of each type for recycling. 
  int DeadInts_ = nullptr;
  int DeadBools_ = nullptr;
  int DeadFloats_ = nullptr;    
  int DeadStrings_ = nullptr;   
  int DeadVec3s_ = nullptr;
  
  // Maintain current capacity to auto-extend.
  int DeadIntsSize_ = nullptr;
  int DeadBoolsSize_ = nullptr;
  int DeadFloatsSize_ = nullptr;    
  int DeadStrings_ = nullptr;   
  int DeadVec3s_ = nullptr;                
  
  // OrderedMap : Name->Pointer 
  // Tracks static named arrays. IF an array in XS gets a name then than name 
  // cannot be re-initialized. You cannot find/search an array by name after init.
  // This manually tracks all named arrays, and returns the existing array index
  // upon call of array constructor. Unlike xsArrayCreateXXX, which returns -1 if
  // the named array already exists.
  int Names = nullptr;
  int NameKeys = nullptr;
  
};

// The first array id in the xs program. Reserved by the standard library.
// Always 0.
int RegAStdBase_ = 0;

// Has to be set manually by the stdlib implementer every time we init a xsArray in
// the implementation before initializing this class.
// The stdlib reserved a number of arrays for internal use by the RegA object.
int RegAStdEnd_ = nosize;

// User's base pointer. First array ID created outside of stdlib's implementation.
int RegARbp_ = nosize; 
int RegARsp_ = 0; 
int RegACapacity_ = 1; 

int RegATypes_ = nullptr;
int RegAStates_ = nullptr;

int RegADeadInts_ = nullptr;
int RegADeadBools_ = nullptr;
int RegADeadFloats_ = nullptr;
int RegADeadStrings_ = nullptr;
int RegADeadVec3s_ = nullptr;

int RegADeadIntsSize_ = 0;
int RegADeadBoolsSize_ = 0;
int RegADeadFloatsSize_ = 0;
int RegADeadStringsSize_ = 0;
int RegADeadVec3sSize_ = 0;

int RegANames = 0;
int RegANameKeys = 0;

void __StaticNewRegA() {
  RegATypes_ = xsArrayCreateInt(1);
  RegAStates_ = xsArrayCreateInt(1);
  RegADeadInts_ = xsArrayCreateInt(0);
  RegADeadBools_ = xsArrayCreateInt(0);
  RegADeadFloats_ = xsArrayCreateInt(0);
  RegADeadStrings_ = xsArrayCreateInt(0);
  RegADeadVec3s_ = xsArrayCreateInt(0);
}

mutable bool __StaticDeleteRegA(){
  xsArrayResizeInt(RegATypes_,0);
  xsArrayResizeInt(RegAStates_,0);
  // Preallocate 256 elements.
  xsArrayResizeInt(RegADeadInts_,256);
  xsArrayResizeInt(RegADeadBools_,256);
  xsArrayResizeInt(RegADeadFloats_,256);
  xsArrayResizeInt(RegADeadStrings_,256);
  xsArrayResizeInt(RegADeadVec3s_,256);
  return (true);  
}

int RegAGetArrayIndex(int id = nullptr){
 return (id - RegARbp_);
}

int RegATypeOf(int id = nullptr){
 return (get_int(RegATypes_,RegAGetArrayIndex(id)));
}

int RegAStateOf(int id = nullptr){
 return (get_int(RegAStates_,RegAGetArrayIndex(id)));
}

int RegASetTypeOf(int id = nullptr,int type = required_int){
 return (set_int(RegATypes_, RegAGetArrayIndex(id), type));
}

int RegASetStateOf(int id = nullptr,int state = required_int){
 return (set_int(RegAStates_, RegAGetArrayIndex(id), state));
}

mutable int RegAAllocArray(int type = int_t,int size = 0, string name = ""){
  int newarr = nullptr;
  // Create the xs array.
  switch(type){
   case int_t: newarr = xsArrayCreateInt(size,default_int,name);
   case bool_t: newarr = xsArrayCreateBool(size,default_bool,name);
   case string_t: newarr = xsArrayCreateString(size,default_string,name);
   case float_t: newarr = xsArrayCreateFloat(size,default_float,name);
   case vec3_t: newarr = xsArrayCreateVector(size,default_vec3,name);
  }
  
  // Push typeid and live state (but actually set at rsp because we always auto-extend)

  set_int(RegATypes_,RegARsp_,type);
  set_int(RegAStates_,RegARsp_,kArrayState_Live);
  // Increment rsp
  RegARsp_++;
  // Auto extend types and states arrays when old capacity is reached.
  if(RegARsp_ >= RegACapacity_){
    RegACapacity_ = extend_int(RegATypes_,sizeof(RegATypes_) * 2);
    extend_int(RegAStates_,sizeof(RegATypes_) * 2); // guaranteed to extend same as types
  }

  return (newarr);
}

mutable int RegADeleteArray(int id = nullptr){
  int idx = RegAGetArrayIndex(id);
  if(idx > RegARsp_) return (kDeleteResult_OutOfBounds); 
  if(RegAStateOf(id) == kArrayState_Dead) 
    return (kDeleteResult_AlreadyDeleted); 
  // Clear array based on type.
  int type = get_int(RegATypes_,idx);
  switch(type){
   case int_t: clear_int(id);
   case bool_t: clear_bool(id);
   case string_t: clear_string(id);
   case float_t: clear_float(id);
   case vec3_t: clear_vec3(id);
  }
  // Set array state to dead.
  set_int(RegAStates_,idx,kArrayState_Dead);
  // Store dead array ID
  // We preallocated 256 dead slots for each type. So a push only has to happen
  // if there are more than 256 dead arrays at the moment.(should rarely happen due to recycling.)
  switch(type){
   case int_t: {
    RegADeadIntsSize_++;
    if(RegADeadIntsSize_ <= sizeof(RegADeadInts_))  
      set_int(RegADeadInts_,RegADeadIntsSize_ - 1,id);
    else 
      push_int(RegADeadInts_,id);   
   }
   case bool_t:  {
    RegADeadBoolsSize_++;
    if(RegADeadBoolsSize_ < sizeof(RegADeadBools_))
      set_int(RegADeadBools_,RegADeadBoolsSize_ - 1,id);
    else 
      push_int(RegADeadBools_,id);   
   }
   case string_t:  {
    RegADeadStringsSize_++;
    if(RegADeadStringsSize_ < sizeof(RegADeadStrings_))
      set_int(RegADeadStrings_,RegADeadStringsSize_ - 1,id);
    else 
      push_int(RegADeadStrings_,id);   
   }
   case float_t:  {
    RegADeadFloatsSize_++;
    if(RegADeadFloatsSize_ < sizeof(RegADeadFloats_))
      set_int(RegADeadFloats_,RegADeadFloatsSize_ - 1,id);
    else 
      push_int(RegADeadFloats_,id);   
   }
   case vec3_t:  {
    RegADeadVec3sSize_++;
    if(RegADeadVec3sSize_ < sizeof(RegADeadVec3s_))
      set_int(RegADeadVec3s_,RegADeadVec3sSize_ - 1,id);
    else 
      push_int(RegADeadVec3s_,id);   
   }
  }
  
  return (kDeleteResult_Success);
}

mutable int RegARecycleArray(int type = int_t,int size = 0, string name = ""){
  int id = nullptr;
  int idx = nullptr;
  // Check dead array bank based on given type, and set state live.
  switch(type){
   case int_t: {
    
    if(RegADeadIntsSize_ == 0) return (nullptr); 
    id = get_int(RegADeadInts_,RegADeadIntsSize_ - 1);
    idx = RegAGetArrayIndex(id);
    resize_int(id,size);
    set_int(RegAStates_,idx,kArrayState_Live); 
    if(RegADeadIntsSize_ > 256){
      pop_int(RegADeadInts_);
      RegADeadIntsSize_ = RegADeadIntsSize_ - 1;   
    } else {
      set_int(RegADeadInts_,RegADeadIntsSize_ - 1,nullptr);
      RegADeadIntsSize_ = RegADeadIntsSize_ - 1;
      //debug_print(""+RegADeadIntsSize_,"RegADeadIntsSize_");
    }
   }
   case bool_t: {    
    id = get_int(RegADeadBools_,RegADeadBoolsSize_ - 1);
    idx = RegAGetArrayIndex(id);
    resize_bool(id,size);
    set_int(RegAStates_,idx,kArrayState_Live); 
    if(RegADeadBoolsSize_ > 256){
      pop_int(RegADeadBools_);
      RegADeadBoolsSize_ = RegADeadBoolsSize_ - 1;   
    } else {
      set_int(RegADeadBools_,RegADeadBoolsSize_,nullptr);
      RegADeadBoolsSize_ = RegADeadBoolsSize_ - 1;
    }
   }
   case string_t: {    
    id = get_int(RegADeadStrings_,RegADeadStringsSize_ - 1);
    idx = RegAGetArrayIndex(id);
    resize_string(id,size);
    set_int(RegAStates_,idx,kArrayState_Live); 
    if(RegADeadStringsSize_ > 256){
      pop_int(RegADeadStrings_);
      RegADeadStringsSize_ = RegADeadStringsSize_ - 1;   
    } else {
      set_int(RegADeadStrings_,RegADeadStringsSize_,nullptr);
      RegADeadStringsSize_ = RegADeadStringsSize_ - 1;
    }
   }
   case float_t: {    
    id = get_int(RegADeadFloats_,RegADeadFloatsSize_ - 1);
    idx = RegAGetArrayIndex(id);
    resize_float(id,size);
    set_int(RegAStates_,idx,kArrayState_Live); 
    if(RegADeadFloatsSize_ > 256){
      pop_int(RegADeadFloats_);
      RegADeadFloatsSize_ = RegADeadFloatsSize_ - 1;   
    } else {
      set_int(RegADeadFloats_,RegADeadFloatsSize_,nullptr);
      RegADeadFloatsSize_ = RegADeadFloatsSize_ - 1;
    }
   }
   case vec3_t: {    
    id = get_int(RegADeadVec3s_,RegADeadVec3sSize_ - 1);
    idx = RegAGetArrayIndex(id);
    resize_vec3(id,size);
    set_int(RegAStates_,idx,kArrayState_Live); 
    if(RegADeadVec3sSize_ > 256){
      pop_int(RegADeadVec3s_);
      RegADeadVec3sSize_ = RegADeadVec3sSize_ - 1;   
    } else {
      set_int(RegADeadVec3s_,RegADeadVec3sSize_,nullptr);
      RegADeadVec3sSize_ = RegADeadVec3sSize_ - 1;
    }
   }
  }
  return (id);
}

mutable int RegANewArray(int type = int_t,int size = 0, string name = ""){
  int newarr = RegARecycleArray(type,size,name);

  if(newarr == nullptr) // No array to recycle, allocate new.
    newarr = RegAAllocArray(type,size,name);
  return (newarr);
}


/////////////////////////////////////
// Array class

class __class__Array {
 int id = nullid;
 int type = int_t;
 int size = 0;
}



@VoidArray@ NewArray(int type = int_t, int size = nosize,string name = ""){
  return (RegANewArray(type,size,name));
}

int DeleteArray(int self = nullid){
 return (RegADeleteArray());
}

int ArrayType(int self = nullid){
 return (__gArrayRegister__TypeOf(self));
}

int ArrayState(int self = nullid){
  return (__gArrayRegister__StateOf(self));
}

int ArraySize(int self = nullid){
 return (__gArrayRegister__SizeOf(self));
}

int ArrayCapacity(int self = nullid){
 return (xsArrayGetSize(self));
}

// Increase array capacity by 'amount'. Allocation is performed.
int ArrayExtend(int self = nullid){

}

// Increase array size by arg 'amount'. No new allocation occurs.
int ArrayReserve(int self = nullid, int amount = nosize){

}

int ArraySetInt(int self = nullid){

}

int ArrayAutoExtend(int self = nullid){
 int new_size = ArraySize(self) + 1;
 if(new_size >= ArrayCapacity(self)) return ArrayExtend(self); 
}

int ArrayPushInt(self = nullid,int val = default_int){
 // Check if size reached capacity. If so, extend array by x2,
 // Update new capacity, and increase size by 1.
 // Otherwise we increment size by 1, and set the last element.
 ArrayAutoExtend(self);
 ArrayReserve(self,1);
 ArraySetInt(self,new_size - 1, val); 
}