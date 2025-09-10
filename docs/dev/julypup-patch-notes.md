# AoE II: DE – Update 153015 - Modder's Patch Notes
Modified patch notes for modders.

Based on: https://www.ageofempires.com/news/age-of-empires-ii-definitive-edition-update-153015

## Bug Fixes
- Civilian button slot 15 will now work correctly when setting train/research location if there is no task at that slot.
- **Military button slot 15 ? Will it go to next window or changed to 16?**

- Technology state attribute values recieved from new `xsGetTechState` do NOT align with tech state attribute values passed to `xsEffectAmount(cModifyTech, tech_id, cAttrSetState, value);` or :
    | Name             | Old | xsGetTechState |
    |------------------|-----|--------|
    | NOTREADY         | 1   | 0      |
    | READY / ENABLED  | 2   | 1      |
    | QUEUED           | 5   | 4      |
    | RESEARCHING      | 3   | 2      |
    | DONE             | 4   | 3      |
    | DISABLED         | 0   | -1     |
    | INVALID          | —   | -2     |

# Official Patch Notes Reference

## Scripting
- Sending multiple military explorers no longer causes the exploration to fail.
- Fixed an issue where civilian explorers would sometimes freeze instead of exploring.
- Fixed an issue where AI foundations may not get cancelled when sn-disable-defend-groups is used.
- Fixed an issue forcing AI to repair towers.
- Added object-data-attack-delay with ID 90 which returns the frame delay time calculated from Frame Delay attribute of the unit and the duration of its attack animation.

## General
- Added KEEP_MODS_AFTER_CRASH launch parameter to keep the mods enabled if the previous game session has crashed.
- Added a new ExtendedDifficultyList parameter for custom campaign layout json files; setting it to true enables Easiest and Legendary difficulty options for the campaign.
- History screen data is no longer hardcoded; now contained in history.json file in widgetui folder.
- The amount of Technology Tree Preview categories is no longer limited to a hardcoded amount. The label widgets for each display category in techtreepreviewpanel.json must now be named LabelN and ItemsN.
- The train limit functionality (controlled by Available and Disabled unit attributes) can now also be used for limiting the construction of buildings.
- Added a new flag 8 for Disabled attribute to remove the train/build button from UI if the train/build limit is reached.
- Allowed stingers (Task 157) to be applied by Projectile (Type 60) units.
- Fixed an issue where Multiply Resource effect type did not perform the correct action when used in effect amount commands.
- Spawn Unit effect type used in effect amount commands is now able to spawn gaia-only objects.
- Unit voices for DLC civilizations (starting from Romans) are now moddable in non-data mods.
- Trade units that are in the process of trading can now hold multiple resource types. New resources 70 and 71 “Source Market or Dock X/Y Coordinate” can now be used to designate the trading point.
- Added new resource 203 “Reveal Map”:
    - When set to 1, will reveal the map (explored) for the player
    - When set to 2, will reveal the map (fully visible) for the player
- Added new resource 204 “Reveal Unit on Map”. Its value will reveal all instances of a specified unit type ID or class ID (900-based) when set:
    - When the ID is positive, explores the units at the time of creation and/or resource assignment
    - When the ID is negative, makes the units fully visible
- Resource 262 “Civilization Name Override” will now work correctly.
- Allowed modifying the following unit attributes by Effect Amount, Modify Attribute trigger effect and technologies in data with the IDs:
    - Special Ability (81)
    - Idle Attack Graphic (82)
    - Hero Glow Graphic (83)
    - Garrison Graphic (84)
    - Construction Graphic (85)
    - Snow Graphic (86)
    - Destruction Graphic (87)
    - Destruction Rubble Graphic (88)
    - Researching Graphic (89)
    - Research Completed Graphic (90)
    - Damage Graphic (91)
    - Selection Sound (92)
    - Selection Sound Event (93)
    - Dying Sound (94)
    - Dying Sound Event (95)
    - Train Sound (96)
    - Train Sound Event (97)
    - Damage Sound (98)
    - Damage Sound Event (99)
    - Attack Graphic 2 (131)
    - Command Sound (132)
    - Command Sound Event (133)
    - Move Sound (134)
    - Move Sound Event (135)
    - Construction Sound (136)
    - Construction Sound Event (137)
    - Transform Sound (138)
    - Transform Sound Event (139)
    - Run Pattern (140)
    - Interface Kind (141)
    - Combat Level (142)
    - Interaction Mode (143)
    - Minimap Mode (144)
    - Trailing Unit (145)
    - Trail Mode (146)
    - Trail Density (147)
    - Projectile Graphic Displacement X (148)
    - Projectile Graphic Displacement Y (149)
    - Projectile Graphic Displacement Z (150)
    - Projectile Spawning Area Width (151)
    - Projectile Spawning Area Length (152)
    - Projectile Spawning Area Randomness (153)
    - Damage Graphics Entry Mod (154)
    - Damage Graphics Total Num (155)
    - Damage Graphic Percent (156)
    - Damage Graphic Apply Mode (157)

## Scenario Editor
- Added new “Modify Object Attribute” and “Modify Object Attribute By Variable” trigger effects which can modify stats of specific units on the map with all functionality, supported attributes and fields from “Modify Attribute” effect. Units targeted by these effects will no longer be affected by technologies, same as after receiving effect from other object-targeting trigger effects.
- Added new “Modify Attribute for Class” trigger effect which works like “Modify Attribute” but based on the specified unit class.
- Added new “Research Local Technology” trigger effect which allows to research a technology that applies its effect within the marked map area and/or towards selected units only.
- Added new “Add Train Location” trigger effect to assign additional train location settings for the specific unit type.
- Trigger effects such as “Change Diplomacy”, “Patrol”, “Attack Move”, and “Task Object” will now instantly perform their function upon firing without being affected by network delay.
- The “Change Object Caption” trigger effect now supports entering custom strings, rather than just string IDs.
- Certain object attributes in the “Modify Attribute” family of effects now support floating-point values.
- Added an option to reset the starting view for the player.
- Added a previously missing technology to detect Wei civilization in “Research Technology” trigger condition.
- Changed the name of Penguin cheat unit to “War Penguin”.
- Pressing Ctrl+Space in the Editor will now correctly start the Test of the current Scenario, instead of hanging indefinitely on the loading screen.

