///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright 2025 Anton Yashchenko
// Licensed under the MIT License.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// @project: Anton's AOE2 DE XS Script Extensions
// @author(s): Anton Yashchenko (Steam Name: Dave East Jones)
// @website: https://www.acpp.dev
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// @file adex.xs
/// @brief Main header file for the adex library. For quick function prototype reference when programming, see
///		   full function documentation in  `_adex_public.xs`.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
include "adex/_adex_public.xs";


/*/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

==========[Tech Modification]==========
void xxSetTechLocation(int tech_id = 0, int target_unit = 0, int player_id = DEPlayerAll);
void xxSetTechButton(int tech_id = 0, int button_slot = 0,int player_id = DEPlayerAll);
void xxSetTechTime(int tech_id = 0, int time = 0,int player_id = DEPlayerAll);
void xxSetTechIcon(int tech_id = 0, int icon_id = 0,int player_id = DEPlayerAll);
void xxSetTechState(int tech_id = 0, int state = 0,int player_id = DEPlayerAll);

void xxConfigureTech(
	int tech_id = STDDefaultArgInt, 	// unsigned int
	int state = STDDefaultArgInt,  		// unsigned int
	int time = STDDefaultArgInt,  		// unsigned int
	int location_id = STDDefaultArgInt, // unsigned int
	int button_slot = STDDefaultArgInt, // unsigned int | @see `adex/DEButtonSlot.xs`
	int icon_id = STDDefaultArgInt,	 	// unsigned int
	int player_id = DEPlayerAll
);

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// @project: Anton's AOE2 DE XS Script Extensions
// @author(s): Anton Yashchenko
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
