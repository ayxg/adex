// aoe2de-analyzer.cpp : Defines the entry point for the application.
#include "aoe2de-analyzer.hpp"

#include <format>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

#include "nlohmann/json.hpp"

namespace aoea {
namespace json = nlohmann;

namespace strs {
using cstr = const char*;

// arg0 : file name
// arg1 : brief (do NOT add "///"  at new lines)
static constexpr cstr kFmtXsFileHeader =
    R"(///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Copyright 2025 Anton Yashchenko
// Licensed under the MIT License.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// @project: Anton's AOE2 DE XS Script Extensions
// @author(s): Anton Yashchenko (Steam Name: Dave East Jones)
// @website: https://www.acpp.dev
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// @file {}
/// @brief {}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
)";

/// arg0 : creation date in YYYY/MM/DD format
static constexpr cstr kFmtXsFileFooter =
    R"(///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// @project: Anton's AOE2 DE XS Script Extensions
// @author(s): Anton Yashchenko
// @website: https://www.acpp.dev
// @created: {}
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
)";

// arg0 : mods
// arg1 : type
// arg2 : name
// arg3 : init
static constexpr cstr kFmtXsVarDef = "{} {} {} = {};\n";

// arg0 : mods
// arg1 : type
// arg2 : name
// arg3 : init
// arg4 : comment
static constexpr cstr kFmtXsVarDefWithComment = "{} {} {} = {}; // {}\n";

// arg0 : rt
// arg1 : name
// arg2 : args
// arg3 : def
static constexpr cstr kFmtXsFnDef = "{} {}({}) {{\n{}\n}};\n";

}  // namespace strs

/// Helper to make sure no throw occurs if a key is not available
template <class T, class EnableT = std::enable_if<std::is_default_constructible_v<T>>>
static T JsonTryGet(const json::json& j, const T& defval = T{}) {
  try {
    return j.get<T>();
  } catch (const json::json::exception& e) {
    std::cerr << "Failed to get json data point for [" << j.dump() << "]:" << e.what() << "\nSetting to default."
              << std::endl;
    return defval;
  }
}

template <class T, class EnableT = std::enable_if<std::is_default_constructible_v<T>>>
static T JsonTryGet(const json::json& j, const std::string& key, const T& defval = T{}) {
  if (j.contains(key)) return JsonTryGet<T>(j.at(key), defval);
  return defval;
}

static bool LoadFileToJson(json::json& to, const std::string& file_path) {
  std::ifstream fs{};
  fs.open(file_path);
  if (!fs.is_open()) {
    std::cerr << "Failed to open file: " << file_path << std::endl;
    return false;
  }

  try {
    to = to.parse(fs);
  } catch (const aoea::json::json::parse_error& e) {
    std::cerr << "Json parsing failure: " << e.what() << "\n" << file_path << std::endl;
    return false;
  }
  fs.close();
  return true;
}
static bool LoadFileToOrderedJson(json::ordered_json& to, const std::string& file_path) {
  std::ifstream fs{};
  fs.open(file_path);
  if (!fs.is_open()) {
    std::cerr << "Failed to open file: " << file_path << std::endl;
    return false;
  }

  try {
    to = to.parse(fs);
  } catch (const aoea::json::json::parse_error& e) {
    std::cerr << "Json parsing failure: " << e.what() << "\n" << file_path << std::endl;
    return false;
  }
  fs.close();
  return true;
}

/// Default id when no id is set or not found in json data.
static constexpr inline int kNoId = INT_MIN;

///////////////////////////////////////////////////////////////////////////////
/* Halfon Website Json Data Format */
///////////////////////////////////////////////////////////////////////////////
struct HalfonUnitData {
  int id{kNoId};
  int id_base{kNoId};
  int id_type{kNoId};
  int id_class{kNoId};

  int id_help_converter{kNoId};
  int id_language_file_name{kNoId};
  int id_language_file_help{kNoId};

