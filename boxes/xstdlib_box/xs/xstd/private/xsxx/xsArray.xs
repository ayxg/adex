// XS Language Implicit xsArray Operations
@pragma-internal-implicit@ int xsArrayCreateBool(int size = -1, bool defaultValue = false, string uniqueName = "");
@pragma-internal-implicit@ int xsArrayCreateFloat(int size = -1, float defaultValue = -1.0, string uniqueName = "");
@pragma-internal-implicit@ int xsArrayCreateInt(int size = -1, int defaultValue = -1, string uniqueName = "");
@pragma-internal-implicit@ int xsArrayCreateString(int size = -1, string defaultValue = "", string uniqueName = "");
@pragma-internal-implicit@ int xsArrayCreateVector(int size = -1, vector defaultValue = vector(-1, -1, -1), string uniqueName = "");
@pragma-internal-implicit@ bool xsArrayGetBool(int arrayId = nullid, int index = -1);
@pragma-internal-implicit@ float xsArrayGetFloat(int arrayId = nullid, int index = -1);
@pragma-internal-implicit@ int xsArrayGetInt(int arrayId = nullid, int index = -1);
@pragma-internal-implicit@ int xsArrayGetSize(int arrayId = nullid);
@pragma-internal-implicit@ string xsArrayGetString(int arrayId = nullid, int index = -1);
@pragma-internal-implicit@ vector xsArrayGetVector(int arrayId = nullid, int index = -1);
@pragma-internal-implicit@ int xsArrayResizeBool(int arrayId = nullid, int newSize = -1);
@pragma-internal-implicit@ int xsArrayResizeFloat(int arrayId = nullid, int newSize = -1);
@pragma-internal-implicit@ int xsArrayResizeInt(int arrayId = nullid, int newSize = -1);
@pragma-internal-implicit@ int xsArrayResizeString(int arrayId = nullid, int newSize = -1);
@pragma-internal-implicit@ int xsArrayResizeVector(int arrayId = nullid, int newSize = -1);
@pragma-internal-implicit@ int xsArraySetBool(int arrayId = nullid, int index = -1, bool value = false);
@pragma-internal-implicit@ int xsArraySetFloat(int arrayId = nullid, int index = -1, float value = -1.0);
@pragma-internal-implicit@ int xsArraySetInt(int arrayId = nullid, int index = -1, int value = -1);
@pragma-internal-implicit@ int xsArraySetString(int arrayId = nullid, int index = -1, string value = "");
@pragma-internal-implicit@ int xsArraySetVector(int arrayId = nullid, int index = -1, vector value = vector(-1, -1, -1));

