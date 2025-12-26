///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright 2025 Anton Yashchenko
// Licensed under the MIT License.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// @project: Anton's AOE2 DE XS Script Extensions
// @author(s): Anton Yashchenko (Steam Name: Dave East Jones)
// @website: https://www.acpp.dev
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// @file event_manager.xs
/// @brief Event manager rule to handle/modify/track techs.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "DEPlayerTech";

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
			_xxChatError("[_xxDispatchModifyTech] Invalid 'player_id' arg(3). Not a valid player id.");
			return; // dont apply changes
		} else {
			xsEffectAmount(cModifyTech, tech_id, tech_attr, value, player_id);
		}
	}
}

/// Sets the location where a technology is researched. The target object MUST have building type interface
/// (not unpackables), or effect will not be seen.
void xxSetTechLocation(int tech_id = 0, int target_unit = 0, int player_id = DEPlayerAll){
	_xxDispatchModifyTech(tech_id,cAttrSetLocation,target_unit,player_id);
}

/// Sets the button slot where the tech appears in a tech's location building.
/// @see xxSetTechLocation
///
/// !!Valid Button Slot IDs
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
void xxSetTechButton(int tech_id = 0, int button_slot = 0,int player_id = DEPlayerAll){
	_xxDispatchModifyTech(tech_id,cAttrSetButton,button_slot,player_id);
}

void xxSetTechTime(int tech_id = 0, int time = 0,int player_id = DEPlayerAll){
	_xxDispatchModifyTech(tech_id,cAttrSetTime,time,player_id);
}

void xxSetTechIcon(int tech_id = 0, int icon_id = 0,int player_id = DEPlayerAll){
	_xxDispatchModifyTech(tech_id,cAttrSetIcon,icon_id,player_id);
}

void xxSetTechState(int tech_id = 0, int state = 0,int player_id = DEPlayerAll){
	_xxDispatchModifyTech(tech_id,cAttrSetState,state,player_id);
}

/// Helper function for modifying a tech's attributes.
///
/// Passing 'STDDefaultArgInt' will not apply the effect.
/// Passing an invalid argument (for most attrs) send an error chat and ignore that attr.
/// The state attribute change is applied last (if active).
void xxConfigureTech(
	int tech_id = STDDefaultArgInt, 	// unsigned int
	int state = STDDefaultArgInt,  		// unsigned int
	int time = STDDefaultArgInt,  		// unsigned int
	int location_id = STDDefaultArgInt, // unsigned int
	int button_slot = STDDefaultArgInt, // unsigned int | @see `adex/DEButtonSlots.xs`
	int icon_id = STDDefaultArgInt,	 	// unsigned int
	int player_id = DEPlayerAll
){
	if(tech_id <= STDDefaultArgInt){
		_xxChatError("[XXConfigureTech] Invalid 'tech_id' arg(0). Not a tech id.");
		return; // dont apply changes
	}

	// Appy all attribute modifications BEFORE changing the state.
	if(time <= STDDefaultArgInt){  // Time
		if(time < STDDefaultArgInt)  // user passed bad time
			_xxChatError("[XXConfigureTech] Invalid 'time' arg(1). Time must be positive or 0.");
		// dont change time
	} else {
		xxSetTechTime(tech_id, time, player_id);
	}

	if(location_id <= STDDefaultArgInt){ // Location
		if(location_id < STDDefaultArgInt) // user passed bad loc id
			_xxChatError("[XXConfigureTech] Invalid 'location_id' arg(2). Not an object id.");
		// dont change location
	} else {
		xxSetTechLocation(tech_id, location_id, player_id);
	}

	if(button_slot <= STDDefaultArgInt){ // Button
		if(location_id < STDDefaultArgInt)
			_xxChatError("[XXConfigureTech] Invalid 'button_slot' arg(3).");
		// dont change button
	} else {
		xxSetTechButton(tech_id, button_slot, player_id);
	}

	if(button_slot == STDDefaultArgInt){ // Icon
		// For now we will accept any icon ID, im not sure which ones are valid.
		// dont change icon
	} else {
		xxSetTechIcon(tech_id, icon_id, player_id);
	}

	// state
	if(state <= STDDefaultArgInt){ // Location
		if(state < STDDefaultArgInt) // user passed bad loc id
			_xxChatError("[XXConfigureTech] Invalid 'state' arg(5). Not a valid tech state.");
		// dont change location
	} else {
		xxSetTechState(tech_id, state, player_id);
	}
}

