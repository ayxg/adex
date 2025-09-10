///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright 2025 Anton Yashchenko
// Licensed under the MIT License.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// @project: DEJ Scenario Debugger & Demo XS Script
// @author(s): Anton Yashchenko (Steam Name: Dave East Jones)
// @website: https://www.acpp.dev
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// @file DEJScenarioDebugger.xs
/// @brief
///
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
include "adex/adex.xs";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Obj Explorer
// ! Pre: QARRID_deObjects must be initialized. see: adex/deObjects.xs
//
// **SCENARIO SETUP**
//		Main Menu somehow controller activates trigger qqObjExplorer_Init().
// 		Player 2 must start with a single Outpost on land, and a Water Tower on water. Add a controller building for
// 		technologies. (I used Army Tent C).
//
// ========== In-Game Triggers ==========
// - [RUN_OBJECT_EXPLORER]
// - [ChangeTechDescriptions]
// - [ChangeControllerOwnership]
// - [ActivateTechResearchCallbacks]
// - For each tech effect a callback trigger [cbTech_NameOfTech].
// - `cQObjExp_TechId_KillObject` is triggered in-game only.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extern bool QObjExp_IsOn = false;					// In-game trigger activated.

// Main Controller
extern int QObjExp_CurrentIdx = 0;					// Current index into the deObjects array.
extern int QObjExp_CurrentId = 0;
extern int QObjExp_LastSpawnedLandObjIdx = 0; 		
extern int QObjExp_LastSpawnedWaterObjIdx = 0;		

const int cQObjExp_ObjId_Controller = 1198; 		// Army Tent C (player 1)
const int cQObjExp_ObjId_GfxModder = 1834; 			// Yurt K (player 1)
const int cQObjExp_ObjId_Spawner = 598; 			// "Outpost" | Building ID which will spawn a unit (player 2)
const int cQObjExp_ObjId_WaterSpawner = 785; 		// "Sea Tower" | Building ID which will spawn a unit on water(player 2)

const int cQObjExp_TechId_PrevObjectId = 1182; 		// Blank Technology 2
const int cQObjExp_TechId_NextObjectId = 1183; 		// Blank Technology 3 
const int cQObjExp_TechId_PrevObjectId10 = 1186; 	// Blank Technology 6
const int cQObjExp_TechId_NextObjectId10 = 1187; 	// Blank Technology 7
const int cQObjExp_TechId_PrevObjectId100 = 1188; 	// Blank Technology 8
const int cQObjExp_TechId_NextObjectId100 = 1189; 	// Blank Technology 9
const int cQObjExp_TechId_SpawnOnLand = 1184; 		// Blank Technology 4
const int cQObjExp_TechId_SpawnOnWater = 1185; 		// Blank Technology 5
const int cQObjExp_TechId_KillObject = 1240; 		// Blank Technology 10(0)

// Gfx Mod
extern int QObjExp_TargetGfxType = cStandingGraphic;// Which graphic type to apply (standing/running etc.)
extern int QObjExp_TargetGfxId = 0;					// Graphic ID which the Gfx Mod will apply
extern int QObjExp_OriginalGfxId = 0;               // Objects previous graphic. Stored on apply.
extern int QObjExp_OriginalTargetGfxType = 0;

const int cQObjExp_TechId_PrevGfxId = 1181; 		// Blank Technology 1
const int cQObjExp_TechId_NextGfxId = 1241; 		// Blank Technology 11 
const int cQObjExp_TechId_PrevGfxId10 = 1242; 		// Blank Technology 12
const int cQObjExp_TechId_NextGfxId10 = 1243; 		// Blank Technology 13
const int cQObjExp_TechId_PrevGfxId100 = 1244; 		// Blank Technology 14
const int cQObjExp_TechId_NextGfxId100 = 1245; 		// Blank Technology 15
const int cQObjExp_TechId_PrevGfxId1000 = 1249; 	// Blank Technology 19
const int cQObjExp_TechId_NextGfxId1000 = 1180; 	// Blank Technology 0

