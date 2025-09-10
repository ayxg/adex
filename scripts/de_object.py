from genieutils.datfile import DatFile

def de_object_find_all(data):
  all_objs = []
  for civ in data.civs:
    if civ is None:
      continue          
    for unit in civ.units:
      if unit is None:
        continue
      if unit.id not in all_objs:
          all_objs[unit.id] = unit
  return all_objs