  std::string name{""};
  std::string name_localized{""};
  std::string name_rms_const{""};

  int cost_wood{kNoId};
  int cost_food{kNoId};
  int cost_gold{kNoId};
  int cost_stone{kNoId};

  int qty_attack{kNoId};
  int qty_melee_armor{kNoId};
  int qty_pierce_armor{kNoId};
  int qty_hit_points{kNoId};
  int qty_line_of_sight{kNoId};
  int qty_garrison_capacity{kNoId};

  // Custom data
  std::string expansion_tag{""};  // Current Versions : "de"| "ror" | "wk"
};

struct HalfonTechData {
  int id{kNoId};
  int id_help_converter{kNoId};
  int id_language_file_name{kNoId};
  int id_language_file_help{kNoId};

  std::string name{""};
  std::string localised_name{""};

  int cost_wood{kNoId};
  int cost_food{kNoId};
  int cost_gold{kNoId};
  int cost_stone{kNoId};

  std::string expansion_tag{""};  // Current Versions : "de"| "ror" | "wk"
};

struct HalfonData {
  bool valid{true};  // will be set to false by the parser if an error occured
  std::vector<HalfonUnitData> units;
  std::vector<HalfonTechData> techs;
};

/// Parse units and buildings json data in "halfon-master" repo format.
/// Argument must be the root json object.
static bool ParseHalfonUnitData(std::vector<HalfonUnitData>& data_arr, const json::json& json_lists) {
  auto& units_list = json_lists.at("units_buildings");
  HalfonUnitData nxt{};
  for (auto& u : units_list.items()) {
    try {
      // IDs
      nxt.id = std::stoi(u.key());
      nxt.id_base = u.value().at("base_id").get<int>();
      nxt.id_type = u.value().at("type").get<int>();
      nxt.id_class = u.value().at("class").get<int>();
      // String IDs
      nxt.id_help_converter = u.value().at("help_converter").get<int>();
      nxt.id_language_file_name = u.value().at("language_file_name").get<int>();
      nxt.id_language_file_help = u.value().at("language_file_help").get<int>();

      // Strings
      nxt.name = u.value().at("name").get<std::string>();
      nxt.name_localized =
          u.value().at("localised_name").is_null() ? "" : u.value().at("localised_name").get<std::string>();
      if (u.value().contains("rms_const"))
        nxt.name_rms_const = u.value().at("rms_const").is_null() ? "" : u.value().at("rms_const").get<std::string>();
      // Res Cost
      if (u.value().contains("cost")) {
        nxt.cost_wood = JsonTryGet<int>(u.value().at("cost"), "wood");
        nxt.cost_food = JsonTryGet<int>(u.value().at("cost"), "food");
        nxt.cost_gold = JsonTryGet<int>(u.value().at("cost"), "gold");
        nxt.cost_stone = JsonTryGet<int>(u.value().at("cost"), "stone");
      } else {
        nxt.cost_wood = 0;
        nxt.cost_food = 0;
        nxt.cost_gold = 0;
        nxt.cost_stone = 0;
      }
      // Stats
      nxt.qty_attack = u.value().at("attack").get<int>();
      nxt.qty_melee_armor = u.value().at("melee_armor").get<int>();
      nxt.qty_pierce_armor = u.value().at("pierce_armor").get<int>();
      nxt.qty_hit_points = u.value().at("hit_points").get<int>();
      nxt.qty_line_of_sight = u.value().at("line_of_sight").get<int>();
      nxt.qty_garrison_capacity = u.value().at("garrison_capacity").get<int>();
    } catch (const json::json::exception& e) {
      std::cerr << "Failed to get json data point for [" << u.value().dump() << "]:" << e.what()
                << "\nSetting to default." << std::endl;
      return false;
    }
    data_arr.push_back(nxt);
  }
  return true;
}

