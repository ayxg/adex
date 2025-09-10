///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright 2025 Anton Yashchenko
// Licensed under the MIT License.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// @project: Castle Line War AOE2-DE Scenario Script 
// @author(s): Anton Yashchenko (Steam Name: Dave East Jones)
// @website: https://www.acpp.dev
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// @file CastleLineWar.xs
/// @brief
///
/// A specific naming convention is used to make it easy to tell which variables belong to us(the developer).
/// You can use Notepad++ and the Notepad++ User Language file provided in this repository to get syntax highlighting
/// for the xs constants/functions and all the script-specific conventions. Conventions and their highlight color:
/// - All global mutable variables are prefixed with [Q]. [LIGHT-GREEN]
/// - All global constants are prefixed with [cQ]. [PINK]
///
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////
// Utility Constants
///////////////////////////////////////////////////////////////////////////////////////////////////
extern const int cQUninitializedArrayId = -1;

///////////////////////////////////////////////////////////////////////////////////////////////////
// Real Unit ID Constants
// Unit IDs which are used in this scenario. Prefixed [cQUID_].
///////////////////////////////////////////////////////////////////////////////////////////////////
extern const int cQUID_FlemishMilitia 	= 1699;
extern const int cQUID_Spearman 		= 1786;
extern const int cQUID_ManAtArms 		= 75;
extern const int cQUID_EagleScout 		= 751;
extern const int cQUID_Archer 			= 4;
extern const int cQUID_Skirmisher		= 7;
extern const int cQUID_Slinger 			= 185;
extern const int cQUID_CavalaryArcher 	= 39;
extern const int cQUID_ScoutCavalary 	= 448;
extern const int cQUID_Knight 			= 38;
extern const int cQUID_CamelRider 		= 329;
extern const int cQUID_ShrivamshaRider 	= 1751;
extern const int cQUID_Ram 				= 35;
extern const int cQUID_Mangonel 		= 280;
extern const int cQUID_Scorpion 		= 279;
extern const int cQUID_SiegeElphant 	= 1746;
extern const int cQUID_Huskarl 			= 41;  	
extern const int cQUID_TeutonicKnight 	= 25;  	
extern const int cQUID_Kamayuk 			= 879;   	
extern const int cQUID_Hoplite 			= 2110;  	
extern const int cQUID_Genitour 		= 583;  	
extern const int cQUID_HandCannoneer 	= 5;  
extern const int cQUID_ElephantArcher 	= 873;   
extern const int cQUID_Longbowman 		= 8;  	
extern const int cQUID_Tarkan 			= 755; 	
extern const int cQUID_SteppeLancer		= 1370;  	
extern const int cQUID_BattleElephant 	= 1132;   
extern const int cQUID_XolotlWarrior 	= 1570;  	
extern const int cQUID_BombardCannon	= 36;  
extern const int cQUID_Trebuchet 		= 42;  	
extern const int cQUID_Petard 			= 440;   
extern const int cQUID_HussiteWagon 	= 1704; 

// Util Units
extern const int cQUID_InvisibleObject = 1291; 

///////////////////////////////////////////////////////////////////////////////////////////////////
// Real Building ID Constants
// Unit IDs which are used in this scenario. Prefixed [cQBID_].
// The builder has a total of 26 (13 Eco + 13 Military Building) Slots.
//
///////////////////////////////////////////////////////////////////////////////////////////////////
// Page 1 Builder Economy Buildings
// 13 Free Slots : Train Locations 0(1) to 13.
	// Row 1
	extern const int cQUID_House 	= 70;
	extern const int cQUID_Mill 		= 1786;
	extern const int cQUID_MiningCamp 		= 75;
	extern const int cQUID_LumberCamp 		= 751;
	extern const int cQUID_Dock 			= 4;
	// Row 2
	extern const int cQUID_Farm		= 7;
	extern const int cQUID_Blacksmith 			= 185;
	extern const int cQUID_Market 	= 39;
	extern const int cQUID_Monastery 	= 448;
	extern const int cQUID_University 			= 38;	
	// Row 3
	extern const int cQUID_University 			= 38;
	extern const int cQUID_TownCenter 		= 329;
	extern const int cQUID_Caravanserai 		= 329; // For Portugese players make sure to disable Fetoria. Enable this for all civs.
	
