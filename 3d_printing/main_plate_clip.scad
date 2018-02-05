body_width = 173;
body_height = 95;
body_thickness = 15;

servo_width = 23;
servo_height = 22;
servo_thickness = 12;

holder_thickness = 3;


module holder_plate_clip(x=0, y=0, z=0) {

    difference() {
        union() {
            // sides
            translate([x, y, z]) { cube([15, 5, 30]); }
            translate([x, y + 5 + body_height, z]) { cube([15, 5, 30]); }

            translate([x, y, z]) { cube([15, body_height + 10, 5]); } // bottom plate
        }
        translate([x + (15 / 2) - ( 3 / 2), y - 5, z + 5 + body_thickness + holder_thickness]) { cube([3, body_height + 20, 3]); } // bottom plate

    }
}


translate([0, 0, 15]) { rotate([0, 90, 0]) { holder_plate_clip(); } }
translate([45, 0, 15]) { rotate([0, 90, 0]) { holder_plate_clip(); } }

