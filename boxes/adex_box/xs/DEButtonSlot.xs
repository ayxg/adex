///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright 2025 Anton Yashchenko
// Licensed under the MIT License.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// @project: Anton's AOE2 DE XS Script Extensions
// @author(s): Anton Yashchenko (Steam Name: Dave East Jones)
// @website: https://www.acpp.dev
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// @file DEButtonSlot.xs
/// @brief Button slot location enumeration. Seperated by [C]civilian or [M]military tab and location.
///
/// 	┌────────────┬────────────┬────────────┬────────────┬────────────┐
/// 	│   0        │   1        │   2        │   3        │  4         │
/// 	├────────────┼────────────┼────────────┼────────────┼────────────┤
/// 	│   5        │   6        │   7        │   8        │  9         │
/// 	├────────────┼────────────┼────────────┼────────────┼────────────┤
/// 	│   10       │   11       │   12       │   13       │            │
/// 	└────────────┴────────────┴────────────┴────────────┴────────────┘
///
/// !! Actual in-game Button Slot IDs of DE
/// 	"The button locations are incorrect when using the 'Change Research Location' 
/// 	and “Change Train Location” effects. Numbers > 28 (tested until 34) don’t do anything.
/// 	The last one isn’t even possible. 0 - 28 supported." 
/// 	┌────────────┬────────────┬────────────┬────────────┬────────────┐
/// 	│  0,  1, 15 │   2, 16    │   3, 17    │   4, 18    │   5, 19    │
/// 	├────────────┼────────────┼────────────┼────────────┼────────────┤
/// 	│   6, 20    │   7, 21    │   8, 22    │   9, 23    │  10, 24    │
/// 	├────────────┼────────────┼────────────┼────────────┼────────────┤
/// 	│  11, 25    │  12, 26    │  13, 27    │  14, 28    │            │
/// 	└────────────┴────────────┴────────────┴────────────┴────────────┘
/// @ref https://forums.ageofempires.com/t/effects-change-train-research-location-button-locations-incorrect-not-fixed-with-update-37650/82978 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Civilian
extern const int DEButtonSlot_C0 = 1;
extern const int DEButtonSlot_C1 = 2;
extern const int DEButtonSlot_C2 = 3;
extern const int DEButtonSlot_C3 = 4;
extern const int DEButtonSlot_C4 = 5;
extern const int DEButtonSlot_C5 = 6;
extern const int DEButtonSlot_C6 = 7;
extern const int DEButtonSlot_C7 = 8;
extern const int DEButtonSlot_C8 = 9;
extern const int DEButtonSlot_C9 = 10;
extern const int DEButtonSlot_C10 = 11;
extern const int DEButtonSlot_C11 = 12;
extern const int DEButtonSlot_C12 = 13;
extern const int DEButtonSlot_C13 = 14;

// Military
extern const int DEButtonSlot_M0 = 15;
extern const int DEButtonSlot_M1 = 16;
extern const int DEButtonSlot_M2 = 17;
extern const int DEButtonSlot_M3 = 18;
extern const int DEButtonSlot_M4 = 19;
extern const int DEButtonSlot_M5 = 20;
extern const int DEButtonSlot_M6 = 21;
extern const int DEButtonSlot_M7 = 22;
extern const int DEButtonSlot_M8 = 23;
extern const int DEButtonSlot_M9 = 24;
extern const int DEButtonSlot_M10 = 25;
extern const int DEButtonSlot_M11 = 26;
extern const int DEButtonSlot_M12 = 27;
extern const int DEButtonSlot_M13 = 28;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// @project: Anton's AOE2 DE XS Script Extensions
// @author(s): Anton Yashchenko
// @website: https://www.acpp.dev
// @created: 2025/08/05
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