// Page 2 Builder Economy Buildings
// 13 Free Slots : Train Locations 0(1) to 13.
	// Row 1
	extern const int cQUID_Barracks 	= 1699;
	extern const int cQUID_ArcheryRange		= 1786;
	extern const int cQUID_Stable 		= 75;
	extern const int cQUID_SiegeWorkshop 		= 751;
		// Location 5 is empty.
	// Row 2
	extern const int cQUID_Outpost	= 7;
	extern const int cQUID_PalisadeWall			= 185;
	extern const int cQUID_FortifiedWall	= 39;
	extern const int cQUID_Keep 	= 448;
		// Location 10 is empty.	
	// Row 3
	extern const int cQUID_Gate 			= 38;
	extern const int cQUID_PalisadeGate 		= 329;
	extern const int cQUID_Castle 		= 329; // For portugese make sure to disable Fetoria. EnableObject this for all civs.

// Four random building types to use for the empty builder slots. Must be enabled by EnableObject effect.
// Need buildings for: cQPID_Archer,cQPID_Knight,cQPID_Templar,cQPID_ElephantRider
	
	


///////////////////////////////////////////////////////////////////////////////////////////////////
// Player resource ID Constants
// Player resource IDs which are used in this scenario. Prefixed [cQRID_].
// Note that resources named "Unused" are unused in the AOE scenario editor not in this script.
// List of IDs can be found in the [Advanced Genie Editor]->[Civilizations Tab]
///////////////////////////////////////////////////////////////////////////////////////////////////

// We need 32 IDs per player to hold the pawn counts
extern const int cQRID_Unused102 = 102;  
extern const int cQRID_Unused103 = 103;  
extern const int cQRID_Unused104 = 104;  
extern const int cQRID_Unused105 = 105;  
extern const int cQRID_Unused106 = 106;  
extern const int cQRID_Unused107 = 107;  
extern const int cQRID_Unused108 = 108;  
extern const int cQRID_Unused109 = 109;  
extern const int cQRID_Unused110 = 110;  
extern const int cQRID_Unused111 = 111;
  
extern const int cQRID_Unused112 = 112;  
extern const int cQRID_Unused113 = 113;  
extern const int cQRID_Unused114 = 114;  
extern const int cQRID_Unused115 = 115;  
extern const int cQRID_Unused116 = 116;  
extern const int cQRID_Unused117 = 117;  
extern const int cQRID_Unused118 = 118; 
extern const int cQRID_Unused119 = 119; 
extern const int cQRID_Unused120 = 120;  
extern const int cQRID_Unused121 = 121;
  
extern const int cQRID_Unused122 = 122;  
extern const int cQRID_Unused123 = 123;  
extern const int cQRID_Unused124 = 124;  
extern const int cQRID_Unused125 = 125;  
extern const int cQRID_Unused126 = 126;  
extern const int cQRID_Unused127 = 127;  
extern const int cQRID_Unused128 = 128;  
extern const int cQRID_Unused129 = 129;  
extern const int cQRID_Unused130 = 130;  
extern const int cQRID_Unused131 = 131;
extern const int cQRID_Unused132 = 132; 
 
extern const int cQRID_Unused133 = 133;
extern const int cQRID_Unused134 = 134;
     

///////////////////////////////////////////////////////////////////////////////////////////////////
// Pawn Manual Enumeration 
// Enumerator of all the custom units which are available to the player to build/spawn each wave.
//
// Prefixed with [cQPID_]. 
// The global constant `cQPID_COUNT` is the total amount of pawns.
// It MUST be updated every time you add a new pawn enum. Also make sure every new pawn id is 
// exactly +1 after the last.
//
// These are called "pawns"(eg. from chess) to separate them from units. Each pawn will have
// associated data in global arrays. These enums can be used as indices into the scenario's global 
// pawn data arrays declared below, to access a specific pawn's data point.
// 
// Each pawn enum will be a key to an assoiciated array element:
// - QARRID_PawnUnitId : unit which this pawn will spawn when it's building is counted.
// - QARRID_PawnBuildingId : building type to scan for when counting this pawns wave spawn amount.
///////////////////////////////////////////////////////////////////////////////////////////////////
// Tier 1
/////////////////////////////////////////////////
// Infantry
extern const int cQPID_AngryVillager 	= 0;  	// Flemish Militia
extern const int cQPID_Spearboy 	= 1;  	// Spearman
extern const int cQPID_Warrior 	= 2;   	// Man-At-Arms
extern const int cQPID_Eagle 	= 3;  	// Eagle Scout
// Ranged
extern const int cQPID_Archer 	= 4;  	// Archer
extern const int cQPID_Skirm 	= 5;  	// Skirmisher
extern const int cQPID_Slinger 	= 6;   	// Slinger
extern const int cQPID_CavArcher 	= 7;  	// Cavalary Archer
// Cavalary
extern const int cQPID_Scout 	= 8;  	// Scout
extern const int cQPID_Knight 	= 9;  	// Knight
extern const int cQPID_Camel 	= 10;   	// Camel
extern const int cQPID_Rider 	= 11;  	// Shrivamsha Ride
// Siege
extern const int cQPID_Ram 	= 12;  	// Ram