/// Parse techs json data in "halfon-master" repo format.
/// Argument must be the root json object.
static bool ParseHalfonTechData(std::vector<HalfonTechData>& data_arr, const json::json& json_lists) {
  if (!json_lists.contains("techs")) {
    std::cerr << "No techs list found in provided json data." << std::endl;
    return false;
  }
  auto& techs_list = json_lists.at("techs");
  if (!techs_list.is_object()) {
    std::cerr << "Techs list is not an object." << std::endl;
    return false;
  }

  if (techs_list.empty()) {
    std::cerr << "Techs list is empty." << std::endl;
    return false;
  }

  if (techs_list.size() < 1) {
    std::cerr << "Techs list has less than 1 item." << std::endl;
    return false;
  }

  HalfonTechData nxt{};
  for (auto& t : techs_list.items()) {
    try {
      nxt.id = std::stoi(t.key());  // Get the tech ID from the key
      nxt.id_help_converter = t.value().at("help_converter").get<int>();
      nxt.id_language_file_name = t.value().at("language_file_name").get<int>();
      nxt.id_language_file_help = t.value().at("language_file_help").get<int>();
      nxt.name = t.value().at("name").get<std::string>();
      nxt.localised_name = t.value().at("localised_name").get<std::string>();
      if (t.value().contains("cost")) {
        nxt.cost_wood = JsonTryGet<int>(t.value().at("cost"), "wood");
        nxt.cost_food = JsonTryGet<int>(t.value().at("cost"), "food");
        nxt.cost_gold = JsonTryGet<int>(t.value().at("cost"), "gold");
        nxt.cost_stone = JsonTryGet<int>(t.value().at("cost"), "stone");
      } else {
        nxt.cost_wood = 0;
        nxt.cost_food = 0;
        nxt.cost_gold = 0;
        nxt.cost_stone = 0;
      }
    } catch (const json::json::exception& e) {
      std::cerr << "Failed to get json data point for [" << t.value().dump() << "]:" << e.what()
                << "\nSetting to default." << std::endl;
      return false;
    }
    data_arr.push_back(nxt);
  }
  return true;
}

