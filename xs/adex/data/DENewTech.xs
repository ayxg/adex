///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright 2025 Anton Yashchenko
// Licensed under the MIT License.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// @project: Anton's AOE2 DE XS Script Extensions
// @author(s): Anton Yashchenko (Steam Name: Dave East Jones)
// @website: https://www.acpp.dev
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// @file DENewTechArr.xs
/// @brief A list of unused in-game techs which have no effect. Listed as "New Research" or "New Technology"
///		   in the Genie editor. Can be used for custom scnario technologies without overriding any of the
///		   used techs. 
/// This list does not include the "Blank Technology"s or "Placeholder Technology"s which are visible in the editor. 
/// These "new" techs are not visible in the editor's trigger list. To be able to affect them with triggers from the
///	editor you must use the Scenario Editor Python Parser, check on github.
///
///	!! I tried to make the techs visible in the editor with a mod but failed, if anyone knows how...
///	   Attempted to : "set Full Tech Mode: 15", "set Lang File Id to existing tech/modded string", 
//					  "set required tech to dupl.Dark Age", "completley copy all data of another tech"		
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// name : "DENewTechArr"
extern int DENewTechArr = -1;
extern const int DENewTechArrSize = 124;
extern const int DENewTechArrBack = 123; // DENewTechCount - 1