/////////////////////////////////////////////////
// Tier 2
/////////////////////////////////////////////////
extern const int cQPID_Catapult 	= 13;  	// Mangonel
extern const int cQPID_Scorpion 	= 14;   	// Scorpion
extern const int cQPID_SiegeElephant 	= 15;  	// Elephant
// Infantry
extern const int cQPID_AntiArcher 	= 16;  	// Huskarl
extern const int cQPID_Templar 	= 17;  	// Teutonic Knight
// Ranged
extern const int cQPID_Gunner 	= 18;  	// Hand Cannoneer
extern const int cQPID_ElephantCrew 	= 19;   	// Elephant Archer
// Cavalary
extern const int cQPID_TorchRaider 	= 20;  	// Tarkan
extern const int cQPID_Lancer 	=21;  	// steppe lancer
extern const int cQPID_ElephantRider 	= 22;   	// Battle Elephant
// Siege
extern const int cQPID_Artillery 	= 23;  	// Bombard Cannon
extern const int cQPID_Bomber 	= 24;   	// Petard
extern const int cQPID_Tank 	= 25;  	// Hussite Wagon

// !! UPDATE WHEN ADDING NEW PAWNS - the value must be the last pawn id + 1.
extern const int cQPID_COUNT = 26;
extern const int cQPID_END = cQPID_COUNT + 1;

///////////////////////////////////////////////////////////////////////////////////////////////////
// Utility units for in-game mechanics.
///////////////////////////////////////////////////////////////////////////////////////////////////

// @global cQWaveSpawnerUnit
// !! MUST be a building unit type. Or spawning wont work.
// Unit from where a player's wave will be spawned at. There should only be one of these per Player
// on the map. 
// This is the unit to pass when spawning a wave using `xsEffectAmount` with `cSpawnUnit` argument,
// which requires some unit id where the unit will be spawned from.
// Also right before calling `cSpawnUnit` you should call :
//		xsEffectAmount(cModResource, cAttributeSpawnCap, cAttributeSet, 1) 
// to limit spawning to only from 1 source unit. Ex:
// @code
// 	xsEffectAmount(cModResource, cAttributeSpawnCap, cAttributeSet, numBuildings);
// 	xsEffectAmount(cSpawnUnit, unitID, buildingID, numUnits)
// @endcode
extern const int cQWaveSpawnerUnit = cQUID_InvisibleObject; 


///////////////////////////////////////////////////////////////////////////////////////////////////
// Pawn Data Arrays
// Array identifier of a given data array. In XS scripts, you can only create arrays by calling a 
// function then refering back to that array's id to operate on it. These mutable globals hold 
// the id of a data array after it has been constructed in the main method by calling the
// associated array construction method.
// Prefixed with [QARRID_], each assoicated creation method is prefixed with [qqConstructArray_].
//
// These MUST be constructed in the main method before using any other scenario specific functions.
// All arrays are guaranteed to have size equal `cQPID_COUNT`. 
// The arrays are mutable, the data may change if a player gets some upgrade or based on a random
// condition.
///////////////////////////////////////////////////////////////////////////////////////////////////
extern int QARRID_PawnUnitIds = cQUninitializedArrayId;
extern int QARRID_PawnBuildingIds = cQUninitializedArrayId;
extern int QARRID_PawnPlayerResourceIds = cQUninitializedArrayId;

// The is probably no reason to use these strings, just use the integer id to refer to the array.
// Required by XS when creating an array to provide a unique name.
extern string cQARRNAME_PawnUnitIds = "ARRNAME_PawnUnitIds";
extern string cQARRNAME_PawnBuildingIds = "ARRNAME_PawnBuildingIds";
extern string cQARRNAME_PawnPlayerResourceIds = "ARRNAME_PawnPlayerResourceIds";

