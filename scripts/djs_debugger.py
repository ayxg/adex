from itertools import count

from genieutils.datfile import DatFile
from AoE2ScenarioParser.scenarios.aoe2_de_scenario import AoE2DEScenario
from AoE2ScenarioParser.datasets.players import PlayerId
from AoE2ScenarioParser.datasets.units import UnitInfo

# AOE2DE-Analyzer Data
from de_data_new_tech import DE_DATA_NEW_TECH

class DjsTech:
  def __init__(self, ident: int, name: str = "", desc: str = ""):
    self.id = ident
    self.name = name
    self.desc = desc

class DjsTechHut:
  def __init__(self, ident: int,name: str = "", desc: str = "", techs: list[DjsTech] = []):
    self.id = ident
    self.name = name
    self.desc = desc
    self.techs = techs

DJS_BUILDING_ID_TECHHUT0 = 1082;
DJS_BUILDING_ID_TECHHUT1 = 1083;
DJS_BUILDING_ID_TECHHUT2 = 1084;
DJS_BUILDING_ID_TECHHUT3 = 1085;
DJS_BUILDING_ID_TECHHUT4 = 1086;

DJS_BUILDING_ID_TECHHUT5 = 713;
DJS_BUILDING_ID_TECHHUT6 = 714;
DJS_BUILDING_ID_TECHHUT7 = 715;
DJS_BUILDING_ID_TECHHUT8 = 716;
DJS_BUILDING_ID_TECHHUT9 = 717;

_main_menu_tech_idx = count(0)
_object_explorer_tech_idx = count(0)
# Main menu
DJS_TECHHUT_MAINMENU = DjsTechHut(
  DJS_BUILDING_ID_TECHHUT0, "Main Menu", "Main Menu", [
    DjsTech(DE_DATA_NEW_TECH[next(_main_menu_tech_idx)], "Object Explorer", "Open the Object Explorer to manage objects."),
    DjsTech(DE_DATA_NEW_TECH[next(_main_menu_tech_idx)], "Tech Viewer", "Open the Tech Viewer to manage technologies.")
  ])

# Object Explorer Controller Buildings
DJS_TECHHUT_OBJEXPLORER_CONTROLLER = DjsTechHut(
  DJS_BUILDING_ID_TECHHUT0, "Object Explorer", "Object Explorer", [
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Previous Object ID -1"   ,"Previous Object ID -1"), 		
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Next Object ID +1"       ,"Next Object ID +1"), 
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Spawn Object On Land"    ,"Spawn Object On Land"), 		
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Spawn Object On Water"   ,"Spawn Object On Water"), 
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Save To Bank Object"     ,"Save To Bank Object"),
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Previous Object ID -10"  ,"Previous Object ID -10"), 	
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Next Object ID +10"      ,"Next Object ID +10"), 	
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Kill Objects"            ,"Kill Objects"), 
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Switch To Bank Object"   ,"Switch To Bank Object"), 
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Upgrade To Bank Object"  ,"Upgrade To Bank Object"),
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Previous Object ID -100" ,"Previous Object ID -100"), 	
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Next Object ID +100"     ,"Next Object ID +100"), 
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Previous Object ID -1000","Previous Object ID -1000"), 	
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Next Object ID +1000"    ,"Next Object ID +1000")	
  ])

DJS_TECHHUT_OBJEXPLORER_GFXMOD = DjsTechHut(
  DJS_BUILDING_ID_TECHHUT1, "Graphics Modder", "Graphics Modder", [
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Previous Graphic ID -1"   ,"Previous Graphic ID -1"), 		
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Next Graphic ID +1"       ,"Next Graphic ID +1"), 
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Prev Graphic Type","Prev Graphic Type"),
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Next Graphic Type","Next Graphic Type"),
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Copy Graphic From Bank","Copy Graphic From Bank"),  
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Previous Graphic ID -10"  ,"Previous Graphic ID -10"), 	
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Next Graphic ID +10"      ,"Next Graphic ID +10"), 	
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Apply Graphic","Apply Graphic"), 
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Revert Graphic","Revert Graphic"), 
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Clone Graphics From Bank","Clone Graphics From Bank"),
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Previous Graphic ID -100" ,"Previous Graphic ID -100"), 	
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Next Graphic ID +100"     ,"Next Graphic ID +100"), 
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Previous Graphic ID -1000","Previous Graphic ID -1000"), 	
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Next Graphic ID +1000"    ,"Next Graphic ID +1000")	
  ])