int DENewTechArrInit(){
  if(DENewTechArr == -1){
    DENewTechArr = xsArrayCreateInt(DENewTechArrSize, 0, "DENewTechArr");
    xsArraySetInt(DENewTechArr, 0, 0);
    xsArraySetInt(DENewTechArr, 1, 18);
    xsArraySetInt(DENewTechArr, 2, 73);
    xsArraySetInt(DENewTechArr, 3, 78);
    xsArraySetInt(DENewTechArr, 4, 79);
    xsArraySetInt(DENewTechArr, 5, 86);
    xsArraySetInt(DENewTechArr, 6, 88);
    xsArraySetInt(DENewTechArr, 7, 89);
    xsArraySetInt(DENewTechArr, 8, 91);
    xsArraySetInt(DENewTechArr, 9, 92);
    xsArraySetInt(DENewTechArr, 10, 97);
    xsArraySetInt(DENewTechArr, 11, 105);
    xsArraySetInt(DENewTechArr, 12, 111);
    xsArraySetInt(DENewTechArr, 13, 119);
    xsArraySetInt(DENewTechArr, 14, 121);
    xsArraySetInt(DENewTechArr, 15, 133);
    xsArraySetInt(DENewTechArr, 16, 136);
    xsArraySetInt(DENewTechArr, 17, 139);
    xsArraySetInt(DENewTechArr, 18, 141);
    xsArraySetInt(DENewTechArr, 19, 145);
    xsArraySetInt(DENewTechArr, 20, 163);
    xsArraySetInt(DENewTechArr, 21, 164);
    xsArraySetInt(DENewTechArr, 22, 165);
    xsArraySetInt(DENewTechArr, 23, 167);
    xsArraySetInt(DENewTechArr, 24, 168);
    xsArraySetInt(DENewTechArr, 25, 169);
    xsArraySetInt(DENewTechArr, 26, 170);
    xsArraySetInt(DENewTechArr, 27, 171);
    xsArraySetInt(DENewTechArr, 28, 173);
    xsArraySetInt(DENewTechArr, 29, 174);
    xsArraySetInt(DENewTechArr, 30, 176);
    xsArraySetInt(DENewTechArr, 31, 177);
    xsArraySetInt(DENewTechArr, 32, 179);
    xsArraySetInt(DENewTechArr, 33, 181);
    xsArraySetInt(DENewTechArr, 34, 183);
    xsArraySetInt(DENewTechArr, 35, 184);
    xsArraySetInt(DENewTechArr, 36, 185);
    xsArraySetInt(DENewTechArr, 37, 191);
    xsArraySetInt(DENewTechArr, 38, 193);
    xsArraySetInt(DENewTechArr, 39, 195);
    xsArraySetInt(DENewTechArr, 40, 196);
    xsArraySetInt(DENewTechArr, 41, 198);
    xsArraySetInt(DENewTechArr, 42, 205);
    xsArraySetInt(DENewTechArr, 43, 206);
    xsArraySetInt(DENewTechArr, 44, 208);
    xsArraySetInt(DENewTechArr, 45, 214);
    xsArraySetInt(DENewTechArr, 46, 229);
    xsArraySetInt(DENewTechArr, 47, 245);
    xsArraySetInt(DENewTechArr, 48, 247);
    xsArraySetInt(DENewTechArr, 49, 248);
    xsArraySetInt(DENewTechArr, 50, 250);
    xsArraySetInt(DENewTechArr, 51, 251);
    xsArraySetInt(DENewTechArr, 52, 253);
    xsArraySetInt(DENewTechArr, 53, 293);
    xsArraySetInt(DENewTechArr, 54, 294);
    xsArraySetInt(DENewTechArr, 55, 296);
    xsArraySetInt(DENewTechArr, 56, 297);
    xsArraySetInt(DENewTechArr, 57, 331);
    xsArraySetInt(DENewTechArr, 58, 338);
    xsArraySetInt(DENewTechArr, 59, 356);
    xsArraySetInt(DENewTechArr, 60, 442);
    xsArraySetInt(DENewTechArr, 61, 443);
    xsArraySetInt(DENewTechArr, 62, 444);
    xsArraySetInt(DENewTechArr, 63, 469);
    xsArraySetInt(DENewTechArr, 64, 612);
    xsArraySetInt(DENewTechArr, 65, 798);
    xsArraySetInt(DENewTechArr, 66, 799);
    xsArraySetInt(DENewTechArr, 67, 812);
    xsArraySetInt(DENewTechArr, 68, 813);
    xsArraySetInt(DENewTechArr, 69, 814);
    xsArraySetInt(DENewTechArr, 70, 815);
    xsArraySetInt(DENewTechArr, 71, 816);
    xsArraySetInt(DENewTechArr, 72, 817);
    xsArraySetInt(DENewTechArr, 73, 818);
    xsArraySetInt(DENewTechArr, 74, 819);
    xsArraySetInt(DENewTechArr, 75, 820);
    xsArraySetInt(DENewTechArr, 76, 821);
    xsArraySetInt(DENewTechArr, 77, 985);
    xsArraySetInt(DENewTechArr, 78, 987);
    xsArraySetInt(DENewTechArr, 79, 989);
    xsArraySetInt(DENewTechArr, 80, 1027);
    xsArraySetInt(DENewTechArr, 81, 1029);
    xsArraySetInt(DENewTechArr, 82, 1101);
    xsArraySetInt(DENewTechArr, 83, 1102);
    xsArraySetInt(DENewTechArr, 84, 1104);
    xsArraySetInt(DENewTechArr, 85, 1105);
    xsArraySetInt(DENewTechArr, 86, 1106);
    xsArraySetInt(DENewTechArr, 87, 1107);
    xsArraySetInt(DENewTechArr, 88, 1108);
    xsArraySetInt(DENewTechArr, 89, 1109);
    xsArraySetInt(DENewTechArr, 90, 1117);
    xsArraySetInt(DENewTechArr, 91, 1118);
    xsArraySetInt(DENewTechArr, 92, 1119);
    xsArraySetInt(DENewTechArr, 93, 1159);
    xsArraySetInt(DENewTechArr, 94, 1156);
    xsArraySetInt(DENewTechArr, 95, 1157);
    xsArraySetInt(DENewTechArr, 96, 1168);
    xsArraySetInt(DENewTechArr, 97, 1172);
    xsArraySetInt(DENewTechArr, 98, 1178);
    xsArraySetInt(DENewTechArr, 99, 1190);
    xsArraySetInt(DENewTechArr, 100, 1191);
    xsArraySetInt(DENewTechArr, 101, 1192);
    xsArraySetInt(DENewTechArr, 102, 1193);
    xsArraySetInt(DENewTechArr, 103, 1219);
    xsArraySetInt(DENewTechArr, 104, 1227);
    xsArraySetInt(DENewTechArr, 105, 1228);
    xsArraySetInt(DENewTechArr, 106, 1229);
    xsArraySetInt(DENewTechArr, 107, 1231);
    xsArraySetInt(DENewTechArr, 108, 1232);
    xsArraySetInt(DENewTechArr, 109, 1233);
    xsArraySetInt(DENewTechArr, 110, 1234);
    xsArraySetInt(DENewTechArr, 111, 1235);
    xsArraySetInt(DENewTechArr, 112, 1236);
    xsArraySetInt(DENewTechArr, 113, 1237);
    xsArraySetInt(DENewTechArr, 114, 1238);
    xsArraySetInt(DENewTechArr, 115, 1239);
    xsArraySetInt(DENewTechArr, 116, 1250);
    xsArraySetInt(DENewTechArr, 117, 1251);
    xsArraySetInt(DENewTechArr, 118, 1252);
    xsArraySetInt(DENewTechArr, 119, 1253);
    xsArraySetInt(DENewTechArr, 120, 1254);
    xsArraySetInt(DENewTechArr, 121, 1255);
    xsArraySetInt(DENewTechArr, 122, 1256);
    xsArraySetInt(DENewTechArr, 123, 1257);  
  }
  return (DENewTechArr);
}

/// Get an unused technology id, idx must be from 0 to DENewTechArrBack (inclusive)
/// !! MUST call `DENewTechArrInit` before calling `DENewTech`
int DENewTech(int idx){
  return xsArrayGetInt(DENewTechArr, idx);
}

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