bool xxIsTechResearched(int tech_id = 0,int player = DEPlayerAll,int post_user_res_state = DETechState_Enabled,int post_rule_res_state = DETechState_Enabled){
	bool not_researched = true;
	not_researched = xsResearchTechnology(tech_id, false, true, player);
	if(not_researched){
		xxSetTechState(tech_id, post_rule_res_state,player);
		return (false);
	}
	//xsChatData("User researched loom.");
	xxSetTechState(tech_id, post_user_res_state,player);
	return (true);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Tech Event Handler
// Simulates a "Technology Researched" condition.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

extern int _xxTechEventArr = STDUninitializedArrayId; 					// Stores events created with `xxAddTechEvent`
extern int _xxTechEventCallbackPointersArr = STDUninitializedArrayId; 	// Stores indices to arrays which store user callback function names.
extern int _xxTechEventPlayerArr = STDUninitializedArrayId; 			// Target player to detect the tech research for.
extern int _xxTechEventPostUserStateArr = STDUninitializedArrayId; 		// The state to set after this tech is researched (default:Enable)
extern int _xxTechEventPostFalseStateArr = STDUninitializedArrayId; 	// The state to set after this tech is researched (default:Enable)

// Used as a prefix for the pointers(array indices)
extern const string _xxTechEventCallbackPointersArrPrefix = "_xxTechEventCallbackArr_";

// init empty structure TechEvent arrays
int _TechEventArrInit(){
  if(_xxTechEventArr == STDUninitializedArrayId) {
    _xxTechEventArr = xsArrayCreateInt(0, 0, "_xxTechEventArr");
    _xxTechEventCallbackPointersArr = xsArrayCreateInt(0, STDUninitializedArrayId, "_xxTechEventCallbackArr");
    _xxTechEventPlayerArr = xsArrayCreateInt(0, 0, "_xxTechEventPlayerArr");
    _xxTechEventPostUserStateArr = xsArrayCreateInt(0, 0, "_xxTechEventPostUserStateArr");
    _xxTechEventPostFalseStateArr = xsArrayCreateInt(0, 0, "_xxTechEventPostFalseStateArr");
  }
  return (_xxTechEventArr);
}

void xxInitEventManager(){
  if(_TechEventArrInit() == STDUninitializedArrayId)
    _xxChatError("[FATAL][xxInitEventHandler] Failed to init arrays.");
}

/// @function xxPushTechEvent
/// @return Event ID of the newly created ID or -1 if failed to push.
///
/// This function does a lot of memory allocation(extending arrays) so I dont every reccomend setting up tech events during gameplay,
/// only once at the start.
int xxPushTechEvent(
	int tech_id = STDDefaultArgInt,
	int player = DEPlayerAll,
	int post_user_state = DETechState_Enabled,
	int post_rule_state = DETechState_Enabled
){
	if(tech_id <= STDDefaultArgInt){
		_xxChatError("[xxAddTechEvent] Invalid 'tech_id' arg(0). Not a tech id.");
		return (-1);
	}

	int new_back = xsArrayGetSize(_xxTechEventArr);
	int new_size = new_back + 1;

	xsArrayResizeInt(_xxTechEventArr, new_size);
	xsArrayResizeInt(_xxTechEventCallbackPointersArr, new_size);
	xsArrayResizeInt(_xxTechEventPlayerArr, new_size);
	xsArrayResizeInt(_xxTechEventPostUserStateArr, new_size);
	xsArrayResizeInt(_xxTechEventPostFalseStateArr, new_size);

	xsArraySetInt(_xxTechEventArr, new_back, tech_id);
	xsArraySetInt(_xxTechEventCallbackPointersArr, new_back, xsArrayCreateString(0,"",_xxTechEventCallbackPointersArrPrefix + new_back));

	xsArraySetInt(_xxTechEventPlayerArr, new_back, player);
	xsArraySetInt(_xxTechEventPostUserStateArr, new_back, post_user_state);
	xsArraySetInt(_xxTechEventPostFalseStateArr, new_back, post_rule_state);

	return (new_back);
}

// Add an XS callback function to a given event id. Event must be already created using `xxPushTechEvent`.
int xxPushEventCallback(int event_id = STDDefaultArgInt, string func_name = ""){
	int callbacks_ptr = xsArrayGetInt(_xxTechEventCallbackPointersArr, event_id);
	xsArrayResizeString(callbacks_ptr,xsArrayGetSize(callbacks_ptr) + 1);
	xsArraySetString(callbacks_ptr, xsArrayGetSize(callbacks_ptr) - 1, func_name);
	return (xsArrayGetSize(callbacks_ptr) - 1);
}

rule _xxruleHandleEvents
    inactive
    minInterval 1
    maxInterval 1
    group xxrule
{
	// Iterate over the tech array set corresponding resource if researched.
	int arr_size = xsArrayGetSize(_xxTechEventArr);
	int nhandlers = 0;
	int callbacks_ptr = STDUninitializedArrayId;
	string cbfn = "";
	for(event_idx = 0; < arr_size){
	    bool isres = xxIsTechResearched(
			xsArrayGetInt(_xxTechEventArr, event_idx),
			xsArrayGetInt(_xxTechEventPlayerArr, event_idx),
			xsArrayGetInt(_xxTechEventPostUserStateArr, event_idx),
			xsArrayGetInt(_xxTechEventPostFalseStateArr, event_idx)
		);

		if(isres){
			callbacks_ptr = xsArrayGetInt(_xxTechEventCallbackPointersArr, event_idx);
			if(callbacks_ptr != STDUninitializedArrayId){
			  nhandlers = xsArrayGetSize(callbacks_ptr);
			  for(handler = 0; < nhandlers){
				xsAddRuntimeEvent("Scenario Triggers",xsArrayGetString(callbacks_ptr,handler), event_idx);
			  }
			}
		}
	}
}

void xxEnableEventManagerRule(bool disable = false){
	if(disable) xsDisableRule("_xxruleHandleEvents");
	xsEnableRule("_xxruleHandleEvents");
}

int xxGetEventTech(int event_id = STDDefaultArgInt){

}

int xxGetEventPlayer(int event_id = STDDefaultArgInt){

}

int xxGetEventTechPostState(int event_id = STDDefaultArgInt){

}

int xxGetEventTechFailState(int event_id = STDDefaultArgInt){

}

int xxGetEventCallbacks(int event_id = STDDefaultArgInt){

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
