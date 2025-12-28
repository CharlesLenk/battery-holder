include <openscad-utilities/common.scad>
use <battery holder.scad>

name = "";

if (name == "holder")
    rotate([180, 0, 0]) holder();
else if (name == "symbol_insert")
    rotate([180, 0, 0]) symbol_insert();
