include <openscad-utilities/common.scad>

battery_d = 15;
top_d = 18;

edge_margin = 2.5;
margin = 1.5;

columns = 5;
rows = 2;

symbol_size = 10;
symbol_line_width = 2.5;

base_x = columns * (top_d + margin) + margin + 2 * symbol_size + 2 * edge_margin;
base_y = rows * top_d + (rows - 1) * margin + 2 * edge_margin;

height = 20;

difference() {
    rounded_cube([base_x, base_y, height], d = 25, top_d = 2, bottom_d = 2);
    for (j = [0 : rows - 1]) {
        translate([0, j * (top_d + margin)]) {
            for (i = [0 : columns - 1]) {
                translate([(top_d/2 + margin) + i * (top_d + margin) + symbol_size + edge_margin, top_d/2 + edge_margin, height]) {
                    countersink(battery_d, top_d, height - 1.5, 1);
                }
            }
        }
    }

    translate([edge_margin + symbol_size/2, edge_margin + top_d/2, height]) plus_sign();
    translate([edge_margin + symbol_size/2,  edge_margin + margin + 1.5 * top_d, height]) minus_sign();
    translate([base_x - symbol_size/2 - edge_margin, edge_margin + top_d/2, height]) plus_sign();
    translate([base_x - symbol_size/2 - edge_margin,  edge_margin + margin + 1.5 * top_d, height]) minus_sign();
}



module plus_sign() {
    cube([symbol_size, symbol_line_width, 3], center = true);
    cube([symbol_line_width, symbol_size, 3], center = true);
}

module minus_sign() {
    cube([symbol_size, symbol_line_width, 3], center = true);
}

// difference() {
// rounded_cube([20, 20, 16.5], d = 15, top_d = 2, bottom_d = 2);

// translate([10, 10, 15 + 1.5])
// countersink(15, 18, 15, 1);
// }