/// @method GetHalfonAoeData
///
/// Pass a list of {file-path,expansion-tag} pairs per halfon expansion data file. The first
/// file will be considered the base game. In case of DE, you should pass the '_de.json' tagged file first.
/// The last expansion data will override any previous expansion data if the unit/tech id is the same.
/// Expansion-only units are appended to the total list. Check the expansion tag by accessing:
///  `HalfonData.units[i].expansion_tag`
///
/// All duplicate IDs from the same expansion are ignored, first occurence is kept only.
/// All duplicate IDs are overridden with the data of the latest expansion.
///    !! BUT their tag will remain the first occurring expansion.
HalfonData GetHalfonAoeData(std::vector<std::pair<std::string, std::string>> filepath_versionid_pairs) {
  assert(!filepath_versionid_pairs.empty() && "Must provide at least one file path.");
  assert(std::find_if(filepath_versionid_pairs.begin(), filepath_versionid_pairs.end(),
                      [](const auto& pair) { return pair.first.empty(); }) == filepath_versionid_pairs.end() &&
         "File path must not be empty.");
  assert(std::find_if(filepath_versionid_pairs.begin(), filepath_versionid_pairs.end(),
                      [](const auto& pair) { return pair.second.empty(); }) == filepath_versionid_pairs.end() &&
         "Expansion tag must not be empty.");

  HalfonData data{};
  std::vector<json::json> json_objs{};
  std::vector<std::vector<HalfonUnitData>> unpacked_units{};
  std::vector<std::vector<HalfonTechData>> unpacked_techs{};

  for (const auto& [file_path, exp_tag] : filepath_versionid_pairs) {
    // load file to json dom view
    json_objs.push_back(json::json{});
    if (!LoadFileToJson(json_objs.back(), file_path)) {
      data.valid = false;
      return data;  // Cant load json file...
    }

    // parse unit json data
    unpacked_units.push_back(std::vector<HalfonUnitData>{});
    if (!ParseHalfonUnitData(unpacked_units.back(), json_objs.back())) {
      data.valid = false;
      return data;  // Bad json data
    }

    // par tech json data
    unpacked_techs.push_back(std::vector<HalfonTechData>{});
    if (!ParseHalfonTechData(unpacked_techs.back(), json_objs.back())) {
      data.valid = false;
      return data;  // Bad json data
    }

    // set expansion tag
    for (auto& u : unpacked_units.back()) u.expansion_tag = exp_tag;
    for (auto& t : unpacked_techs.back()) t.expansion_tag = exp_tag;
  }

  // Compile the packed unit list.
  // Handle first expansion data (base game).
  assert(unpacked_units.size() > 0 && "Must have at least one unpacked data set.");
  for (const auto& u : unpacked_units.front()) {
    if (std::find_if(data.units.begin(), data.units.end(),
                     [&u](const aoea::HalfonUnitData& existing) { return existing.id == u.id; }) != data.units.end()) {
      std::cerr << "Duplicate unit ID found: " << u.id << " in DE units list." << std::endl;
      continue;
    }
    data.units.push_back(u);
  }
  unpacked_units.front().clear();

  // Handle additional expansion data
  if (unpacked_units.size() > 1) {
    for (auto arr_it = std::next(unpacked_units.begin()); arr_it != unpacked_units.end(); arr_it++) {
      for (const auto& exu : *arr_it) {
        auto existing = std::find_if(data.units.begin(), data.units.end(),
                                     [&exu](const aoea::HalfonUnitData& existing) { return existing.id == exu.id; });
        if (existing != data.units.end()) {
          std::string first_expansion = existing->expansion_tag;
          *existing = exu;
          existing->expansion_tag = first_expansion;
        } else {
          data.units.push_back(exu);
        }
      }
      arr_it->clear();
    }
  }
  unpacked_units.clear();  // dont need unpacked data

  // Reorder by id min to max.
  std::sort(data.units.begin(), data.units.end(),
            [](const aoea::HalfonUnitData& a, const aoea::HalfonUnitData& b) { return a.id < b.id; });

  // Compile the packed tech list
  assert(unpacked_techs.size() > 0 && "Must have at least one unpacked tech data set.");
  for (const auto& t : unpacked_techs.front()) {
    if (std::find_if(data.techs.begin(), data.techs.end(),
                     [&t](const aoea::HalfonTechData& existing) { return existing.id == t.id; }) != data.techs.end()) {
      std::cerr << "Duplicate tech ID found: " << t.id << " in DE techs list." << std::endl;
      continue;
    }
    data.techs.push_back(t);
  }
  unpacked_techs.front().clear();
  if (unpacked_techs.size() > 1) {
    for (auto arr_it = std::next(unpacked_techs.begin()); arr_it != unpacked_techs.end(); arr_it++) {
      for (const auto& exu : *arr_it) {
        auto existing = std::find_if(data.techs.begin(), data.techs.end(),
                                     [&exu](const aoea::HalfonTechData& existing) { return existing.id == exu.id; });
        if (existing != data.techs.end()) {
          std::string first_expansion = existing->expansion_tag;
          *existing = exu;
          existing->expansion_tag = first_expansion;
        } else {
          data.techs.push_back(exu);
        }
      }
      arr_it->clear();
    }
  }
  unpacked_techs.clear();

  std::sort(data.techs.begin(), data.techs.end(),
            [](const aoea::HalfonTechData& a, const aoea::HalfonTechData& b) { return a.id < b.id; });

  return data;
}

///////////////////////////////////////////////////////////////////////////////
/* XS Types */
///////////////////////////////////////////////////////////////////////////////
enum eXsType { kInt, kBool, kFloat, kString, kVector };

