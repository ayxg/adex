import argparse

# AOE2 External Utils
from genieutils.datfile import DatFile
from AoE2ScenarioParser.scenarios.aoe2_de_scenario import AoE2DEScenario
from AoE2ScenarioParser.datasets.players import PlayerId

# AOE2DE-Analyzer Scripts
import de_tech
import de_xx_triggers

# Scenarios
import djs_debugger


# Paths for this repo (NEVER output to source - only to binary path)
PY_AOE_DATFILE_PATH = "../res/aoedat/empires2_x2_p1.dat"
PY_DATA_BINARY_PATH = "../out/build/scripts_out"
PY_DATA_SOURCE_PATH = "../res"

def handle_generate_de_tech(aoe_data):
  de_tech.de_tech_json(aoe_data, PY_DATA_BINARY_PATH + "/DETech.json")

def handle_generate_de_xx_triggers(aoe_data):
  de_xx_triggers.de_xx_triggers_scenario(
    aoe_data,
    PY_DATA_SOURCE_PATH + "/dej-scenarios/dej-scenario-debugger-0-0-0.aoe2scenario",
    PY_DATA_BINARY_PATH + "/dej-scenario-debugger-0-0-0.aoe2scenario"
  )

def handle_generate_all(aoe_data):
  handle_generate_de_editor_tech(aoe_data)
  handle_generate_de_tech(aoe_data)
  handle_generate_de_xx_triggers(aoe_data)

def handle_generate_djs_debugger():
  djs_debugger.generate_scenario(
    PY_DATA_SOURCE_PATH + "/dej-scenarios/empty_scenario.aoe2scenario",
    PY_DATA_BINARY_PATH + "/dej-debugger-codegen.aoe2scenario"
  )

def handle_remove_all_triggers():
  djs_debugger.generate_scenario(
    PY_DATA_SOURCE_PATH + "/dej-scenarios/empty_scenario.aoe2scenario",
    PY_DATA_BINARY_PATH + "/dej-debugger-codegen.aoe2scenario"
  )

def main():
  parser = argparse.ArgumentParser(
    prog='aoea-utils',
    description='[Age Of Empires 2 : Definitive Edition Analyzer] Python Utils',
  )
  parser.add_argument('generate', type=str,
    help="""Type data generate. "ALL" to generate all files. Data:
  - de_editor_tech: DEEditorTech.json
  - de_tech: DETech.json
  - de_xx_triggers: dej-scenario-debugger-0-0-0.aoe2scenario
"""
  )
  args = parser.parse_args()

  if args.generate == "ALL":
    AOE_DATA = DatFile.parse(PY_AOE_DATFILE_PATH)
    handle_generate_all(AOE_DATA)

  elif args.generate == "de_tech":
    AOE_DATA = DatFile.parse(PY_AOE_DATFILE_PATH)
    handle_generate_de_tech(AOE_DATA)

  elif args.generate == "de_xx_triggers":
    AOE_DATA = DatFile.parse(PY_AOE_DATFILE_PATH)
    handle_generate_de_xx_triggers(AOE_DATA)
  elif args.generate == "djs_debugger":
    handle_generate_djs_debugger()
  elif args.generate == "remove_all_triggers":
    handle_remove_all_triggers()
  else:
    print("Invalid generate argument.")

if __name__ == '__main__':
    main()