## XS Scripting
- Allowed calling XS functions from technology effects and effect amount commands by setting resource 33 to a positive integer value. This would call xs function EffectFunctionN with playerId argument, where N is the value the resource was set to, playerId is the player who fired the effect which modified resource 33. These functions are stored in a new Effects.xs file.
- xsTaskAmount, xsTask, xsRemoveTask functions are no longer limited to scenario games.
Fixed an issue where object group-targeting tasks added by xsTask function were overwriting the previously added tasks.
- Added support for all task attributes to be set in xsTaskAmount. Refer to Constants.xs.
- Added an optional parameter int damageClass for the xsGetObjectAttribute function, to allow getting armor/attack from specific damage classes. The usage for non armor/attack related attributes remains exactly the same. See Constants.xs for relevant constants
    - Usage: xsGetObjectAttribute(1, 4, cArmor, cDamageClassPierce);
- Fixed float atan2(float y, float x) to take two parameters

- Added new XS functions:

| Prototype | Documentation |
|-----------|---------------|
| `void xsResetTaskAmount()` | Resets all task values set by `xsTaskAmount` to their default values, avoiding unintentional applying of previously used task attributes |
| `int xsGetTurn()` | Returns the current game turn (similar to tick; high-frequency rules run every turn) |
| `int xsGetPlayerUnitIds(int objectId, int playerId, int xsArrayId)` | Returns an array of unit IDs. The third parameter is optional and may be used to re-use an existing array |
| `float xsGetUnitAttribute(int unitId, int attribute, int damageClass)` | — |
| `bool xsDoesUnitExist(int unitId)` | — |
| `int xsGetUnitOwner(int unitId)` | — |
| `string xsGetPlayerName(int playerId)` | — |
| `vector xsGetUnitPosition(int unitId)` | — |
| `string xsGetUnitName(int unitId, bool internalName = false)` | — |
| `int xsGetUnitTargetUnitId(int unitId)` | — |
| `vector xsGetUnitMoveTarget(int unitId)` | — |
| `int xsGetUnitGroupId(int unitId)` | Group as in one selection (formation) |
| `vector xsGetGroupMoveTarget(int groupId)` | — |
| `string xsGetObjectName(int objectId, int playerId, bool internalName = false)` | — |
| `bool xsIsObjectAvailable(int objectId, int playerId)` | — |
| `string xsGetTechName(int techId, int playerId)` | — |
| `int xsGetTechState(int techId, int playerId)` | See `Constants.xs` for relevant constants |
| `float xsGetUnitHitpoints(int unitId)` | — |
| `bool xsSetUnitHitpoints(int unitId, float value)` | — |
| `float xsGetUnitBuildPoints(int unitId)` | — |
| `bool xsSetUnitBuildPoints(int unitId, float value)` | — |
| `int xsGetUnitObjectId(int unitId)` | — |
| `int xsGetUnitCopyId(int unitId)` | — |
| `int xsGetObjectCopyId(int playerId, int objectId)` | — |
| `int xsGetUnitClass(int unitId)` | — |
| `int xsGetObjectClass(int playerId, int objectId)` | See `Constants.xs` for relevant constants |
| `int xsGetUnitType(int unitId)` | — |
| `int xsGetObjectType(int playerId, int objectId)` | See `Constants.xs` for relevant constants |
| `int xsGetUnitAttributeTypesHeld(int unitId)` | Returns an array with all resource types held by the current unit. Most units (except trading units) can currently only hold 1 of each resource type. |
| `float xsGetUnitAttributeHeld(int unitId, int attributeId = -1)` | — |
| `bool xsSetUnitAttributeHeld(int unitId, float value, int attributeId = -1)` | — |
| `float xsGetUnitCharge(int unitId)` | — |
| `bool xsSetUnitCharge(int unitId, float value)` | — |
| `float atan2v(vector v)` | Equivalent to `atan2(xsVectorGetY(v), xsVectorGetX(v))` |
| `float exp(float x)` | — |
| `float ceil(float x)` | — |
| `float floor(float x)` | — |
| `float bitCastToFloat(int number)` | — |
| `int bitCastToInt(float number)` | — |


# Data File
- Added support for multiple train location for units.
- Added support for multiple research location for technologies.
- Added a new flag 16 for Sequence Type graphic attribute to allow reverse playback of the animation.
- New adjustable parameters for Task 10: Fly
    - Carry Check: Distance the unit is allowed to move from its starting position before picking a new direction to return closer
    If 0, no limit
    - Search Wait Time: Time in seconds that the unit pauses, playing the idle animations, when changing direction
    - Work Value 1: Unit speed multiplier while roaming
    - Work Value 2: Unit ID to avoid
    - Work Range: Minimum distance to the unit to avoid that will be maintained while roaming
    - Terrain: Terrain Table that the unit will be allowed to roam on. If -1, use the unit’s terrain table
    - Moving Graphic, Proceeding Graphic, Working Graphic: Graphics used for the unit moving around, randomly alternates between them
        - Currently Working Graphic is unused, and Standing Graphic is used instead
        - If none of these is set, use the unit’s normal Walking Graphic
    - Unused Flag: If set to 1, only roam around if the unit is owned by Gaia