DJS_TECHHUT_OBJEXPLORER_SOUNDMOD = DjsTechHut(
  DJS_BUILDING_ID_TECHHUT2, "Sound Modder", "Sound Modder", [
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Previous Sound ID -1","Previous Sound ID -1"), 		 		
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Next Sound ID +1","Next Sound ID +1"), 
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Prev Sound Type","Prev Sound Type"),
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Next Sound Type","Next Sound Type"),
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Copy Sound From Bank","Copy Sound From Bank"),
  
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Previous Sound ID -10","Previous Sound ID -10"), 	
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Next Sound ID +10","Next Sound ID +10"),	
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Apply Sound","Apply Sound"), 
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Revert Sound","Revert Sound"), 
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Clone Sounds From Bank","Clone Sounds From Bank"),

    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Previous Sound ID -100","Previous Sound ID -100"), 	
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Next Sound ID +100","Next Sound ID +100"), 
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Previous Sound ID -1000","Previous Sound ID -1000"), 	
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Next Sound ID +1000","Next Sound ID +1000"), 	
  ])

DJS_TECHHUT_OBJEXPLORER_TRAITSMOD = DjsTechHut(
  DJS_BUILDING_ID_TECHHUT3, "Traits Modder", "Traits Modder", [
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"[ON/OFF] Unit Trait : Garrison","""[ON/OFF] Unit Trait : Garrison
Gives unit the ability to garrison other units. Rams, Siege Tower, Transport Ship."""),

    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"""[ON/OFF] Unit Trait : Ship""","""[ON/OFF] Unit Trait : Ship
??? Unknown Effect ??? All ships, and Siege Tower."""),

    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"""[ON/OFF] Unit Trait : Builder""","""[ON/OFF] Unit Trait : Builder
Adds ability to place a building, trait piece is the target building. Serjant."""),

    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"""[ON/OFF] Unit Trait : Transformable""","""[ON/OFF] Unit Trait : Transformable
Adds ability to transform into unit or building , trait piece is target. Ratha, War Chariot, Immortal."""),

    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"""Set Piece from Bank""","""Set Piece from Bank
Set the trait piece ID to the banked object's ID.'"""),

    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"""[ON/OFF] Unit Trait : AutoScout""","""[ON/OFF] Unit Trait : AutoScout
Enables Auto Scout button if modified and placed at start of the game. All scouts, wild horse and camel."""), 

    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"""[ON/OFF] Unit Trait : Biological""","""[ON/OFF] Unit Trait : Biological
??? Unknown effect ??? Unused"""), 		

    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"""[ON/OFF] Unit Trait : SelfShielding""","""[ON/OFF] Unit Trait : SelfShielding
??? Unknown effect ??? Used by "DOCK ARCHAIC AGE 1" (Object IDs: 2141, 2142, 2143, 2172)"""), 

    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"""""","""[ON/OFF] Unit Trait : Invisible
??? Unknown effect ???  Unused"""), 	

    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"""Copy Traits from Bank""","""Copy Traits from Bank
Copy traits and trait piece from banked object.'"""),

    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"""Revert Traits""","""Revert Traits
Revert traits to last spawned unit's original traits."""),

    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"""""","""Apply Traits
Apply set traits to last spawned unit."""), 	

    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"""Enable Piece""","""Enable Piece
Enable the object set as trait piece for player 1. (to allow building)"""),

    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"""Revert Piece""","""Revert Piece
Revert to the objects original trait piece."""),
  ])

