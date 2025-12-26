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
/// @brief Implicit XS language gameplay functions. 
///        These functions interact directly with game state, objects, players, units, victory conditions, etc.
///        For reference ONLY, do not #include.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#include "xxPredef.xs"  

@__IMPLICIT__@ void xsChatData(string message = "", int value = -1);
@__IMPLICIT__@ bool xsDoesUnitExist(int unitId = -1);
@__IMPLICIT__@ void xsEffectAmount(int effectId = -1, int objectOrTechnologyId = -1, int attributeOrOperation = -1, float value = -1.0, int playerNumber = -1);
@__IMPLICIT__@ vector xsGetGroupMoveTarget(int groupId = -1);
@__IMPLICIT__@ int xsGetMapHeight();
@__IMPLICIT__@ int xsGetMapID();
@__IMPLICIT__@ string xsGetMapName(bool showFileExtension = false);
@__IMPLICIT__@ int xsGetMapWidth();
@__IMPLICIT__@ int xsGetNumPlayers();
@__IMPLICIT__@ float xsGetObjectAttribute(int playerId = -1, int objectId = -1, int attribute = -1, int damageClass = -1);
@__IMPLICIT__@ int xsGetObjectClass(int playerId = -1, int objectId = -1);
@__IMPLICIT__@ int xsGetObjectCopyId(int playerId = -1, int objectId = -1);
@__IMPLICIT__@ int xsGetObjectCount(int playerId = -1, int objectOrClassId = -1);
@__IMPLICIT__@ int xsGetObjectCountTotal(int playerId = -1, int objectOrClassId = -1);
@__IMPLICIT__@ string xsGetObjectName(int objectId = -1, int playerId = -1, bool internalName = false);
@__IMPLICIT__@ int xsGetObjectType(int playerId = -1, int objectId = -1);
@__IMPLICIT__@ int xsGetPlayerCivilization(int playerNumber = -1);
@__IMPLICIT__@ bool xsGetPlayerInGame(int playerNumber = -1);
@__IMPLICIT__@ string xsGetPlayerName(int playerId = -1);
@__IMPLICIT__@ int xsGetPlayerNumberOfTechs(int playerNumber = -1);
@__IMPLICIT__@ int xsGetPlayerUnitIds(int playerId = -1, int objectOrClassId = -1, int arrayId = -1);
@__IMPLICIT__@ string xsGetTechName(int techId = -1, int playerId = -1, bool internalName = false);
@__IMPLICIT__@ int xsGetTechState(int techId = -1, int playerId = -1);
@__IMPLICIT__@ float xsGetUnitAttribute(int unitId = -1, int attribute = -1, int damageClass = -1);
@__IMPLICIT__@ float xsGetUnitAttributeHeld(int unitId = -1, int attributeId = -1);
@__IMPLICIT__@ int xsGetUnitAttributeTypesHeld(int unitId = -1);
@__IMPLICIT__@ float xsGetUnitBuildPoints(int unitId = -1);
@__IMPLICIT__@ float xsGetUnitCharge(int unitId = -1);
@__IMPLICIT__@ int xsGetUnitClass(int unitId = -1);
@__IMPLICIT__@ int xsGetUnitCopyId(int unitId = -1);
@__IMPLICIT__@ int xsGetUnitGroupId(int unitId = -1);
@__IMPLICIT__@ float xsGetUnitHitpoints(int unitId = -1);
@__IMPLICIT__@ vector xsGetUnitMoveTarget(int unitId = -1);
@__IMPLICIT__@ string xsGetUnitName(int unitId = -1, bool internalName = false);
@__IMPLICIT__@ int xsGetUnitObjectId(int unitId = -1);
@__IMPLICIT__@ int xsGetUnitOwner(int unitId = -1);
@__IMPLICIT__@ vector xsGetUnitPosition(int unitId = -1);
@__IMPLICIT__@ int xsGetUnitTargetUnitId(int unitId = -1);
@__IMPLICIT__@ int xsGetUnitType(int unitId = -1);
@__IMPLICIT__@ int xsGetVictoryCondition();
@__IMPLICIT__@ int xsGetVictoryConditionForSecondaryGameMode();
@__IMPLICIT__@ int xsGetVictoryPlayer();
@__IMPLICIT__@ int xsGetVictoryPlayerForSecondaryGameMode();
@__IMPLICIT__@ int xsGetVictoryTime();
@__IMPLICIT__@ int xsGetVictoryTimeForSecondaryGameMode();
@__IMPLICIT__@ int xsGetVictoryType();
@__IMPLICIT__@ bool xsIsObjectAvailable(int objectId = -1, int playerId = -1);
@__IMPLICIT__@ bool xsObjectHasAction(int playerId = -1, int objectOrClassId = -1, int actionId = -1, int targetPlayerId = -1, int targetType = -1, int targetUnitLevel = -1);
@__IMPLICIT__@ float xsPlayerAttribute(int playerNumber = -1, int resourceId = -1);
@__IMPLICIT__@ void xsRemoveTask(int objectOrClassId = -1, int actionType = -1, int targetObjectOrClassId = -1, int playerId = -1);
@__IMPLICIT__@ bool xsResearchTechnology(int techId = -1, bool force = false, bool techAvailable = false, int playerNumber = -1);
@__IMPLICIT__@ void xsResetTaskAmount();
@__IMPLICIT__@ void xsSetPlayerAttribute(int playerNumber = -1, int resourceId = -1, float value = -1.0);
@__IMPLICIT__@ void xsSetTriggerVariable(int variableId = -1, int value = -1);
@__IMPLICIT__@ bool xsSetUnitAttributeHeld(int unitId = -1, float value = -1.0, int attributeId = -1);
@__IMPLICIT__@ bool xsSetUnitBuildPoints(int unitId = -1, float value = -1.0);
@__IMPLICIT__@ bool xsSetUnitCharge(int unitId = -1, float value = -1.0);
@__IMPLICIT__@ bool xsSetUnitHitpoints(int unitId = -1, float value = -1.0);
@__IMPLICIT__@ void xsTask(int objectOrClassId = -1, int actionType = -1, int targetObjectOrClassId = -1, int playerId = -1);
@__IMPLICIT__@ void xsTaskAmount(int taskFieldId = -1, float value = -1.0);
@__IMPLICIT__@ int xsTriggerVariable(int variableId = -1);

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