///////////////////////////////////////////////////////////////////////////////////////////////////
// QARRID_PawnUnitIds
// Generates initial pawn spawn unit IDs.
///////////////////////////////////////////////////////////////////////////////////////////////////
int qqConstructArray_PawnUnitIds(){
	QARRID_PawnUnitIds = xsArrayCreateInt(cQPID_COUNT, 0, cQARRNAME_PawnUnitIds);
	// Associate each pawn with it's initial unit it. (note that it may change if player gets some upgrades).
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_AngryVillager, cQUID_FlemishMilitia);
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_Spearboy,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_Warrior,cQUID_ManAtArms);
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_Eagle,cQUID_EagleScout);
	// Ranged
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_Archer,cQUID_Archer);
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_Skirm ,cQUID_Skirmisher);
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_Slinger ,cQUID_Slinger);
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_CavArcher,cQUID_CavalaryArcher);
	// Cavalary
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_Scout ,cQUID_ScoutCavalary);
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_Knight ,cQUID_Knight);
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_Camel ,cQUID_CamelRider);
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_Rider ,cQUID_ShrivamshaRider);
	// Siege
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_Ram ,cQUID_Ram);
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_Catapult ,cQUID_Mangonel);
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_Scorpion ,cQUID_Scorpion);
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_SiegeElephant ,cQUID_SiegeElphant);

	/////////////////////////////////////////////////
	// Tier 2
	/////////////////////////////////////////////////
	// Infantry
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_AntiArcher ,cQUID_Huskarl);
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_Templar ,cQUID_TeutonicKnight);
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_LongSpear 	,cQUID_Kamayuk);
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_Spearshield 	,cQUID_Hoplite);
	// Ranged
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_RidingSkirm ,cQUID_Genitour);
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_Gunner 	,cQUID_HandCannoneer);
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_ElephantCrew ,cQUID_ElephantArcher);
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_LongBow 	,cQUID_Longbowman);
	// Cavalary
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_TorchRaider ,cQUID_Tarkan);
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_Lancer ,cQUID_SteppeLancer);
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_ElephantRider ,cQUID_BattleElephant);
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_EagleRider 	,cQUID_XolotlWarrior);
	// Siege
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_Artillery ,cQUID_BombardCannon);
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_Rockets ,cQUID_Trebuchet);
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_Bomber,cQUID_Petard);
	xsArraySetInt(QARRID_PawnUnitIds, cQPID_Tank ,cQUID_HussiteWagon);

};

///////////////////////////////////////////////////////////////////////////////////////////////////
// QARRID_PawnBuildingIds
// Generates initial pawn counter building IDs.
///////////////////////////////////////////////////////////////////////////////////////////////////
int qqConstructArray_PawnBuildingIds(){
	QARRID_PawnBuildingIds = xsArrayCreateInt(cQPID_COUNT, 0, cQARRNAME_PawnBuildingIds);
	// Associate each pawn with it's initial unit it. (note that it may change if player gets some upgrades).
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_AngryVillager, cQUID_FlemishMilitia);
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_Spearboy,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_Warrior,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_Eagle,cQUID_Spearman);
	// Ranged
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_Archer,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_Skirm ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_Slinger ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_CavArcher,cQUID_Spearman);
	// Cavalary
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_Scout ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_Knight ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_Camel ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_Rider ,cQUID_Spearman);
	// Siege
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_Ram ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_Catapult ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_Scorpion ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_SiegeElephant ,cQUID_Spearman);

	/////////////////////////////////////////////////
	// Tier 2
	/////////////////////////////////////////////////
	// Infantry
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_AntiArcher ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_Templar ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_LongSpear 	,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_Spearshield 	,cQUID_Spearman);
	// Ranged
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_RidingSkirm ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_Gunner 	,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_ElephantCrew ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_LongBow 	,cQUID_Spearman);
	// Cavalary
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_TorchRaider ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_Lancer ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_ElephantRider ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_EagleRider 	,cQUID_Spearman);
	// Siege
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_Artillery ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_Rockets ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_Bomber,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnBuildingIds, cQPID_Tank ,cQUID_Spearman);
};

