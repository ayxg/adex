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
/// @brief Implicit XS language math functions. For reference ONLY, do not #include.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "xxPredef.xs"  

@__IMPLICIT__@ float abs(float x = -1.0);
@__IMPLICIT__@ float acos(float x = -1.0);
@__IMPLICIT__@ float asin(float x = -1.0);
@__IMPLICIT__@ float atan(float x = -1.0);
@__IMPLICIT__@ float atan2(float y = -1.0, float x = -1.0);
@__IMPLICIT__@ float atan2v(vector v = vector(-1, -1, -1));
@__IMPLICIT__@ float bitCastToFloat(int number = -1);
@__IMPLICIT__@ int bitCastToInt(float number = -1.0);
@__IMPLICIT__@ float ceil(float x = -1.0);
@__IMPLICIT__@ float cos(float x = -1.0);
@__IMPLICIT__@ float exp(float x = -1.0);
@__IMPLICIT__@ float floor(float x = -1.0);
@__IMPLICIT__@ float pow(float x = -1.0, float y = -1.0);
@__IMPLICIT__@ float sin(float x = -1.0);
@__IMPLICIT__@ float sqrt(float x = -1.0);
@__IMPLICIT__@ float tan(float x = -1.0);
@__IMPLICIT__@ int xsCeilToInt(float value = -1.0);


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