const int cQObjExp_TechId_NextGfxType = 1246; 		// Blank Technology 16
const int cQObjExp_TechId_ApplyGfx = 1247; 			// Blank Technology 17
const int cQObjExp_TechId_RevertGfx = 1248; 		// Blank Technology 18

void qqObjExplorer_Init(){	
	// We could init DEObjects array if not already. But its wiser to let the callee do it manually so they know if it was init.
	if(DEObjectsArray == STDUninitializedArrayId) xsChatData("<RED>[FATAL] Failed to init ObjExplorer. Must restart scenario.");

	// Make the spawner buildings invisible. (Player 2 ONLY)
	xsEffectAmount(cSetAttribute, cQObjExp_ObjId_Spawner, cStandingGraphic, 0,2);
	xsEffectAmount(cSetAttribute, cQObjExp_ObjId_Spawner, cDyingGraphic, 0,2);
	xsEffectAmount(cSetAttribute, cQObjExp_ObjId_Spawner, cUndeadGraphic, 0,2);
	
	xsEffectAmount(cSetAttribute, cQObjExp_ObjId_WaterSpawner, cStandingGraphic, 0,2);
	xsEffectAmount(cSetAttribute, cQObjExp_ObjId_WaterSpawner, cDyingGraphic, 0,2);
	xsEffectAmount(cSetAttribute, cQObjExp_ObjId_WaterSpawner, cUndeadGraphic, 0,2);
					
	// Configure techs
	//
	// Main Controller
	xxConfigureTech(cQObjExp_TechId_PrevObjectId,DETechState_Enabled,1,cQObjExp_ObjId_Controller,
		DEButtonSlot_C0, 178, DEPlayer1);
	xxConfigureTech(cQObjExp_TechId_NextObjectId,DETechState_Enabled,1,cQObjExp_ObjId_Controller,
		DEButtonSlot_C1, 177, DEPlayer1);
	xxConfigureTech(cQObjExp_TechId_PrevObjectId10,DETechState_Enabled,1,cQObjExp_ObjId_Controller,
		DEButtonSlot_C5, 178, DEPlayer1);
	xxConfigureTech(cQObjExp_TechId_NextObjectId10,DETechState_Enabled,1,cQObjExp_ObjId_Controller,
		DEButtonSlot_C6, 177, DEPlayer1);
	xxConfigureTech(cQObjExp_TechId_PrevObjectId100,DETechState_Enabled,1,cQObjExp_ObjId_Controller,
		DEButtonSlot_C10, 178, DEPlayer1);
	xxConfigureTech(cQObjExp_TechId_NextObjectId100,DETechState_Enabled,1,cQObjExp_ObjId_Controller,
		DEButtonSlot_C11, 177, DEPlayer1);

	xxConfigureTech(cQObjExp_TechId_SpawnOnLand,DETechState_Enabled,1,cQObjExp_ObjId_Controller,
		DEButtonSlot_C2, 198, DEPlayer1);
	xxConfigureTech(cQObjExp_TechId_SpawnOnWater,DETechState_Enabled,1,cQObjExp_ObjId_Controller,
		DEButtonSlot_C3, 200, DEPlayer1);
	xxConfigureTech(cQObjExp_TechId_KillObject,DETechState_Enabled,1,cQObjExp_ObjId_Controller,
		DEButtonSlot_C7, 199, DEPlayer1);
	
	// Gfx Modder
	xxConfigureTech(cQObjExp_TechId_PrevGfxId,DETechState_Enabled,1,cQObjExp_ObjId_GfxModder,
		DEButtonSlot_C0, 178, DEPlayer1);
	xxConfigureTech(cQObjExp_TechId_NextGfxId,DETechState_Enabled,1,cQObjExp_ObjId_GfxModder,
		DEButtonSlot_C1, 177, DEPlayer1);
	xxConfigureTech(cQObjExp_TechId_PrevGfxId10,DETechState_Enabled,1,cQObjExp_ObjId_GfxModder,
		DEButtonSlot_C5, 178, DEPlayer1);
	xxConfigureTech(cQObjExp_TechId_NextGfxId10,DETechState_Enabled,1,cQObjExp_ObjId_GfxModder,
		DEButtonSlot_C6, 177, DEPlayer1);
	xxConfigureTech(cQObjExp_TechId_PrevGfxId100,DETechState_Enabled,1,cQObjExp_ObjId_GfxModder,
		DEButtonSlot_C10, 178, DEPlayer1);
	xxConfigureTech(cQObjExp_TechId_NextGfxId100,DETechState_Enabled,1,cQObjExp_ObjId_GfxModder,
		DEButtonSlot_C11, 177, DEPlayer1);
	xxConfigureTech(cQObjExp_TechId_PrevGfxId1000,DETechState_Enabled,1,cQObjExp_ObjId_GfxModder,
		DEButtonSlot_C12, 178, DEPlayer1);
	xxConfigureTech(cQObjExp_TechId_NextGfxId1000,DETechState_Enabled,1,cQObjExp_ObjId_GfxModder,
		DEButtonSlot_C13, 177, DEPlayer1);

	xxConfigureTech(cQObjExp_TechId_NextGfxType,DETechState_Enabled,1,cQObjExp_ObjId_GfxModder,
		DEButtonSlot_C2, 198, DEPlayer1);
	xxConfigureTech(cQObjExp_TechId_ApplyGfx,DETechState_Enabled,1,cQObjExp_ObjId_GfxModder,
		DEButtonSlot_C3, 200, DEPlayer1);
	xxConfigureTech(cQObjExp_TechId_RevertGfx,DETechState_Enabled,1,cQObjExp_ObjId_GfxModder,
		DEButtonSlot_C7, 199, DEPlayer1);
	
	QObjExp_IsOn = true;
}