struct XsVec3 {
  float x{0.f};
  float y{0.f};
  float z{0.f};
  XsVec3() = default;
  XsVec3(float x, float y, float z) : x(x), y(y), z(z) {}
  XsVec3(const XsVec3& other) = default;
  XsVec3& operator=(const XsVec3& other) = default;
};

using xs_int = std::int32_t;
using xs_bool = bool;
using xs_float = float;
using xs_string = const char*;
using xs_vector = XsVec3;

/// Stores minimum base data to identify a technology.
/// The 'idx' field is the index into the owning array of this pointer.
struct AOETechnologyPtr {
  int idx{kNoId};
  int id{kNoId};
  std::string name{""};
};

struct AOEObject {
  int id{kNoId};
  int id_base{kNoId};
  int id_type{kNoId};
  int id_class{kNoId};

  int id_help_converter{kNoId};
  int id_language_file_name{kNoId};
  int id_language_file_help{kNoId};

  int cost_wood{kNoId};
  int cost_food{kNoId};
  int cost_gold{kNoId};
  int cost_stone{kNoId};

  int qty_attack{kNoId};
  int qty_melee_armor{kNoId};
  int qty_pierce_armor{kNoId};
  int qty_hit_points{kNoId};
  int qty_line_of_sight{kNoId};
  int qty_garrison_capacity{kNoId};

  std::string name{""};
  std::string name_localized{""};
  std::string name_rms_const{""};

  // Custom data
  std::string expansion_tag{""};  // Current Versions : "de"| "ror" | "wk"
};
struct AOEObjectAttribute;
struct AOEResource {
  int idx{-1};
  int id{kNoId};
  std::string name{""};
  float init_value{0.f};
};
struct AOETask;
struct AOETechnology : public AOETechnologyPtr {
  int id_help_converter{kNoId};
  int id_language_file_name{kNoId};
  int id_language_file_help{kNoId};

  float cost_wood{kNoId};
  float cost_food{kNoId};
  float cost_gold{kNoId};
  float cost_stone{kNoId};

  std::string localized_name{""};
  std::string expansion_tag{""};  // Current Versions : "de"| "ror" | "wk"
};

struct AOECivilization;

// std::vector<AOEResource> ParseDeResourceData(const json::json& js) {
//   if (!js.contains("resources")) {
//     std::cerr << "Invalid json format." << std::endl;
//     return std::vector<AOEResource>{};
//   }
//   auto& res_list = js.at("resources");
//
//   for (auto& res : res_list.items()) {
//     AOEResource new_res{};
//     try {
//       new_res.idx = std::stoi(res.key());
//       new_res.name = res.value().at("name").get<std::string>();
//       new_res.id = res.value().at("id").get<int>();
//       new_res.init_value = res.value().at("value").get<float>();
//     } catch (const json::json::exception& e) {
//       std::cerr << "Failed to get json data point for [" << res.value().dump() << "]:" << e.what()
//                 << "\nSetting to default." << std::endl;
//       return false;
//     }
//   }
// }

// std::vector<AOETechnology> ParseDeTechData() {
//
// }
//