// Anton's XS Extensions xsArray Operations
mutable bool xsArrayIsEmpty(int arrayId = nullid) @fn-virtual-bool@ // xsArrayGetSize(arrayId) == 0
mutable bool xsArrayIsNull(int arrayId = nullid) @fn-virtual-bool@  // arrayId < 0
// xsArrayErase[T] 
//  : Erase element at index, re-align vector elements and resize.
mutable bool xsArrayErase(int arrayId = nullid, int begin = nullid,int end = nullid)  @fn-virtual-bool@
// xsArrayClear[T] 
//  : Set array size to 0.
mutable int xsArrayClearInt(int arrayId = nullid) @fn-virtual-int@
mutable int xsArrayClearString(int arrayId = nullid) @fn-virtual-int@
mutable int xsArrayClearBool(int arrayId = nullid) @fn-virtual-int@
mutable int xsArrayClearFloat(int arrayId = nullid) @fn-virtual-int@
mutable int xsArrayClearVector(int arrayId = nullid) @fn-virtual-int@
// xsArrayPush[T] 
//  : Increase array size by 1 and set last element. !!Extend first, then set new elements for more efficient insertion.
mutable int xsArrayPushInt(int arrayId = nullid, int value = 0) @fn-virtual-int@
mutable int xsArrayPushString(int arrayId = nullid, string value = "") @fn-virtual-int@
mutable int xsArrayPushBool(int arrayId = nullid, bool value = false) @fn-virtual-int@
mutable int xsArrayPushFloat(int arrayId = nullid, float value = 0.0) @fn-virtual-int@
mutable int xsArrayPushVector(int arrayId = nullid, vector value = vector(0.0,0.0,0.0)) @fn-virtual-int@
// xsArrayPop[T] 
//  : Reduce array size by 1.
mutable int xsArrayPopInt(int arrayId = nullid) @fn-virtual-int@
mutable int xsArrayPopString(int arrayId = nullid) @fn-virtual-int@
mutable int xsArrayPopBool(int arrayId = nullid) @fn-virtual-int@
mutable int xsArrayPopFloat(int arrayId = nullid) @fn-virtual-int@
mutable int xsArrayPopVector(int arrayId = nullid) @fn-virtual-int@
// xsArrayErase[T] 
//    : Erase elements from index [from...to - 1]. Re-align all other elements and shrink array to fit.
//      No re-alignment occurs if elements are a range from the end of the array.
//      If arg 'to' is not set. Erases element at index arg 'from'.
bool xsArrayEraseInt(int arrayId = nullid, int from = nosize,int to = nosize)@fn-virtual-bool@
bool xsArrayEraseBool(int arrayId = nullid, int from = nosize,int to = nosize)@fn-virtual-bool@
bool xsArrayEraseFloat(int arrayId = nullid, int from = nosize,int to = nosize)@fn-virtual-bool@
bool xsArrayEraseString(int arrayId = nullid, int from = nosize,int to = nosize)@fn-virtual-bool@
bool xsArrayEraseVector(int arrayId = nullid, int from = nosize,int to = nosize)@fn-virtual-bool@
// xsArrayExtend[T] 
//    : Increase array size by arg 'by', given no 'by' array size doubles. Returns new array size.
mutable int xsArrayExtendInt(int arrayId = nullid, int by = nullid) @fn-virtual-int@
mutable int xsArrayExtendBool(int arrayId = nullid, int by = nullid) @fn-virtual-int@
mutable int xsArrayExtendFloat(int arrayId = nullid, int by = nullid) @fn-virtual-int@
mutable int xsArrayExtendString(int arrayId = nullid, int by = nullid) @fn-virtual-int@
mutable int xsArrayExtendVector(int arrayId = nullid, int by = nullid) @fn-virtual-int@


int xsArrayClearInt(int arrayId = nullid, int size = 0){
  return (xsArrayResizeInt(arrayId, 0));
}

int xsArrayClearString(int arrayId = nullid, int size = 0){
  return (xsArrayResizeString(arrayId, 0));
}

int xsArrayClearBool(int arrayId = nullid, int size = 0){
  return (xsArrayResizeBool(arrayId, 0));
}

int xsArrayClearFloat(int arrayId = nullid, int size = 0){
  return (xsArrayResizeFloat(arrayId, 0));
}

int xsArrayClearVector(int arrayId = nullid, int size = 0){
  return (xsArrayResizeVector(arrayId, 0));
}

bool xsArrayIsNull(int arrayId = nullid){
  return (arrayId < 0);
}

bool xsArrayIsEmpty(int arrayId = nullid){
  return (xsArrayGetSize(arrayId) == 0);
}

int xsArrayPushInt(int arrayId = nullid, int value = 0){
  int size = xsArrayGetSize(arrayId);
  xsArrayResizeInt(arrayId, size + 1);
  return (xsArraySetInt(arrayId, size, value));
}

int xsArrayPushFloat(int arrayId = nullid, float value = 0.0){
  int size = xsArrayGetSize(arrayId);
  xsArrayResizeFloat(arrayId, size + 1);
  return (xsArraySetFloat(arrayId, size, value));
}

int xsArrayPushBool(int arrayId = nullid, bool value = false){
  int size = xsArrayGetSize(arrayId);
  xsArrayResizeBool(arrayId, size + 1);
  return (xsArraySetBool(arrayId, size, value));
}

int xsArrayPushString(int arrayId = nullid, string value = ""){
  int size = xsArrayGetSize(arrayId);
  xsArrayResizeString(arrayId, size + 1);
  return (xsArraySetString(arrayId, size, value));
}

int xsArrayPushVector(int arrayId = nullid, vector value = vector(0.0,0.0,0.0)){
  int size = xsArrayGetSize(arrayId);
  xsArrayResizeVector(arrayId, size + 1);
  return (xsArraySetVector(arrayId, size, value));
}

int xsArrayPopInt(int arrayId = nullid) { 
  return (xsArrayResizeInt(arrayId,xsArrayGetSize(arrayId) - 1));
}

int xsArrayPopString(int arrayId = nullid) { 
  return (xsArrayResizeString(arrayId,xsArrayGetSize(arrayId) - 1));
}