// Tech research callback effects, we will need one trigger in-game per research which will be activated
// after `qqObjExp_Init` is called.
void qqObjExp_TechEffect_PrevObjectId(){
  if(QObjExp_CurrentIdx == 0) QObjExp_CurrentIdx = DEObjectsArray_Size;	
  else QObjExp_CurrentIdx = QObjExp_CurrentIdx - 1;		
  xsChatData("<GREEN>Object Index:" + QObjExp_CurrentIdx); 
}

void qqObjExp_TechEffect_NextObjectId(){
  if(QObjExp_CurrentIdx == DEObjectsArray_Size) QObjExp_CurrentIdx = 0;
  else QObjExp_CurrentIdx = QObjExp_CurrentIdx + 1;
  xsChatData("<GREEN>Object Index:" + QObjExp_CurrentIdx); 
}

void qqObjExp_TechEffect_PrevObjectId10(){
  if(QObjExp_CurrentIdx == 0) QObjExp_CurrentIdx = DEObjectsArray_Size;
  else {
    QObjExp_CurrentIdx = QObjExp_CurrentIdx - 10;	
    if(QObjExp_CurrentIdx < 0) QObjExp_CurrentIdx = 0;
  }
  xsChatData("<GREEN>Object Index:" + QObjExp_CurrentIdx); 
}

void qqObjExp_TechEffect_NextObjectId10(){
  if(QObjExp_CurrentIdx == DEObjectsArray_Size) QObjExp_CurrentIdx = 0;
  else {
    QObjExp_CurrentIdx = QObjExp_CurrentIdx + 10;
    if(QObjExp_CurrentIdx > DEObjectsArray_Size) QObjExp_CurrentIdx = DEObjectsArray_Size;			
  }
  xsChatData("<GREEN>Object Index:" + QObjExp_CurrentIdx); 
}