///////////////////////////////////////////////////////////////////////////////////////////////////
// QARRID_PawnPlayerResourceIds
// Player's Unit Building Counter Resource ID
// Every unit count is stored in a per-player attribute. The attribte used will be one of
// the available "Unused Resource" IDs. 
///////////////////////////////////////////////////////////////////////////////////////////////////
int qqConstructArray_PawnPlayerResourceIds(){
	QARRID_PawnPlayerResourceIds = xsArrayCreateInt(cQPID_COUNT, 0, cQARRNAME_PawnBuildingIds);
	// Associate each pawn with it's initial unit it. (note that it may change if player gets some upgrades).
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_AngryVillager, cQUID_FlemishMilitia);
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_Spearboy,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_Warrior,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_Eagle,cQUID_Spearman);
	// Ranged
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_Archer,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_Skirm ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_Slinger ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_CavArcher,cQUID_Spearman);
	// Cavalary
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_Scout ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_Knight ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_Camel ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_Rider ,cQUID_Spearman);
	// Siege
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_Ram ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_Catapult ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_Scorpion ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_SiegeElephant ,cQUID_Spearman);

	/////////////////////////////////////////////////
	// Tier 2
	/////////////////////////////////////////////////
	// Infantry
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_AntiArcher ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_Templar ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_LongSpear 	,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_Spearshield 	,cQUID_Spearman);
	// Ranged
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_RidingSkirm ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_Gunner 	,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_ElephantCrew ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_LongBow 	,cQUID_Spearman);
	// Cavalary
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_TorchRaider ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_Lancer ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_ElephantRider ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_EagleRider 	,cQUID_Spearman);
	// Siege
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_Artillery ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_Rockets ,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_Bomber,cQUID_Spearman);
	xsArraySetInt(QARRID_PawnPlayerResourceIds, cQPID_Tank ,cQUID_Spearman);
};

/// @method qqGetPawnBuildingCount		 
/// Gets the building count for each pawn type for a player and stores it in the associated player resource.		 
void qqGetPawnBuildingCount(int player = 0){
	// For each type of pawn... get the pawn building id from QARRID_PawnBuildingIds and store into player's
	// resource of the same pawn index in QARRID_PawnPlayerResourceIds.
	for(curr_id = 0; < cQPID_END){
	 	xsSetPlayerAttribute(
			player, 
			xsArrayGetInt(QARRID_PawnPlayerResourceIds, curr_id),  					// resource id
			xsGetObjectCount(player,xsArrayGetInt(QARRID_PawnBuildingIds, curr_id)) // pawn building count
		);
	}
}

/// @method qqSpawnWaveUnits
/// Spawns this wave's army from a player's cQWaveSpawnerUnit. There should be one of these units on the
/// scenario map. Additional instances of the unit wont spawn another army.
void qqSpawnWaveUnits(int player = 0){
	for(curr_id = 0; < cQPID_END){
		int pawn_count = xsPlayerAttribute(player,xsArrayGetInt(QARRID_PawnPlayerResourceIds, curr_id));
		if(pawn_count > 0){
			 xsEffectAmount(cModResource, cAttributeSpawnCap, cAttributeSet, 1);
			 xsEffectAmount(cSpawnUnit, curr_id, cQWaveSpawnerUnit, pawn_count)
		}
	}
}

/// @method qqActivateTrigger_AttackMoveArmyToEnemyCastle
/// Sets a flag which activates in-game trigger, to attack move a player's army from the spawn area to the enemy castle.
///
/// Since there are two teams, we dont have to apply this trigger to all players individually. Instead, pass either
/// cQWestTeamSide or cQEastTeamSide for each team's spawn area. 
///
/// There is to way to attack-move from the XS script, must be done with triggers. In-game setup:
/// 		- Init 2 variables, 1 for each team  Flag_AttackMoveArmyToEnemyCastleWest and Flag_AttackMoveArmyToEnemyCastleEast.
/// 		- Place a cQWaveSpawnerUnit at some location on the map for each team.
/// 		- Create trigger AttackMoveArmyToEnemyCastleWest and AttackMoveArmyToEnemyCastleEast set to on & looping.
///      	- Add a short timer (1 second~) to not overload when active.
/// 		- Add condition : if(Flag_AttackMoveArmyToEnemyCastleWest > 0) 
///			- Add condition to only trigger if there are any units left in the area.
/// 		- Add effect to attack move from spawn are to enemy castle. 
///	 	  	  You should select a GROUND location behind it, NOT the building itself. 
/// 		- [IN ADDITION] Add effect to make the units not selectable so the player cant control them.
/// This function will set Flag_AttackMoveArmyToEnemyCastle[West/East] on to enable/disable the trigger.
///
/// You should also setup an additional looping trigger which turns this trigger off and itself once
/// there are no units left in the area.
extern const int cQVARID_AttackMoveArmyToEnemyCastleWest = 100; 
extern const int cQVARID_AttackMoveArmyToEnemyCastleEast = 101;
extern const int cQWestTeamSide = 0; 		
extern const int cQEastTeamSide = 1; 		
void qqActivateTrigger_AttackMoveArmyToEnemyCastle(int side_constant, bool onoff = true){
	if(side_constant == cQWestTeamSide){
	   xsSetTriggerVariable(cQVARID_AttackMoveArmyToEnemyCastleWest, onoff);
	} 
	else if(side_constant == cQEastTeamSide){
	   xsSetTriggerVariable(cQVARID_AttackMoveArmyToEnemyCastleEast, onoff);	
	}
	else {
		// Error!! This should never happen. Invaid side_constant. Do nothing.
	}

}

