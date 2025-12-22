///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright 2025 Anton Yashchenko
// Licensed under the MIT License.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// @project: Anton's AOE2 DE XS Script Extensions
// @author(s): Anton Yashchenko (Steam Name: Dave East Jones)
// @website: https://www.acpp.dev
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// @file DEUnitTrait.xs
/// @brief A combinable bitfield attribute of a unit(object) which gives it a special ability. Each Trait has unique 
///		  interactions with other objer attributes. Some traits also have a "Trait Piece", this is usually the object 
///		  created by the Trait's provided ability. 
/// 
/// - DEUnitTrait_Garrison : 1
///     Gives unit the ability to garrison other units. Rams, Siege Tower, Transport Ship.
///
///	- DEUnitTrait_Ship : 2
///		Objects with this trait	: All ships, and Siege Tower
///	
/// - DEUnitTrait_Builder : 4
///		Adds ability to place a building, trait piece is the target building. Serjant.
///
/// - DEUnitTrait_Transformable : 8
///  	Adds ability to transform into unit or building , trait piece is target. Ratha, War Chariot, Immortal.
///
/// - DEUnitTrait_AutoScout : 16
/// 	Enables Auto Scout button if modified and placed at start of the game. All scouts, wild horse and camel.
///
/// - DEUnitTrait_Biological : 32 		
/// 	??? Unknown effect ??? Unused 
///
/// - DEUnitTrait_SelfShielding : 64 	
/// 	??? Unknown effect ??? Used by "DOCK ARCHAIC AGE 1" (Object IDs: 2141, 2142, 2143, 2172)
///
/// - DEUnitTrait_Invisible : 128 		
/// 	??? Unknown effect ???  Unused
///
///
/// The official documentation on Traits says: 
/// 	"
//		This is a combinable bit field. Controls the following properties:
///			Property 		| Flag Value
///			Garrison Unit		1
///			Ship Unit			2
///			Build Another Building (Serjeants) [See Special Ability: Mode 7]	4
/// 		Transform Into Another Unit (Ratha)									8
/// 		Auto Scout Unit														16
///		"
///
/// The Advanced Genie Editor says something else, and has different names, and more traits:
/// ??? what does "SW" stand for ??? 
/*
			Trait Piece: leftover from attribute+civ variable probably useless. (wrong)
			Trait Bits(8 in order): 
				- Garrison Unit
				- Ship Unit
				- SW: Stealth Unit
				- SW: Detector Unit
				- SW: Mechanical Unit
				- SW: Biological Unit
				- SW: Self-Shielfing Unit
				- SW: Invisible Unit
*/		
/// 
/// aoefandom info:
/*
		1 - Garrison unit - for units which can garrison other units, like Transport Ships and Siege Towers
		2 - Ship unit
		4 - Builder unit - can place foundation of a single type of building 
			(theoretically (the unit also needs a corresponding task to enable it to build)), which is given by Attribute 56
		8 - Transformable unit - can transform into another unit which is given by Attribute 56, 
		    using the switch weapon button (only works for soldiers) 
			[not related "transformation unit" attribute used by Trebuchet / packed town center, 
			it's a different mechanic depending on unit class value 51 "packed unit" and the "transformation unit" attribute field]
		16 - Scout unit - enables Auto Scout button if modified and placed at start of the game
		
	Object Attribute 56 - Unit Trait Piece [Trait Piece in Unit stats; Nothing in search bar]
	
	- For Builder unit flag: Units can build Unit Trait Piece only when the unit has Unit Trait flag 4 at least (but not 8), 
	the Trait Piece is a building (in earlier versions, building creatable units like Transport Ships would crash the game), 
	the building is enabled (like Castles are enabled in Castle Age but disabled before that), the unit has the task to enable 
	building in general (like Builders and Fishing Ships) or enable building the Trait Piece (Serjeants have a task to enable building Donjons). 
	Despite Fishing Ships having the task to build, they are hardcoded not to build any building other than Fish Traps, however this hardcoded
	behavior does not stop them from placing the foundation of the Trait Piece.
	
	- For Transformable unit flag: Unit Transformation among units is not reciprocal by default. 
	Both units need to be modified to convert into one another. If the Unit Trait Piece is a building, the object 
	turns into a Moveable Map Revealer, which contrary to its name, cannot move.
	
	- For Active Transformation (see Charge Type): Transforms into this unit
*/
/// @ref https://ugc.aoe2.rocks/general/attributes/attributes/#54-unit-trait
///		 https://ugc.aoe2.rocks/general/xs/constants/?h=trait#947-ctraits
/// 	 https://ageofempires.fandom.com/wiki/Genie_Editor#Attributes
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

extern const int DEUnitTrait_Garrison = 1;			// Can garrison other units.
extern const int DEUnitTrait_Ship = 2;              // ??? Unknown effect ??? 
extern const int DEUnitTrait_Builder = 4; 			// Ability to place a building, trait piece is the target building. 
extern const int DEUnitTrait_Transformable = 8;  	// Ability to transform into unit or building , trait piece is target.
extern const int DEUnitTrait_AutoScout = 16;       	// Enables Auto Scout button if modified and placed at start of the game.

// undocumented
extern const int DEUnitTrait_Biological = 32; 		// ??? Unknown effect ???
extern const int DEUnitTrait_SelfShielding = 64; 	// ??? Unknown effect ???
extern const int DEUnitTrait_Invisible = 128; 		// ??? Unknown effect ???

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