void qqObjExp_TechEffect_PrevObjectId100(){
  if(QObjExp_CurrentIdx == 0) QObjExp_CurrentIdx = DEObjectsArray_Size;	
  else {
    QObjExp_CurrentIdx = QObjExp_CurrentIdx - 100;	
    if(QObjExp_CurrentIdx < 0) QObjExp_CurrentIdx = 0;		
  }
  xsChatData("<GREEN>Object Index:" + QObjExp_CurrentIdx); 
}

void qqObjExp_TechEffect_NextObjectId100(){
  if(QObjExp_CurrentIdx == DEObjectsArray_Size) QObjExp_CurrentIdx = 0;	
  else {
    QObjExp_CurrentIdx = QObjExp_CurrentIdx + 100;
    if(QObjExp_CurrentIdx > DEObjectsArray_Size) QObjExp_CurrentIdx = DEObjectsArray_Size;	
  }
  xsChatData("<GREEN>Object Index:" + QObjExp_CurrentIdx); 
}

void qqObjExp_TechEffect_SpawnOnLand(){
  xsEffectAmount(cModResource, cAttributeSpawnCap, cAttributeSet, 1);
  xsEffectAmount(cSpawnUnit, xsArrayGetInt(DEObjectsArray,QObjExp_CurrentIdx), cQObjExp_ObjId_Spawner, 1,2);	
}

void qqObjExp_TechEffect_SpawnOnWater(){
  xsEffectAmount(cModResource, cAttributeSpawnCap, cAttributeSet, 1);
  xsEffectAmount(cSpawnUnit, xsArrayGetInt(DEObjectsArray,QObjExp_CurrentIdx), cQObjExp_ObjId_WaterSpawner, 1,2);			
}

void qqObjExp_TechEffect_PrevGfxId(){
  QObjExp_TargetGfxId = QObjExp_TargetGfxId - 1;		
  xsChatData("<GREEN>Graphic Index:" + QObjExp_CurrentIdx); 
}

void qqObjExp_TechEffect_NextGfxId(){
  QObjExp_TargetGfxId = QObjExp_TargetGfxId + 1;
  xsChatData("<GREEN>Graphic Index:" + QObjExp_TargetGfxId); 
}

void qqObjExp_TechEffect_PrevGfxId10(){

  QObjExp_TargetGfxId = QObjExp_TargetGfxId - 10;	
  xsChatData("<GREEN>Graphic Index:" + QObjExp_TargetGfxId); 
}

void qqObjExp_TechEffect_NextGfxId10(){
  QObjExp_TargetGfxId = QObjExp_TargetGfxId + 10;
  xsChatData("<GREEN>Graphic Index:" + QObjExp_TargetGfxId); 
}

void qqObjExp_TechEffect_PrevGfxId100(){
  QObjExp_TargetGfxId = QObjExp_TargetGfxId - 100;	
  xsChatData("<GREEN>Graphic Index:" + QObjExp_TargetGfxId); 
}

void qqObjExp_TechEffect_NextGfxId100(){
  QObjExp_TargetGfxId = QObjExp_TargetGfxId + 100;
  xsChatData("<GREEN>Graphic Index:" + QObjExp_TargetGfxId); 
}

void qqObjExp_TechEffect_PrevGfxId1000(){
  QObjExp_TargetGfxId = QObjExp_TargetGfxId - 1000;	
  xsChatData("<GREEN>Graphic Index:" + QObjExp_TargetGfxId); 
}

void qqObjExp_TechEffect_NextGfxId1000(){
  QObjExp_TargetGfxId = QObjExp_TargetGfxId + 1000;
  xsChatData("<GREEN>Graphic Index:" + QObjExp_TargetGfxId); 
}