// Setup the custom settings for each player. This includes:
// - PlayerAttributes(resources and scenario player variable defaults) 
// - Custom buildings. (unit counter buildings / custom tech buildings)
// - Custom units. (pawns)
// - Custom Technologies.
void qqConfigureScenarioPlayers(){
	// For each pawn's associated building, has to be a manual iteration because each setup may be diffrent.
	//	- set the building's tooltip : 
	//			Set the long and short description to the same, in case of diffrent player settings.
	//			You can use color tags inside the description like "<RED>" or "<GREEN>" at the start of a line.
	//  - set train location : 
	//			Page 1 in the villager should refer to an economy building id, page 2 should be a military building.
	//			Setting the train location will only move the building within its page type.
	//			Prefer to override an existing building. Eg House is in slot 1. 
	//			In the QARRID_PawnBuildingIds array make sure to check if a building is economy/military in case
	//			its not working properly.
	//   		If not overriding a building, disable all others which may apear in that slot, then enable the object.
	//          Also for some random reason slot ids start at both 0 and 1. So 0 and 1 are both the first slot.
	//	- set building graphic and icon :
	//			You cannot set a building graphic to a unit graphic(i think after some tests). So make sure you are
	//			refering to a building graphic if its not appearing correct. Same goes for icons, can't set a building
	//			icon to a unit icon??
	//  - set building cost : all buildings cost wood in this scenario, to remove the other building costs you have to use
	//						  this weird trick below. Only do it if necessary.
	// @code
	// 		const int HOUSE = 70;
	//		xsEffectAmount(cMulAttribute, HOUSE, cWoodCost, -2, 1);
	//		xsEffectAmount(cMulAttribute, HOUSE, cStoneCost, -1, 1);
	//		xsEffectAmount(cSetAttribute, HOUSE, cStoneCost, 10, 1);
	// @endcode
	
	// AngryVillager - Slot Economy 1 - Overrides House - 10 Wood           
 	xsEffectAmount(cSetAttribute, xsArrayGetInt(QARRID_PawnBuildingIds, cQPID_AngryVillager), cNameId, xsArrayGetInt(QARRID_PawnNameIds, cQPID_AngryVillager));	
 	xsEffectAmount(cSetAttribute, xsArrayGetInt(QARRID_PawnBuildingIds, cQPID_AngryVillager), cDescriptionId, xsArrayGetInt(QARRID_PawnDescIds, cQPID_AngryVillager));
	xsEffectAmount(cSetAttribute, xsArrayGetInt(QARRID_PawnBuildingIds, cQPID_AngryVillager), cShortTooltipId, xsArrayGetInt(QARRID_PawnDescIds, cQPID_AngryVillager));
	xsEffectAmount(cSetAttribute, xsArrayGetInt(QARRID_PawnBuildingIds, cQPID_AngryVillager), cExtendedTooltipId, xsArrayGetInt(QARRID_PawnDescIds, cQPID_AngryVillager));	
	xsEffectAmount(cSetAttribute, xsArrayGetInt(QARRID_PawnBuildingIds, cQPID_AngryVillager), cIconId, xsArrayGetInt(QARRID_PawnBuildingIconIds, cQPID_AngryVillager)); // 28 Town Center Icon
	xsEffectAmount(cSetAttribute, xsArrayGetInt(QARRID_PawnBuildingIds, cQPID_AngryVillager), cWoodCost, xsArrayGetInt(QARRID_PawnBuildingWoodCosts, cQPID_AngryVillager));

	// Spearboy - Slot Economy 2 - Overrides Mill - 15 Wood           
 	xsEffectAmount(cSetAttribute, xsArrayGetInt(QARRID_PawnBuildingIds, cQPID_Spearboy), cNameId, xsArrayGetInt(QARRID_PawnNameIds, cQPID_Spearboy));	
 	xsEffectAmount(cSetAttribute, xsArrayGetInt(QARRID_PawnBuildingIds, cQPID_Spearboy), cDescriptionId, xsArrayGetInt(QARRID_PawnDescIds, cQPID_Spearboy));
	xsEffectAmount(cSetAttribute, xsArrayGetInt(QARRID_PawnBuildingIds, cQPID_Spearboy), cShortTooltipId, xsArrayGetInt(QARRID_PawnDescIds, cQPID_Spearboy));
	xsEffectAmount(cSetAttribute, xsArrayGetInt(QARRID_PawnBuildingIds, cQPID_Spearboy), cExtendedTooltipId, xsArrayGetInt(QARRID_PawnDescIds, cQPID_Spearboy));	
	xsEffectAmount(cSetAttribute, xsArrayGetInt(QARRID_PawnBuildingIds, cQPID_Spearboy), cIconId, 72); // 72 Palisade Wall Icon
	xsEffectAmount(cSetAttribute, xsArrayGetInt(QARRID_PawnBuildingIds, cQPID_Spearboy), cWoodCost, 15);
																					 
																					 
	// Spearboy - Slot Economy 2 - Overrides Lumber Camp - 20 Wood           
 	xsEffectAmount(cSetAttribute, xsArrayGetInt(QARRID_PawnBuildingIds, cQPID_Warrior), cNameId, xsArrayGetInt(QARRID_PawnNameIds, cQPID_Warrior));	
 	xsEffectAmount(cSetAttribute, xsArrayGetInt(QARRID_PawnBuildingIds, cQPID_Warrior), cDescriptionId, xsArrayGetInt(QARRID_PawnDescIds, cQPID_Warrior));
	xsEffectAmount(cSetAttribute, xsArrayGetInt(QARRID_PawnBuildingIds, cQPID_Warrior), cShortTooltipId, xsArrayGetInt(QARRID_PawnDescIds, cQPID_Warrior));
	xsEffectAmount(cSetAttribute, xsArrayGetInt(QARRID_PawnBuildingIds, cQPID_Warrior), cExtendedTooltipId, xsArrayGetInt(QARRID_PawnDescIds, cQPID_Warrior));	
	xsEffectAmount(cSetAttribute, xsArrayGetInt(QARRID_PawnBuildingIds, cQPID_Warrior), cIconId, 2); // 2 Barracks Icon
	xsEffectAmount(cSetAttribute, xsArrayGetInt(QARRID_PawnBuildingIds, cQPID_Warrior), cWoodCost, 20);
	
	// xsEffectAmount(cSetAttribute, xsArrayGetInt(QARRID_PawnBuildingIds, cQPID_Spearboy), cTrainButton, 1); 
}


/// @method qqUpdateFirstWave
/// Triggers initial infomation dialogs and sets up the variables for the next update wave.
/// ONLY called once at the start. First wave will not spawn any units.
void qqUpdateFirstWave(){

}

// This should be called from an editor trigger every 60 seconds (wave duration).
void qqUpdateWave(){
	// Per player...
	for(player = 0; < xsGetNumPlayers()){
		qqGetPawnBuildingCount(player); 
		qqSpawnWaveUnits(player);
	}
	
	// Per Team...
	// West
	qqActivateTrigger_AttackMoveArmyToEnemyCastle(cQWestTeamSide);
	
	// East
	qqActivateTrigger_AttackMoveArmyToEnemyCastle(cQEastTeamSide);	
}	
	
void main() {
	qqConfigureScenarioPlayers();	
	qqUpdateFirstWave();
	
    xsChatData("Script Loaded.");
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// @project: [CAF] Core Application Framework
// @author(s): Anton Yashchenko
// @website: https://www.acpp.dev
// @created: 2025/07/23
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

