include <openscad-utilities/common.scad>
include <openscad-utilities/arrow.scad>

battery_d = 15;
countersink_d = 18;
margin = 1.5;

edge_margin = 2.5;

default_columns = 6;
rows = 2;
height = 20;

symbol_size = 10;
symbol_line_width = 2.5;
symbol_cut_depth = 1;
symbol_insert_d = symbol_size + 1.5;
symbol_insert_cut_h = height - symbol_cut_depth;
symbol_insert_h = symbol_insert_cut_h - 0.4;

function get_holder_x(columns) = columns * (countersink_d + margin) + margin + 2 * symbol_insert_d + 2 * edge_margin;

assembly(explode = true);

module assembly(columns = default_columns, explode = false) {
    color("#333333")
        holder(columns);
    place_symbols(columns) {
        translate([0, 0, symbol_insert_cut_h - symbol_insert_h]) {
            if (explode)
                rotate([-90, 0, 45])
                    arrow(8);
            translate([0, 0, explode ? -35 : 0])
                color("#FFCC33")
                    symbol_insert();
        }
    }
}

module holder(columns) {
    holder_x = get_holder_x(columns);
    holder_y = rows * countersink_d + (rows - 1) * margin + 2 * edge_margin;
    difference() {
        rounded_cube([holder_x, holder_y, height], d = 25, top_d = 2, bottom_d = 2);
        for (j = [0 : rows - 1]) {
            translate([0, j * (countersink_d + margin)]) {
                for (i = [0 : columns - 1]) {
                    translate([(countersink_d/2 + edge_margin) + i * (countersink_d + margin) + symbol_size + edge_margin, countersink_d/2 + edge_margin, height]) {
                        countersink(battery_d, countersink_d, shaft_length = height - 1.5);
                    }
                }
            }
        }
        place_symbols(columns) {
            plus_sign();
            minus_sign();
        }
        place_symbols(columns)
            symbol_insert(true);
    }
}

module place_symbols(columns) {
    holder_x = get_holder_x(columns);
    for (i = [0 : rows - 1]) {
        translate([0, edge_margin + countersink_d/2 + i * (margin + countersink_d)]) {
            translate([edge_margin + symbol_insert_d/2, 0]) {
                if (i < rows/2 || $children == 1)
                    children(0);
                else
                    children(1);
            }
            translate([holder_x - symbol_insert_d/2 - edge_margin, 0]) {
                if (i < rows/2 || $children == 1)
                    children(0);
                else
                    children(1);
            }
        }
    }
}

module symbol_insert(is_cut = false) {
    if (is_cut) {
        fix_preview()
            cylinder(d = symbol_insert_d, h = symbol_insert_cut_h);
    } else {
        d = symbol_insert_d - 0.15;
        cap_h = 2.8;
        cylinder(d = d, h = symbol_insert_h - cap_h);
        translate([0, 0, symbol_insert_h - cap_h])
            cylinder(d1 = d, d2 = d - 0.5, h = cap_h);
    }
}

module plus_sign() {
    minus_sign();
    rotate(90)
        minus_sign();
}

module minus_sign() {
    translate([0, 0, height - symbol_cut_depth/2])
        cube([symbol_size, symbol_line_width, symbol_cut_depth], center = true);
}
