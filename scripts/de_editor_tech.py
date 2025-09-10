"""
de_editor_tech.py

Attempts to find a matching name from the visible tech list in the in-game data, to get the resource's id.

Note that this function wont be able to get all the tech ID's because they are spelled diffrent in the data file. 
For example, "Yeomen" in the editor, is called  "Yeoman" in the data. Elite Boyar is Elite Siege Tower. 
Indeed, almost half the techs are like this.

The rest has to be painfully manually checked in AGE Editor.

@func de_editor_tech_array : Generate a json repr.
@func de_editor_tech_json : Generate an xs array data for `DEEditorTechArr`.
  @arg data : DatFile
      DatFile class parsed from game data by python module genieutils.
  @arg tech_list_file : 
      Path to a text file containing an ordered list of visible techs in the editor.(name only)
  @arg output_file :
      Path to an output file.

List of still unknown tech indices from the visible list:
    - "302": { "id": -1,  "name": "Military Policy" }
    - "303": { "id": -1,  "name": "Military Town Center" }
    - "308": { "id": -1,  "name": "Naval Policy" }
    - "333": { "id": -1,  "name": "Reed Arrows" }
    - "24":  { "id": -1,  "name": "Battle Drills" }
    - "99":  { "id": -1,  "name": "Defensive Town Center" },
    - "100": { "id": -1,  "name": "Delian League" }
    - "113": { "id": -1,  "name": "Economic Policy" },
    - "114": { "id": -1,  "name": "Economic Town Center" }
    - "265": { "id": -1,  "name": "Iphicratean Tactics" }
    - "272": { "id": -1,  "name": "Karda" }
"""
import json
from genieutils.datfile import DatFile

def de_editor_tech_array(data, tech_list_file, output_file):
  with open(tech_list_file, "r", encoding="utf-8") as f:
    name_list = f.readlines()

  stripped_name_list = [name.strip().lower() for name in name_list]
  found_tech_ids = []
  for name in stripped_name_list:
    found = False
    for tech_idx, tech in enumerate(data.techs):
      if tech.name.strip().lower() == name:
        found_tech_ids.append(tech_idx)
        found = True
        break
      elif name in tech.name.strip().lower():
        found_tech_ids.append(tech_idx)
        found = True
        break
      else:
       continue
    if(found == False):
      found_tech_ids.append(-1)
  
  with open(output_file, "w", encoding="utf-8") as out:
    out.write("extern const int DEEditorTechArrSize = " +  str(len(name_list)) + ";\n")
    for idx, name in enumerate(name_list):
      out.write(f"  xsArraySetInt(DEEditorTechArr, {idx}, \"{found_tech_ids[idx]}\"); // {name.strip()}\n")    

def de_editor_tech_json(data, tech_list_file, output_file):
  with open(tech_list_file, "r", encoding="utf-8") as f:
    name_list = f.readlines()

  stripped_name_list = [name.strip().lower() for name in name_list]
  found_tech_ids = []
  for vis_tech_idx, name in enumerate(stripped_name_list):
    found = False
    for tech_idx, tech in enumerate(data.techs):
      if tech.name.strip().lower() == name:
        found_tech_ids.append((name_list[vis_tech_idx].strip(), tech_idx))
        found = True
        break
      elif name in tech.name.strip().lower():
        found_tech_ids.append((name_list[vis_tech_idx].strip(), tech_idx))
        found = True
        break
      else:
       continue
    if(found == False):
      found_tech_ids.append((name_list[vis_tech_idx].strip(), -1))

  # Convert to dict for json
  out_dict = {"DEEditorTech":{}}
  for idx,tech in enumerate(found_tech_ids):
    out_dict["DEEditorTech"][idx] = {"id" : tech[1],"name" : tech[0]}

  with open(output_file, "w", encoding="utf-8") as out:
    out.write(json.dumps(out_dict, indent=2,ensure_ascii=True))