int xsArrayPopBool(int arrayId = nullid) { 
  return (xsArrayResizeBool(arrayId,xsArrayGetSize(arrayId) - 1));
}

int xsArrayPopFloat(int arrayId = nullid) { 
  return (xsArrayResizeFloat(arrayId,xsArrayGetSize(arrayId) - 1));
}

int xsArrayPopVector(int arrayId = nullid) { 
  return (xsArrayResizeVector(arrayId,xsArrayGetSize(arrayId) - 1));
}

bool xsArrayEraseInt(int arrayId = nullid, int from = nosize,int to = nosize){
  int size = xsArrayGetSize(arrayId);
  if(idx < 0 || idx >= size) return (false);
  while(idx < size){
      xsArraySetInt(arrayId, idx, xsArrayGetInt(arrayId,idx + 1));
      idx++;
  }
  xsArrayResizeInt(arrayId, size - 1);
  return (true);
}

bool xsArrayEraseBool(int arrayId = nullid, int from = nosize,int to = nosize){
  int size = xsArrayGetSize(arrayId);
  if(idx < 0 || idx >= size) return (false);
  while(idx < size){
      xsArraySetBool(arrayId, idx, xsArrayGetBool(arrayId, idx + 1));
      idx++;
  }
  xsArrayResizeBool(arrayId, size - 1);
  return (true);
}

bool xsArrayEraseFloat(int arrayId = nullid,  int from = nosize,int to = nosize){
  int size = xsArrayGetSize(arrayId);
  if(idx < 0 || idx >= size) return (false);
  while(idx < size){
      xsArraySetFloat(arrayId, idx, xsArrayGetFloat(arrayId, idx + 1));
      idx++;
  }
  xsArrayResizeFloat(arrayId, size - 1);
  return (true);
}

bool xsArrayEraseString(int arrayId = nullid,  int from = nosize,int to = nosize){
  int size = xsArrayGetSize(arrayId);
  if(idx < 0 || idx >= size) return (false);
  while(idx < size){
      xsArraySetString(arrayId, idx, xsArrayGetString(arrayId, idx + 1));
      idx++;
  }
  xsArrayResizeString(arrayId, size - 1);
  return (true);
}

bool xsArrayEraseVector(int arrayId = nullid,  int from = nosize,int to = nosize){
  int size = xsArrayGetSize(arrayId);
  if(idx < 0 || idx >= size) return (false);
  while(idx < size){
      xsArraySetVector(arrayId, idx, xsArrayGetVector(arrayId, idx + 1));
      idx++;
  }
  xsArrayResizeVector(arrayId, size - 1);
  return (true);
}

int xsArrayExtendInt(int arrayId = nullid, int by = -1){
  if(by == -1) xsArrayResizeInt(arrayId,xsArrayGetSize(arrayId) * 2); // Auto-extend by x2.
  else xsArrayResizeInt(arrayId,xsArrayGetSize(arrayId) + by);
  return (xsArrayGetSize(arrayId));
}

int xsArrayExtendBool(int arrayId = nullid, int by = -1){
  if(by == -1) xsArrayResizeBool(arrayId,xsArrayGetSize(arrayId) * 2); // Auto-extend by x2.
  else xsArrayResizeBool(arrayId,xsArrayGetSize(arrayId) + by);
  return (xsArrayGetSize(arrayId));
}

int xsArrayExtendFloat(int arrayId = nullid, int by = -1){
  if(by == -1) xsArrayResizeFloat(arrayId,xsArrayGetSize(arrayId) * 2); // Auto-extend by x2.
  else xsArrayResizeFloat(arrayId,xsArrayGetSize(arrayId) + by);
  return (xsArrayGetSize(arrayId));
}

int xsArrayExtendString(int arrayId = nullid, int by = -1){
  if(by == -1) xsArrayResizeString(arrayId,xsArrayGetSize(arrayId) * 2); // Auto-extend by x2.
  else xsArrayResizeString(arrayId,xsArrayGetSize(arrayId) + by);
  return (xsArrayGetSize(arrayId));
}

int xsArrayExtendVector(int arrayId = nullid, int by = -1){
  if(by == -1) xsArrayResizeVector(arrayId,xsArrayGetSize(arrayId) * 2); // Auto-extend by x2.
  else xsArrayResizeVector(arrayId,xsArrayGetSize(arrayId) + by);
  return (xsArrayGetSize(arrayId));
}
