///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright 2025 Anton Yashchenko
// Licensed under the MIT License.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// @project: Anton's AOE2 DE XS Script Extensions
// @author(s): Anton Yashchenko (Steam Name: Dave East Jones)
// @website: https://www.acpp.dev
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// @file DENewTechArray.xs
/// @brief A list of unused in-game resources which have no effect. Listed as "Unsused" in the editor.
///	
/// !! MUST call `DENewResArrInit` before calling `DENewRes` 	
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// name : "DENewResArr"
extern int DENewResArr = -1;
extern const int DENewResArrSize = 219;
extern const int DENewResArrBack = 218; // DENewResArrSize - 1

int DENewResArrInit(){
  if(DENewResArr == -1){
    DENewResArr = xsArrayCreateInt(DENewResArrSize, 0, "DENewResArr");

    xsArraySetInt(DENewResArray, 0, 5);
    xsArraySetInt(DENewResArray, 1, 29);
    xsArraySetInt(DENewResArray, 2, 38);
    xsArraySetInt(DENewResArray, 3, 69);
    xsArraySetInt(DENewResArray, 4, 70);
    xsArraySetInt(DENewResArray, 5, 71);
    xsArraySetInt(DENewResArray, 6, 72);
    xsArraySetInt(DENewResArray, 7, 73);
    xsArraySetInt(DENewResArray, 8, 74);
    xsArraySetInt(DENewResArray, 9, 75);
    xsArraySetInt(DENewResArray, 10, 76);
    xsArraySetInt(DENewResArray, 11, 102);
    xsArraySetInt(DENewResArray, 12, 103);
    xsArraySetInt(DENewResArray, 13, 104);
    xsArraySetInt(DENewResArray, 14, 105);
    xsArraySetInt(DENewResArray, 15, 106);
    xsArraySetInt(DENewResArray, 16, 107);
    xsArraySetInt(DENewResArray, 17, 108);
    xsArraySetInt(DENewResArray, 18, 109);
    xsArraySetInt(DENewResArray, 19, 110);
    xsArraySetInt(DENewResArray, 20, 111);
    xsArraySetInt(DENewResArray, 21, 112);
    xsArraySetInt(DENewResArray, 22, 113);
    xsArraySetInt(DENewResArray, 23, 114);
    xsArraySetInt(DENewResArray, 24, 115);
    xsArraySetInt(DENewResArray, 25, 116);
    xsArraySetInt(DENewResArray, 26, 117);
    xsArraySetInt(DENewResArray, 27, 118);
    xsArraySetInt(DENewResArray, 28, 119);
    xsArraySetInt(DENewResArray, 29, 120);
    xsArraySetInt(DENewResArray, 30, 121);
    xsArraySetInt(DENewResArray, 31, 122);
    xsArraySetInt(DENewResArray, 32, 123);
    xsArraySetInt(DENewResArray, 33, 124);
    xsArraySetInt(DENewResArray, 34, 125);
    xsArraySetInt(DENewResArray, 35, 126);
    xsArraySetInt(DENewResArray, 36, 127);
    xsArraySetInt(DENewResArray, 37, 128);
    xsArraySetInt(DENewResArray, 38, 129);
    xsArraySetInt(DENewResArray, 39, 130);
    xsArraySetInt(DENewResArray, 40, 131);
    xsArraySetInt(DENewResArray, 41, 132);
    xsArraySetInt(DENewResArray, 42, 133);
    xsArraySetInt(DENewResArray, 43, 136);
    xsArraySetInt(DENewResArray, 44, 137);
    xsArraySetInt(DENewResArray, 45, 138);
    xsArraySetInt(DENewResArray, 46, 139);
    xsArraySetInt(DENewResArray, 47, 140);
    xsArraySetInt(DENewResArray, 48, 141);
    xsArraySetInt(DENewResArray, 49, 142);
    xsArraySetInt(DENewResArray, 50, 143);
    xsArraySetInt(DENewResArray, 51, 144);
    xsArraySetInt(DENewResArray, 52, 145);
    xsArraySetInt(DENewResArray, 53, 146);
    xsArraySetInt(DENewResArray, 54, 147);
    xsArraySetInt(DENewResArray, 55, 148);
    xsArraySetInt(DENewResArray, 56, 149);
    xsArraySetInt(DENewResArray, 57, 150);
    xsArraySetInt(DENewResArray, 58, 151);
    xsArraySetInt(DENewResArray, 59, 156);
    xsArraySetInt(DENewResArray, 60, 157);
    xsArraySetInt(DENewResArray, 61, 158);
    xsArraySetInt(DENewResArray, 62, 159);
    xsArraySetInt(DENewResArray, 63, 160);
    xsArraySetInt(DENewResArray, 64, 161);
    xsArraySetInt(DENewResArray, 65, 162);
    xsArraySetInt(DENewResArray, 66, 163);
    xsArraySetInt(DENewResArray, 67, 198);
    xsArraySetInt(DENewResArray, 68, 199);
    xsArraySetInt(DENewResArray, 69, 200);
    xsArraySetInt(DENewResArray, 70, 201);
    xsArraySetInt(DENewResArray, 71, 202);
    xsArraySetInt(DENewResArray, 72, 203);
    xsArraySetInt(DENewResArray, 73, 204);
    xsArraySetInt(DENewResArray, 74, 220);
    xsArraySetInt(DENewResArray, 75, 275);
    xsArraySetInt(DENewResArray, 76, 276);
    xsArraySetInt(DENewResArray, 77, 277);
    xsArraySetInt(DENewResArray, 78, 278);
    xsArraySetInt(DENewResArray, 79, 287);
    xsArraySetInt(DENewResArray, 80, 289);
    xsArraySetInt(DENewResArray, 81, 290);
    xsArraySetInt(DENewResArray, 82, 291);
    xsArraySetInt(DENewResArray, 83, 292);
    xsArraySetInt(DENewResArray, 84, 293);
    xsArraySetInt(DENewResArray, 85, 294);
    xsArraySetInt(DENewResArray, 86, 295);
    xsArraySetInt(DENewResArray, 87, 296);
    xsArraySetInt(DENewResArray, 88, 297);
    xsArraySetInt(DENewResArray, 89, 298);
    xsArraySetInt(DENewResArray, 90, 299);
    xsArraySetInt(DENewResArray, 91, 309);
    xsArraySetInt(DENewResArray, 92, 310);
    xsArraySetInt(DENewResArray, 93, 311);
    xsArraySetInt(DENewResArray, 94, 312);
    xsArraySetInt(DENewResArray, 95, 313);
    xsArraySetInt(DENewResArray, 96, 314);
    xsArraySetInt(DENewResArray, 97, 315);
    xsArraySetInt(DENewResArray, 98, 316);
    xsArraySetInt(DENewResArray, 99, 317);
    xsArraySetInt(DENewResArray, 100, 318);
    xsArraySetInt(DENewResArray, 101, 319);
    xsArraySetInt(DENewResArray, 102, 320);
    xsArraySetInt(DENewResArray, 103, 321);
    xsArraySetInt(DENewResArray, 104, 322);
    xsArraySetInt(DENewResArray, 105, 323);
    xsArraySetInt(DENewResArray, 106, 324);
    xsArraySetInt(DENewResArray, 107, 334);
    xsArraySetInt(DENewResArray, 108, 335);
    xsArraySetInt(DENewResArray, 109, 336);
    xsArraySetInt(DENewResArray, 110, 337);
    xsArraySetInt(DENewResArray, 111, 338);
    xsArraySetInt(DENewResArray, 112, 339);
    xsArraySetInt(DENewResArray, 113, 340);
    xsArraySetInt(DENewResArray, 114, 341);
    xsArraySetInt(DENewResArray, 115, 342);
    xsArraySetInt(DENewResArray, 116, 343);
    xsArraySetInt(DENewResArray, 117, 344);
    xsArraySetInt(DENewResArray, 118, 345);
    xsArraySetInt(DENewResArray, 119, 346);
    xsArraySetInt(DENewResArray, 120, 347);
    xsArraySetInt(DENewResArray, 121, 348);
    xsArraySetInt(DENewResArray, 122, 349);
    xsArraySetInt(DENewResArray, 123, 359);
    xsArraySetInt(DENewResArray, 124, 360);
    xsArraySetInt(DENewResArray, 125, 361);
    xsArraySetInt(DENewResArray, 126, 362);
    xsArraySetInt(DENewResArray, 127, 363);
    xsArraySetInt(DENewResArray, 128, 364);
    xsArraySetInt(DENewResArray, 129, 365);
    xsArraySetInt(DENewResArray, 130, 366);
    xsArraySetInt(DENewResArray, 131, 367);
    xsArraySetInt(DENewResArray, 132, 368);
    xsArraySetInt(DENewResArray, 133, 369);
    xsArraySetInt(DENewResArray, 134, 370);
    xsArraySetInt(DENewResArray, 135, 371);
    xsArraySetInt(DENewResArray, 136, 372);
    xsArraySetInt(DENewResArray, 137, 373);
    xsArraySetInt(DENewResArray, 138, 374);
    xsArraySetInt(DENewResArray, 139, 384);
    xsArraySetInt(DENewResArray, 140, 385);
    xsArraySetInt(DENewResArray, 141, 386);
    xsArraySetInt(DENewResArray, 142, 387);
    xsArraySetInt(DENewResArray, 143, 388);
    xsArraySetInt(DENewResArray, 144, 389);
    xsArraySetInt(DENewResArray, 145, 390);
    xsArraySetInt(DENewResArray, 146, 391);
    xsArraySetInt(DENewResArray, 147, 392);
    xsArraySetInt(DENewResArray, 148, 393);
    xsArraySetInt(DENewResArray, 149, 394);
    xsArraySetInt(DENewResArray, 150, 395);
    xsArraySetInt(DENewResArray, 151, 396);
    xsArraySetInt(DENewResArray, 152, 397);
    xsArraySetInt(DENewResArray, 153, 398);
    xsArraySetInt(DENewResArray, 154, 399);
    xsArraySetInt(DENewResArray, 155, 409);
    xsArraySetInt(DENewResArray, 156, 410);
    xsArraySetInt(DENewResArray, 157, 411);
    xsArraySetInt(DENewResArray, 158, 412);
    xsArraySetInt(DENewResArray, 159, 413);
    xsArraySetInt(DENewResArray, 160, 414);
    xsArraySetInt(DENewResArray, 161, 415);
    xsArraySetInt(DENewResArray, 162, 416);
    xsArraySetInt(DENewResArray, 163, 417);
    xsArraySetInt(DENewResArray, 164, 418);
    xsArraySetInt(DENewResArray, 165, 419);
    xsArraySetInt(DENewResArray, 166, 420);
    xsArraySetInt(DENewResArray, 167, 421);
    xsArraySetInt(DENewResArray, 168, 422);
    xsArraySetInt(DENewResArray, 169, 423);
    xsArraySetInt(DENewResArray, 170, 424);
    xsArraySetInt(DENewResArray, 171, 434);
    xsArraySetInt(DENewResArray, 172, 435);
    xsArraySetInt(DENewResArray, 173, 436);
    xsArraySetInt(DENewResArray, 174, 437);
    xsArraySetInt(DENewResArray, 175, 438);
    xsArraySetInt(DENewResArray, 176, 439);
    xsArraySetInt(DENewResArray, 177, 440);
    xsArraySetInt(DENewResArray, 178, 441);
    xsArraySetInt(DENewResArray, 179, 442);
    xsArraySetInt(DENewResArray, 180, 443);
    xsArraySetInt(DENewResArray, 181, 444);
    xsArraySetInt(DENewResArray, 182, 445);
    xsArraySetInt(DENewResArray, 183, 446);
    xsArraySetInt(DENewResArray, 184, 447);
    xsArraySetInt(DENewResArray, 185, 448);
    xsArraySetInt(DENewResArray, 186, 449);
    xsArraySetInt(DENewResArray, 187, 459);
    xsArraySetInt(DENewResArray, 188, 460);
    xsArraySetInt(DENewResArray, 189, 461);
    xsArraySetInt(DENewResArray, 190, 462);
    xsArraySetInt(DENewResArray, 191, 463);
    xsArraySetInt(DENewResArray, 192, 464);
    xsArraySetInt(DENewResArray, 193, 465);
    xsArraySetInt(DENewResArray, 194, 466);
    xsArraySetInt(DENewResArray, 195, 467);
    xsArraySetInt(DENewResArray, 196, 468);
    xsArraySetInt(DENewResArray, 197, 469);
    xsArraySetInt(DENewResArray, 198, 470);
    xsArraySetInt(DENewResArray, 199, 471);
    xsArraySetInt(DENewResArray, 200, 472);
    xsArraySetInt(DENewResArray, 201, 473);
    xsArraySetInt(DENewResArray, 202, 474);
    xsArraySetInt(DENewResArray, 203, 484);
    xsArraySetInt(DENewResArray, 204, 485);
    xsArraySetInt(DENewResArray, 205, 486);
    xsArraySetInt(DENewResArray, 206, 487);
    xsArraySetInt(DENewResArray, 207, 488);
    xsArraySetInt(DENewResArray, 208, 489);
    xsArraySetInt(DENewResArray, 209, 490);
    xsArraySetInt(DENewResArray, 210, 491);
    xsArraySetInt(DENewResArray, 211, 492);
    xsArraySetInt(DENewResArray, 212, 493);
    xsArraySetInt(DENewResArray, 213, 494);
    xsArraySetInt(DENewResArray, 214, 495);
    xsArraySetInt(DENewResArray, 215, 496);
    xsArraySetInt(DENewResArray, 216, 497);
    xsArraySetInt(DENewResArray, 217, 498);
    xsArraySetInt(DENewResArray, 218, 499);
  }
  return (DENewResArr);
}

/// !! MUST call `DENewResArrInit` before calling `DENewRes`
int DENewRes(int idx){
  return xsArrayGetInt(DENewResArr, idx);
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
