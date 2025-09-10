#include <string>
#include <vector>
#include <array>

#include "map"

enum eXsType { kInt, kBool, kFloat, kString, kVector };
using xs_pointer = int;
using xs_slot = int;
static constexpr  int xs_types_begin = 0;
static constexpr int xs_types_size = 5;
static constexpr xs_pointer xs_nullptr = -1;

int xsCreateArray(int size, int fill, const std::string& name);

struct Slot {
  std::int16_t id : 16;       // 65536 slots max
  std::int16_t type : 8;      // 256 types max
  std::int16_t state : 4;     // 16 states max
  std::int16_t reserved : 4;  // 16 reserved bits
};

struct Registry {
  std::vector<Slot> slots;
  std::array<std::vector<xs_pointer>, xs_types_size> live_arrays;
  std::array<std::vector<xs_pointer>, xs_types_size> dead_arrays;
  std::map<std::string, int> named_arrays;

  xs_slot create_array(eXsType type = eXsType::kInt, int size = 0, int fill = 0, const std::string& name = "") {
    xs_pointer arrid = xs_nullptr;
    if (type == eXsType::kInt) {
      if (!dead_arrays[eXsType::kInt].empty()) {  // use an existing nullified array
        arrid = dead_arrays[eXsType::kInt].back();
        dead_arrays[eXsType::kInt].pop_back();
        live_arrays[eXsType::kInt].push_back(arrid);
        slots.push_back(Slot{arrid, type});
        if (!name.empty() && named_arrays.count(name) == 0) named_arrays[name] = slots.size() - 1;
        return slots.size() - 1;
      } else {  // create a new array
        live_arrays[eXsType::kInt].push_back(xsCreateArray(size,fill,name));  
        arrid = live_arrays[eXsType::kInt].size() - 1;
        slots.push_back(Slot{arrid, type});
        if (!name.empty() && named_arrays.count(name) == 0) named_arrays[name] = slots.size() - 1;
        return slots.size() - 1;
      }
    }
  }
};

int test_xs_registry() {
  Registry registry{};
  xs_slot int_arr = registry.create_array(eXsType::kInt, 10, 0, "my_int_array");
  bool is_deleted = registry.delete_array(int_arr);
  xs_slot int_arr2 = registry.create_array(eXsType::kInt, 10, 0, "my_int_array");
  if(int_arr.id != int_arr2.id)
    ;  // Should be true if the array was reused
}