void qqObjExp_TechEffect_NextGfxType(){
  /*
	extern const int cStandingGraphic = 71;
	extern const int cWalkingGraphic = 75;
	extern const int cRunningGraphic = 76;
	extern const int cDyingGraphic = 73;
	extern const int cUndeadGraphic = 74;
	extern const int cAttackGraphic = 70;
	extern const int cSpecialGraphic = 77;
	extern const int cStanding2Graphic = 72;
	extern const int cAttack2Graphic = 81;
  */
  // Iterate over the graphic types in the above order.
  if(QObjExp_TargetGfxType == cStandingGraphic){
    QObjExp_TargetGfxType = cWalkingGraphic;
    xsChatData("<GREEN>Graphic Type: cWalkingGraphic"); 	
  }
  else if(QObjExp_TargetGfxType == cWalkingGraphic){
    QObjExp_TargetGfxType = cRunningGraphic;
    xsChatData("<GREEN>Graphic Type: cRunningGraphic"); 	
  }
  else if(QObjExp_TargetGfxType == cRunningGraphic){
    QObjExp_TargetGfxType = cDyingGraphic;
    xsChatData("<GREEN>Graphic Type: cDyingGraphic"); 	
  }
  else if(QObjExp_TargetGfxType == cDyingGraphic){
    QObjExp_TargetGfxType = cUndeadGraphic;
    xsChatData("<GREEN>Graphic Type: cUndeadGraphic"); 	
  }
  else if(QObjExp_TargetGfxType == cUndeadGraphic){
    QObjExp_TargetGfxType = cAttackGraphic;
    xsChatData("<GREEN>Graphic Type: cAttackGraphic"); 	
  }
  else if(QObjExp_TargetGfxType == cAttackGraphic){
    QObjExp_TargetGfxType = cSpecialGraphic;
    xsChatData("<GREEN>Graphic Type: cSpecialGraphic"); 	
  }
  else if(QObjExp_TargetGfxType == cSpecialGraphic){
    QObjExp_TargetGfxType = cStanding2Graphic;
    xsChatData("<GREEN>Graphic Type: cStanding2Graphic"); 	
  }
  else if(QObjExp_TargetGfxType == cStanding2Graphic){
    QObjExp_TargetGfxType = cAttack2Graphic;
    xsChatData("<GREEN>Graphic Type: cAttack2Graphic"); 	
  }
  else if(QObjExp_TargetGfxType == cAttack2Graphic){
    QObjExp_TargetGfxType = cStandingGraphic;
    xsChatData("<GREEN>Graphic Type: cStandingGraphic"); 	
  }
}

void qqObjExp_TechEffect_ApplyGfx(){
  // Store original id and graphic type.
  QObjExp_OriginalTargetGfxType = QObjExp_TargetGfxType;
  QObjExp_OriginalGfxId = xsGetObjectAttribute(DEPlayer2, xsArrayGetInt(DEObjectsArray,QObjExp_CurrentIdx), QObjExp_TargetGfxType);

  xsEffectAmount(cSetAttribute, xsArrayGetInt(DEObjectsArray,QObjExp_CurrentIdx), QObjExp_TargetGfxType,QObjExp_TargetGfxId, DEPlayer2);
}

void qqObjExp_TechEffect_RevertGfx(){ 
  xsEffectAmount(cSetAttribute, xsArrayGetInt(DEObjectsArray,QObjExp_CurrentIdx), QObjExp_OriginalTargetGfxType,QObjExp_OriginalGfxId, DEPlayer2);		
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// end of QObjExp
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void main() {
	DEObjectsArray_Init();
	
	// Setup "Dave East Jones" pawn (P1 VMDL)
	xsEffectAmount(cSetAttribute, 206, cStandingGraphic, 1284,2);
	xsEffectAmount(cSetAttribute, 206, cDyingGraphic, 1284,2);
	xsEffectAmount(cSetAttribute, 206, cUndeadGraphic, 1284,2);
	xsEffectAmount(cSetAttribute, 206, cRunningGraphic, 1284,2);		
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// @project: DEJ Scenario Debugger & Demo XS Script
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