std::unique_ptr<std::vector<AOETechnologyPtr>> ParseDeEditorTechData(const std::string& fp) {
  assert(!fp.empty() && "File path must not be empty.");
  json::ordered_json js{};

  if (!LoadFileToOrderedJson(js, fp)) {
    std::cerr << "Failed to load json file." << std::endl;
    return nullptr;  // Cant load json file...
  }

  if (!js.contains("de-editor-tech")) {
    std::cerr << "Invalid json format." << std::endl;
    return nullptr;
  }

  auto& techs_list = js.at("de-editor-tech");
  auto rt = std::make_unique<std::vector<AOETechnologyPtr>>();
  for (auto& tech : techs_list.items()) {
    AOETechnologyPtr new_tech{};
    try {
      new_tech.idx = std::stoi(tech.key());
      new_tech.name = tech.value().at("name").get<std::string>();
      new_tech.id = tech.value().at("id").get<int>();
      rt->push_back(new_tech);
    } catch (const json::json::exception& e) {
      std::cerr << "Failed to get json data point for [" << tech.value().dump() << "]:" << e.what()
                << "\nSetting to default." << std::endl;
      return nullptr;
    }
  }

  if (rt->empty()) {
    std::cerr << "No data found in the provided json file." << std::endl;
    return nullptr;
  }

  int last_idx = 0;
  for (auto it = rt->begin(); it != rt->end(); it++) {
    if (it->id == kNoId || it->id == -1)
      std::cout << "[Warning] Missing technology id: " << it->id << " | " << it->name << std::endl;

    if (it->name == "") std::cout << "[Warning] Missing technology name: " << it->id << " | " << it->name << std::endl;

    if (it->idx != last_idx)
      std::cout << "[Warning] Non-uniform index: " << it->idx << " | " << it->name << "[Should be:" << last_idx << "]"
                << std::endl;
    last_idx++;
  }

  return rt;
}

template <class T,
          class ET = std::enable_if_t<std::disjunction_v<std::is_same<T, xs_int>, std::is_same<T, xs_bool>,
                                                         std::is_same<T, xs_float>, std::is_same<T, xs_string>>>>
std::string GenerateXsArray(const std::string& name, T&& default_val, const std::vector<T>& data = {},
                            const std::vector<std::string>& data_comment = {}) {
  using std::format;
  assert(data_comment.empty() ||
         data_comment.size() == data.size() && "Data comments must either be empty or matching the data size");
  int size = data.size();
  std::string rt{};
  rt += format(strs::kFmtXsFileHeader, name + ".xs", "Generated XS Array for `" + name + "`.");
  rt += "\n";
  rt += format(strs::kFmtXsVarDef, "extern", "int", name, size);
  rt += format(strs::kFmtXsVarDef, "extern", "string", name + "Name", "\"" + name + "\"");
  rt += format(strs::kFmtXsVarDef, "extern", "int", name + "Size", size);
  rt += format(strs::kFmtXsVarDef, "extern", "int", name, "Back", size - 1);

  auto xGenArrayFnDef = [&name, &default_val, &data, &data_comment]() {
    std::string fndef{};
    // generate xs data function calls based on passed vector type.
    if constexpr (std::is_same_v<T, xs_int>) {  // xsArrayCreateInt
      fndef += format("  {} = xsArrayCreateInt({}, {}, {});\n", name, name + "Size", default_val, name + "Name");
      for (auto idx = 0; idx < data.size(); idx++) {
        fndef += format("  xsArraySetInt({}, {}, {});", name, idx, data[idx]);
        if (!data_comment.empty())
          if (!data_comment[idx].empty())
            fndef += format(" // {}\n", data_comment[idx]);
          else
            fndef += "\n";
      }
    }
    // xsArrayCreateBool
    else if constexpr (std::is_same_v<T, xs_bool>) {
      fndef += format("  {} = xsArrayCreateBool({}, {}, {});\n", name, name + "Size", default_val, name + "Name");
      for (auto idx = 0; idx < data.size(); idx++) {
        fndef += format("  xsArraySetBool({}, {}, {});", name, idx, data[idx]);
        if (!data_comment.empty())
          if (!data_comment[idx].empty())
            fndef += format(" // {}\n", data_comment[idx]);
          else
            fndef += "\n";
      }
    }
    // xsArrayCreateFloat
    else if constexpr (std::is_same_v<T, xs_float>) {
      fndef += format("  {} = xsArrayCreateFloat({}, {}, {});\n", name, name + "Size", default_val, name + "Name");
      for (auto idx = 0; idx < data.size(); idx++) {
        fndef += format("  xsArraySetFloat({}, {}, {});", name, idx, data[idx]);
        if (!data_comment.empty())
          if (!data_comment[idx].empty())
            fndef += format(" // {}\n", data_comment[idx]);
          else
            fndef += "\n";
      }
    }
    // xsArrayCreateString
    else if constexpr (std::is_same_v<T, xs_string>) {
      fndef += format("  {} = xsArrayCreateString({}, {}, {});\n", name, name + "Size", default_val, name + "Name");
      for (auto idx = 0; idx < data.size(); idx++) {
        fndef += format("  xsArraySetString({}, {}, {});", name, idx, data[idx]);
        if (!data_comment.empty())
          if (!data_comment[idx].empty())
            fndef += format(" // {}\n", data_comment[idx]);
          else
            fndef += "\n";
      }
    }
    // xsArrayCreateVector
    else if constexpr (std::is_same_v<T, xs_vector>) {
      fndef += format("  {} = xsArrayCreateVector({}, {}, xsVectorSet({},{},{}));\n", name, name + "Size",
                      name + "Name", default_val.x, default_val.y, default_val.z);
      for (auto idx = 0; idx < data.size(); idx++) {
        fndef += format("  xsArraySetVector({}, {}, xsVectorSet({}, {}, {}));", name, idx, data[idx].x, data[idx].y,
                        data[idx].z);
        if (!data_comment.empty())
          if (!data_comment[idx].empty())
            fndef += format(" // {}\n", data_comment[idx]);
          else
            fndef += "\n";
      }
    }
    // Unsupported type
    else
      throw "Unsupported type for xs array generation.";
    fndef += std::format("  return ({});", name);
    return fndef;
  };
  rt += std::format(strs::kFmtXsFnDef, "int", name + "Init", "", xGenArrayFnDef());
  rt += "\n";
  rt += format(strs::kFmtXsFileFooter, "2025/08/11"); 
  return rt;
}

}  // namespace aoea

