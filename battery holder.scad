include <openscad-utilities/common.scad>
include <openscad-utilities/arrow.scad>

battery_d = 15;
countersink_d = 18;
margin = 1.5;

edge_margin = 2.5;

columns = 4;
rows = 2;

symbol_size = 10;
symbol_line_width = 2.5;
symbol_cut_depth = 1;
symbol_insert_d = symbol_size + 1.5;

base_x = columns * (countersink_d + margin) + margin + 2 * symbol_insert_d + 2 * edge_margin;
base_y = rows * countersink_d + (rows - 1) * margin + 2 * edge_margin;

height = 20;

assembly(true);

module assembly(explode = false) {
    color("#333333")
        holder();
    place_symbols() {
        union() {
            if (explode)
                rotate([-90, 0, 45])
                    arrow(8);
            translate([0, 0, explode ? -35 : 0])
                color("#FFCC33")
                    symbol_insert();
        }
    }
}

module holder() {
    difference() {
        rounded_cube([base_x, base_y, height], d = 25, top_d = 2, bottom_d = 2);
        for (j = [0 : rows - 1]) {
            translate([0, j * (countersink_d + margin)]) {
                for (i = [0 : columns - 1]) {
                    translate([(countersink_d/2 + edge_margin) + i * (countersink_d + margin) + symbol_size + edge_margin, countersink_d/2 + edge_margin, height]) {
                        countersink(battery_d, countersink_d, shaft_length = height - 1.5);
                    }
                }
            }
        }
        place_symbols() {
            plus_sign();
            minus_sign();
        }
        place_symbols()
            symbol_insert(true);
    }
}

module place_symbols() {
    for (i = [0 : rows - 1]) {
        translate([edge_margin + symbol_insert_d/2, edge_margin + countersink_d/2 + i * (margin + countersink_d)]) {
            if (i < $children)
                children(i);
            else
                children($children - 1);
        }
        translate([base_x - symbol_insert_d/2 - edge_margin,  edge_margin + countersink_d/2 + i * (margin + countersink_d)]) {
            if (i < $children)
                children(i);
            else
                children($children - 1);
        }
    }
}

module symbol_insert(is_cut = false) {
    h = height - symbol_cut_depth;
    d = symbol_insert_d - 0.15;
    cap_h = 2.8;
    if (is_cut) {
        fix_preview()
            cylinder(d = symbol_insert_d, h = h + 0.001);
    } else {
        cylinder(d = d, h = h - cap_h);
        translate([0, 0, h - cap_h])
            cylinder(d1 = d, d2 = d - 0.5, h = cap_h);
    }
}

module plus_sign() {
    minus_sign();
    rotate(90)
        minus_sign();
}

module minus_sign() {
    translate([0, 0, height - symbol_cut_depth/2 + 0.001])
        cube([symbol_size, symbol_line_width, symbol_cut_depth], center = true);
}
