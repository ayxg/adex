from genieutils.datfile import DatFile
from AoE2ScenarioParser.scenarios.aoe2_de_scenario import AoE2DEScenario
from AoE2ScenarioParser.datasets.players import PlayerId
from AoE2ScenarioParser.datasets.units import UnitInfo
  

def de_xx_triggers_scenario(
  aoedata,    # your game's empires.dat parsed DatFile from genieutils.datfile
  in_scenario_path, # input scenario path
  out_scenario_path # output scenario path 
):
  """
  Generates support triggers for Anton's AOE2DE XS Extensions.
  !! Warning, as soon as you click these triggers in the editor they will be corrupted, because these techs
     dont exist.

  =============== Triggers Generated ===============
    - xxTechCallback[tech_id]Player[pid] :
        Currently there is no way to check if a tech is researched from XS without researching it
        on availability. `xsResearchTechnology` always researches tech if its available. 
        This adds a tech callback which calls to xs function `xxTechCallbackP{PlayerId.ONE}T{tech_idx}`.
        In your xs script define the function xxTechCallbackP{PlayerId.ONE}T{tech_idx} to enable.
        Since the trigger won't run if the function does not exit,no additional activation is required.

    - xxSetTechCost[tech_id]Player[pid] : 
        Trigger or copy in-game for un-selectable techs.

    - xxSetTechName[tech_id]Player[pid] : 
        Trigger or copy in-game for un-selectable techs.

    - xxSetTechDesc[tech_id]Player[pid] : 
        Trigger or copy in-game for un-selectable techs.

  """
  m_scenario = AoE2DEScenario.from_file(in_scenario_path)
  m_triggers = m_scenario.trigger_manager
  for tech_idx, tech in enumerate(aoedata.techs):
    for player_idx in range(0, 8):
      trig_res_tech = m_triggers.add_trigger(
        enabled = True,
        looping	= False,
        name = 	f"xxTechCallback{tech_idx}Player{player_idx}[{tech.name}]"
      )
      trig_res_tech.new_condition.research_technology(
        technology = tech_idx,
        source_player = player_idx
      )
      trig_res_tech.new_effect.script_call(message = f"xxTechCallback{tech_idx}Player{player_idx}")
      #trig_res_tech.new_effect.send_chat(message = f"xxTechCallback{tech_idx}Player{player_idx}")
           

      trig_edit_tech = m_triggers.add_trigger(
        enabled = False,
        looping	= False,
        name = 	f"xxSetTechCost{tech_idx}Player{player_idx}[{tech.name}]"
      )
      trig_edit_tech.new_effect.change_technology_cost(
          source_player = player_idx,
          technology = tech_idx
      )


      trig_edit_tech = m_triggers.add_trigger(
        enabled = True,
        looping	= False,
        name = 	f"xxSetTechName{tech_idx}Player{player_idx}[{tech.name}]"
      )   
      trig_edit_tech.new_effect.change_technology_name(
          source_player = player_idx,
          technology = tech_idx,
          message = f"[{tech_idx}][Player{player_idx}][{tech.name}]"
      )

      trig_edit_tech = m_triggers.add_trigger(
        enabled = True,
        looping	= False,
        name = 	f"xxSetTechDesc{tech_idx}Player{player_idx}[{tech.name}]"
      )   
      trig_edit_tech.new_effect.change_technology_description(
          source_player = player_idx,
          technology = tech_idx,
          message = f"xxSetTechName{tech_idx}Player{player_idx}[{tech.name}]"
      )
  m_scenario.write_to_file(out_scenario_path)