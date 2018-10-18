body_width = 173;
body_height = 97;
body_thickness = 21;

servo_width = 23;
servo_height = 22;
servo_thickness = 12;

holder_thickness = 4;

clip_width = 13;
clip_thickness = 4;

module holder_plate_clip(x=0, y=0, z=0) {

    difference() {
        union() {
            // sides
            translate([x, y, z]) { cube([clip_width, clip_thickness-1, 40]); }
            translate([x, y + 7 + body_height, z]) { cube([clip_width, clip_thickness - 1, 40]); }

            translate([x, y, z]) { cube([clip_width, body_height + 10, 5]); } // bottom plate
        }
        translate([x + (clip_width / 2) - (3 / 2), y - 5, holder_thickness + 1 + 23.5/*z + 5 + body_thickness + holder_thickness*/]) { cube([3, body_height + 20, 5]); } // hole
        translate([clip_width / 2, 25, 1]) { cylinder(10, 4, 4, [0, 0, 0]); };
        translate([clip_width / 2, 82, 1]) { cylinder(10, 4, 4, [0, 0, 0]); };

    }
}


translate([0, 0, clip_width]) { rotate([0, 90, 0]) { holder_plate_clip(); } }
translate([45, 0, clip_width]) { rotate([0, 90, 0]) { holder_plate_clip(); } }