int HalfonDataExample() {
  using namespace aoea;
  HalfonData halfon_data{GetHalfonAoeData({
      {"res/id_lists_de.json", "de"},    // [Definitive Edition]
      {"res/id_lists_ror.json", "ror"},  // [Return to Rome]
      {"res/id_lists_wk.json", "wk"}     // [Kingdoms]
  })};

  if (!halfon_data.valid) return EXIT_FAILURE;

  int min_id = std::min_element(halfon_data.units.begin(), halfon_data.units.end(),
                                [](const HalfonUnitData& a, const HalfonUnitData& b) { return a.id < b.id; })
                   ->id;

  int max_id = std::max_element(halfon_data.units.begin(), halfon_data.units.end(),
                                [](const HalfonUnitData& a, const HalfonUnitData& b) { return a.id < b.id; })
                   ->id;

  std::cout << "Total unique units found: " << halfon_data.units.size() << std::endl;
  std::cout << "Minimum unit ID: " << min_id << std::endl;
  std::cout << "Maximum unit ID: " << max_id << std::endl;

  // for (const auto& u : halfon_data.units) {
  //   if (u.name_localized.empty())
  //     std::cout << "Unit ID: " << u.id << ", Ident:" << u.name << " Name: "
  //               << "[[NO - NAME]] " << std::endl;
  //   else
  //     std::cout << "Unit ID: " << u.id << ",Ident:" << u.name << " Name: " << u.name_localized << std::endl;
  // }

  // for (const auto& t : halfon_data.techs) {
  //   if (t.localised_name.empty())
  //     std::cout << "Tech ID: " << t.id << ", Ident:" << t.name << " Name: "
  //               << "[[NO - NAME]] " << std::endl;
  //   else
  //     std::cout << "Tech ID: " << t.id << ", Ident:" << t.name << " Name: " << t.localised_name << std::endl;
  // }

  std::ofstream ofl("res/deObjects.xs");
  if (!ofl.is_open()) {
    std::cerr << "Failed to open output file for writing." << std::endl;
    return EXIT_FAILURE;
  }

  // Add XS function which initializes "deObjects" array.  Ignore the first unit ID (-1).
  // Related XS vars: QARRID_deObjects , cQARRNAME_deObjects , cQARRSIZE_deObjects , qqConstructArray_deObjects

  ofl << "extern const int cQARRSIZE_deObjects = " << halfon_data.units.size() - 1 << ";\n";
  ofl << "int qqConstructArray_deObjects() {\n";
  ofl << "    QARRID_deObjects = xsArrayCreateInt(cQARRSIZE_deObjects, 0, cQARRNAME_deObjects);\n";
  int current_idx = 0;
  for (auto uit = std::next(halfon_data.units.begin()); uit != halfon_data.units.end(); ++uit) {
    auto& u = *uit;
    ofl << "    xsArraySetInt(QARRID_deObjects, " << current_idx << ", " << u.id << ");";
    if (u.name_localized.empty()) {
      ofl << " // " << u.name << " | [[NO-NAME]]\n";
    } else {
      ofl << " // " << u.name << " | " << u.name_localized << "\n";
    }
    current_idx++;
  }
  ofl << "    return (QARRID_deObjects);\n};\n";
  ofl.close();

  // Add XS function which initializes "deTechs" array.
  // Related XS vars: QARRID_deTechs , cQARRNAME_deTechs , cQARRSIZE_deTechs , qqConstructArray_deTechs
  ofl.open("res/deTechs.xs");
  if (!ofl.is_open()) {
    std::cerr << "Failed to open output file for writing." << std::endl;
    return EXIT_FAILURE;
  }
  ofl << "extern const int cQARRSIZE_deTechs = " << halfon_data.techs.size() << ";\n";
  ofl << "int qqConstructArray_deTechs() {\n";
  ofl << "    QARRID_deTechs = xsArrayCreateInt(cQARRSIZE_deTechs, 0, cQARRNAME_deTechs);\n";
  current_idx = 0;
  for (const auto& t : halfon_data.techs) {
    ofl << "    xsArraySetInt(QARRID_deTechs, " << current_idx << ", " << t.id << ");";
    if (t.localised_name.empty()) {
      ofl << " // " << t.name << "| [[NO-NAME]]\n";
    } else {
      ofl << " // " << t.name << "| " << t.localised_name << "\n";
    }
    current_idx++;
  }
  ofl << "    return (QARRID_deTechs);\n};\n";
  ofl.close();

  return EXIT_SUCCESS;
}

