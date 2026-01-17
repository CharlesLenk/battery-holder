include <openscad-utilities/common.scad>
use <battery holder.scad>

name = "";
battery_type = "AA";
columns = 6;

if (name == "holder")
    rotate([180, 0, 0]) holder(columns, battery_type);
else if (name == "symbol_insert")
    rotate([180, 0, 0]) symbol_insert(battery_type);
