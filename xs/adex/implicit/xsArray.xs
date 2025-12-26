///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright 2025 Anton Yashchenko
// Licensed under the MIT License.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// @project: Anton's AOE2 DE XS Script Extensions
// @author(s): Anton Yashchenko (Steam Name: DEJ)
// @website: https://www.acpp.dev
// @created: 2025/08/03
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// @file xsConstants.xs
/// @brief Implicit XS language xsArray Operations. For reference ONLY, do not #include.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "xxPredef.xs"  

@__IMPLICIT__@ int xsArrayCreateBool(int size = -1, bool defaultValue = false, string uniqueName = "");
@__IMPLICIT__@ int xsArrayCreateFloat(int size = -1, float defaultValue = -1.0, string uniqueName = "");
@__IMPLICIT__@ int xsArrayCreateInt(int size = -1, int defaultValue = -1, string uniqueName = "");
@__IMPLICIT__@ int xsArrayCreateString(int size = -1, string defaultValue = "", string uniqueName = "");
@__IMPLICIT__@ int xsArrayCreateVector(int size = -1, vector defaultValue = vector(-1, -1, -1), string uniqueName = "");
@__IMPLICIT__@ bool xsArrayGetBool(int arrayId = nullid, int index = -1);
@__IMPLICIT__@ float xsArrayGetFloat(int arrayId = nullid, int index = -1);
@__IMPLICIT__@ int xsArrayGetInt(int arrayId = nullid, int index = -1);
@__IMPLICIT__@ int xsArrayGetSize(int arrayId = nullid);
@__IMPLICIT__@ string xsArrayGetString(int arrayId = nullid, int index = -1);
@__IMPLICIT__@ vector xsArrayGetVector(int arrayId = nullid, int index = -1);
@__IMPLICIT__@ int xsArrayResizeBool(int arrayId = nullid, int newSize = -1);
@__IMPLICIT__@ int xsArrayResizeFloat(int arrayId = nullid, int newSize = -1);
@__IMPLICIT__@ int xsArrayResizeInt(int arrayId = nullid, int newSize = -1);
@__IMPLICIT__@ int xsArrayResizeString(int arrayId = nullid, int newSize = -1);
@__IMPLICIT__@ int xsArrayResizeVector(int arrayId = nullid, int newSize = -1);
@__IMPLICIT__@ int xsArraySetBool(int arrayId = nullid, int index = -1, bool value = false);
@__IMPLICIT__@ int xsArraySetFloat(int arrayId = nullid, int index = -1, float value = -1.0);
@__IMPLICIT__@ int xsArraySetInt(int arrayId = nullid, int index = -1, int value = -1);
@__IMPLICIT__@ int xsArraySetString(int arrayId = nullid, int index = -1, string value = "");
@__IMPLICIT__@ int xsArraySetVector(int arrayId = nullid, int index = -1, vector value = vector(-1, -1, -1));

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