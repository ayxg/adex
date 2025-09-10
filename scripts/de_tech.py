import json
from genieutils.datfile import DatFile

def de_tech_json(data, output_file):
  out_dict = {"DETechData":{}}
  for tech_idx, tech in enumerate(data.techs):
    out_dict["DETechData"][tech_idx] = {
      "name": tech.name,
      "type": tech.type,
      "effect_id": tech.effect_id,
      "resource_cost1": tech.resource_costs[0].amount,
      "resource_cost2": tech.resource_costs[1].amount,
      "resource_cost3": tech.resource_costs[2].amount,
      "resource_id1": tech.resource_costs[0].type,
      "resource_id2": tech.resource_costs[1].type,
      "resource_id3": tech.resource_costs[2].type,
      "research_location": tech.research_location,
      "button_id": tech.button_id,
      "research_time": tech.research_time,
      "icon_id": tech.icon_id,
      "hotkey": tech.hot_key,
      "repeatable": tech.repeatable
    }

  with open(output_file, "w", encoding="utf-8") as out:
    out.write(json.dumps(out_dict, indent=2,ensure_ascii=True))
