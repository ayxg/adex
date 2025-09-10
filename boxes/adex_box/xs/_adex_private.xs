///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright 2025 Anton Yashchenko
// Licensed under the MIT License.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// @project: Anton's AOE2 DE XS Script Extensions
// @author(s): Anton Yashchenko (Steam Name: Dave East Jones)
// @website: https://www.acpp.dev
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// @file _adex_private.xs
/// @brief 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Include ALL Library Depenedencies
//
// All library dependencies MUST be included here. Unfortunatley there seems to be no way to header guard a file in XS.
// This means you can only include a file once or we will get a "multiple defined symbols" error on compilation.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// xs stdlib
include "std/xstdlib.xs";

// aoe2de game data enums
include "adex/DEPlayer.xs";
include "adex/DEButtonSlot.xs";
include "adex/DETechState.xs";
include "adex/DEUnitTrait.xs";

// aoe2de game data arrays
include "adex/DEObjectsArray.xs";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


/// [Internal] Sends a RED error message in chat and sets the `stdGErrorFlag` on. 
///  		   Do not prefix your string with any <COLOR_TAGS>.
void _xxChatError(string msg = ""){
	xsChatData("<RED>" + msg);
	stdGErrorFlag = true;
}

/// [Internal] Dispatch `xsEffectAmount(cModifyTech | cGaiaModifyTech,...)` based on `player_id`. 
void _xxDispatchModifyTech(int tech_id = 0, int tech_attr = 0, int value = 0, int player_id = DEPlayerAll){
	if(player_id == DEPlayerAll){
		xsEffectAmount(cModifyTech, tech_id, tech_attr, value);
	}
	else if(player_id == DEPlayerGaia){
		xsEffectAmount(cGaiaModifyTech, tech_id, tech_attr, value);	
	}
	else {
		if(player_id < DEPlayerAll || player_id > DEPlayerGaia){
			
		}
	
		xsEffectAmount(cModifyTech, tech_id, tech_attr, value, player_id);
	}
}


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
