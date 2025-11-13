include <openscad-utilities/common.scad>

battery_d = 15;
top_d = 18;

edge_margin = 2.5;
margin = 1.5;

columns = 4;
rows = 2;

symbol_size = 10;
symbol_line_width = 2.5;
symbol_cut_depth = 1;

base_x = columns * (top_d + margin) + margin + 2 * symbol_size + 2 * edge_margin;
base_y = rows * top_d + (rows - 1) * margin + 2 * edge_margin;

height = 20;

symbol_insert_d = symbol_size + 1;





symbol_insert();
// intersection() {
     base();
//     cube([20, 20, 30]);
// }


module base() {
    difference() {
        rounded_cube([base_x, base_y, height], d = 25, top_d = 2, bottom_d = 2);
        for (j = [0 : rows - 1]) {
            translate([0, j * (top_d + margin)]) {
                for (i = [0 : columns - 1]) {
                    translate([(top_d/2 + margin) + i * (top_d + margin) + symbol_size + edge_margin, top_d/2 + edge_margin, height]) {
                        countersink(battery_d, top_d, shaft_length = height - 1.5);
                    }
                }
            }
        }

        translate([edge_margin + symbol_size/2, edge_margin + top_d/2]) {
            fix_preview()
                cylinder(d = symbol_insert_d, h = height - symbol_cut_depth);
            translate([0, 0, height])
                plus_sign();
        }
        translate([edge_margin + symbol_size/2,  edge_margin + margin + 1.5 * top_d]) {
            fix_preview()
                cylinder(d = symbol_insert_d, h = height - symbol_cut_depth);
            translate([0, 0, height])
                minus_sign();
        }
        translate([base_x - symbol_size/2 - edge_margin, edge_margin + top_d/2]) {
            fix_preview()
                cylinder(d = symbol_insert_d, h = height - symbol_cut_depth);
            translate([0, 0, height])
                plus_sign();
        }
        translate([base_x - symbol_size/2 - edge_margin,  edge_margin + margin + 1.5 * top_d]) {
            fix_preview()
                cylinder(d = symbol_insert_d, h = height - symbol_cut_depth);
            translate([0, 0, height])
                minus_sign();
        }
    }
}

// module countersink(shaft_diameter, head_size, head_depth, shaft_length = 50, head_length = 50)

module symbol_insert() {
    h = height - 1.7;
    d = symbol_insert_d - 0.15;
    cap_h = 3;
    cylinder(d = d, h = h - cap_h);
    translate([0, 0, h - cap_h])
        cylinder(d1 = d, d2 = d - 0.5, h = cap_h);
}

module plus_sign() {
    minus_sign();
    rotate(90)
        minus_sign();
}

module minus_sign() {
    translate([0, 0, -symbol_cut_depth/2 + 0.001])
        cube([symbol_size, symbol_line_width, symbol_cut_depth], center = true);
}

// difference() {
// rounded_cube([20, 20, 16.5], d = 15, top_d = 2, bottom_d = 2);

// translate([10, 10, 15 + 1.5])
// countersink(15, 18, 15, 1);
// }