DJS_TECHHUT_OBJEXPLORER_ABIMOD = DjsTechHut(
  DJS_BUILDING_ID_TECHHUT4, "Ability Modder", "Ability Modder", [
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Prev Charge Event","""Prev Charge Event """),
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"""Next Charge Event""","""Next Charge Event """),
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"""Prev Combat Ability""","""Prev Combat Ability"""),
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"""Next Combat Ability""","""Next Combat Ability"""),
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"""Apply""","""Apply """),
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"""Prev Charge Type""","""Prev Charge Type"""), 
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"""Next Charge Type""","""Next Charge Type"""), 		
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"""Prev Special Ability""","""Prev Special Ability"""), 
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Next Special Ability","""Next Special Ability"""), 	
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"""Revert""","""Revert"""),
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"""Copy Bank Charge Type""","""Copy Bank Charge Type"""),
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"""Copy Bank Charge Event""","""Copy Bank Charge Event"""),
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"""Copy Bank Combat Ability""","""Copy Bank Combat Ability"""),
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"""Copy Bank Special Ability""","""Copy Bank Special Ability""")
  ])

DJS_TECHHUT_OBJEXPLORER_ABIATTRMOD = DjsTechHut(
  DJS_BUILDING_ID_TECHHUT5, "Ability Attributes Modder", "Ability Attributes Modder", [
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Previous Attribute Value -1"   ,"Previous Attribute Value -1"), 		
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Next Attribute Value +1"       ,"Next Attribute Value +1"), 
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Prev Attribute Type","Prev Attribute Type"),
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Next Attribute Type","Next Attribute Type"),
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Copy Attribute From Bank","Copy Attribute From Bank"),  
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Previous Attribute Value -10"  ,"Previous Attribute Value -10"), 	
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Next Attribute Value +10"      ,"Next Attribute Value +10"), 	
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Apply Attribute","Apply Attribute"), 
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Revert Attribute","Revert Attribute"), 
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Clone Attributes From Bank","Clone Attributes From Bank"),
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Previous Attribute Value -100" ,"Previous Attribute Value -100"), 	
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Next Attribute Value +100"     ,"Next Attribute Value +100"), 
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Previous Attribute Value -1000","Previous Attribute Value -1000"), 	
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Next Attribute Value +1000"    ,"Next Attribute Value +1000")	
  ])


DJS_TECHHUT_OBJEXPLORER_ENCYCLOPEDIA_PAGE1 = DjsTechHut(
  DJS_BUILDING_ID_TECHHUT6, "Encyclopedia Page 1 - Builders/Spawners", "Encyclopedia Page 1 - Builders/Spawners", [
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Villager","Villager"), 		
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Fishing Ship","Fishing Ship"), 
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Packed Town Centre","Packed Town Centre"),
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Serjant","Serjant"),
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Zhuge Liang","""Zhuge Liang
Release Kongming Lantern (active ability):
The ability is activated by clicking its icon in the unit's command panel.
It releases a stationary sky lantern which rises for 4 seconds, then reveals a Line of Sight of radius 20 for another 8 seconds.
It has a 20 second cooldown, which starts recharging as soon as the ability is triggered.
"""),  
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Kongming Lantern"  ,"Zhuge Liang's Kongming Lantern"), 	
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Kongming Lantern Dead" ,"Zhuge Liang's Kongming Lantern Dead"), 	
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Trebuchet(Unpacked)","""Trebuchet(Unpacked)
Similar to Packed Town Center, trebuchet can train objects like a building.
"""), 
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Trebuchet(Packed)","""Trebuchet(Unpacked)
Similar to Packed Town Center, trebuchet can train objects like a building.
"""), 
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Reserved","Reserved"),
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Reserved","Reserved"),
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Reserved","Reserved"),
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Reserved","Reserved"),
    DjsTech(DE_DATA_NEW_TECH[next(_object_explorer_tech_idx)],"Next Page","""Next Page
Go to next encyclopedia page.
""")
  ])

DEJ_TECHHUT_LIST_OBJEXPLORER = [
  DJS_TECHHUT_OBJEXPLORER_CONTROLLER, 
  DJS_TECHHUT_OBJEXPLORER_GFXMOD, 
  DJS_TECHHUT_OBJEXPLORER_SOUNDMOD, 
  DJS_TECHHUT_OBJEXPLORER_TRAITSMOD, 
  DJS_TECHHUT_OBJEXPLORER_ABIMOD, 
  DJS_TECHHUT_OBJEXPLORER_ABIATTRMOD,
  DJS_TECHHUT_OBJEXPLORER_ENCYCLOPEDIA_PAGE1
]

# Make trigger which configures a DEJ tech hut building and all it's technologies.
# Also creates a dispatch trigger so that you never have to click the trigger and mangle it in the in-game editor
def mktrig_configure_tech_hut(trigs,building_list,prefix = '[CG]'):
  dispatch_trigs = []
  for building in building_list:
    ntrig = trigs.add_trigger(prefix + f"|configure_tech_hut|{building.name}", enabled = False, looping = False)
    ntrig.new_effect.change_object_name(building.id, PlayerId.ONE, message = building.name)
    for tech in building.techs:
      ntrig.new_effect.change_technology_name(PlayerId.ONE,tech.id,None,tech.name)
      ntrig.new_effect.change_technology_description(PlayerId.ONE,tech.id,None,tech.desc)

    dispatch_trig = trigs.add_trigger(
      enabled = False,
      looping	= False,
      name = f"{prefix}|apply_configure_tech_hut|{building.name}"
    )
    dispatch_trig.new_effect.activate_trigger(ntrig.trigger_id)
    dispatch_trigs.append(dispatch_trig)

  # Add a trigger which actives all dispatch triggers

  dispatch_all_trig = trigs.add_trigger(
    enabled = False,
    looping	= False,
    name = f"{prefix}|apply_configure_tech_hut|all"
  )
  for dispatch_trig in dispatch_trigs:
    dispatch_all_trig.new_effect.activate_trigger(dispatch_trig.trigger_id)

# Setup custom XS script tech callbacks for all DE_DATA_NEW_TECH for player X
def mktrig_new_tech_callbacks(trigs, player_idx: int = PlayerId.ONE,prefix = '[CG]'):
  for tech_idx, tech_id in enumerate(DE_DATA_NEW_TECH):
    trig_res_tech = trigs.add_trigger(
      enabled = True,
      looping	= True,
      name = 	f"{prefix}|xxNewTechCallback{tech_idx}Player{player_idx}"
    )
    trig_res_tech.new_condition.research_technology(
      technology = tech_id,
      source_player = player_idx
    )
    trig_res_tech.new_effect.script_call(message = f"xxNewTechCallback{tech_idx}Player{player_idx}")


def remove_all_triggers(trigs):
  to_remove = []
  for trig in trigs.triggers:
    trigs.remove_trigger(trig.trigger_id)

# Generate DEJ Debugger Scenario
def generate_scenario(input_scenario_path: str, output_scenario_path: str):
  scenario = AoE2DEScenario.from_file(input_scenario_path)
  remove_all_triggers(scenario.trigger_manager)
  mktrig_configure_tech_hut(scenario.trigger_manager, {DJS_TECHHUT_MAINMENU}, "[MainMenu]")
  mktrig_configure_tech_hut(scenario.trigger_manager, DEJ_TECHHUT_LIST_OBJEXPLORER, "[ObjectExplorer]")
  #mktrig_new_tech_callbacks(scenario.trigger_manager, PlayerId.ONE)
  scenario.write_to_file(output_scenario_path)