int main() {
  // de-editor-tech.json -> DEEditorTech.xs
  auto de_editor_tech = aoea::ParseDeEditorTechData("res/de-editor-tech.json");
  if (!de_editor_tech) {
    std::cerr << "Failed to parse DE editor tech data." << std::endl;
    return EXIT_FAILURE;
  }

  std::ofstream ofs("../xs-codegen/DEEditorTech.xs");
  if (!ofs.is_open()) {
    std::cerr << "Failed to open output file for writing." << std::endl;
    return EXIT_FAILURE;
  }

  std::vector<aoea::xs_int> de_editor_tech_ids{};
  de_editor_tech_ids.reserve(de_editor_tech->size());
  for (const auto& tech : *de_editor_tech) de_editor_tech_ids.push_back(tech.id);

  std::vector<std::string> de_editor_tech_names{};
  de_editor_tech_names.reserve(de_editor_tech->size());
  for (const auto& tech : *de_editor_tech)
    if (tech.name.empty())
      de_editor_tech_names.push_back("[NO-NAME]");
    else
      de_editor_tech_names.push_back(tech.name);

  ofs << aoea::GenerateXsArray("DEEditorTech", 0, de_editor_tech_ids, de_editor_tech_names);
  ofs.close();

  return EXIT_SUCCESS;
}
