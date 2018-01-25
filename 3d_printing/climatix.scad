body_width = 173;
body_height = 95;
body_thickness = 15;

servo_width = 23;
servo_height = 22;
servo_thickness = 12;


module button() {
    translate([0, 0, body_thickness]) {
        cube([20, 13, 2]);
    }
}

module climatix_body() {
    //translate([0, 0, -body_thickness]) {
    cube([body_width, body_height, body_thickness]);

    translate([17, 27, 0]) {button();}
    translate([17, 42, 0]) {button();}
    translate([17, 57, 0]) {button();}

    translate([body_width - 17 - 20, 27, 0]) {button();}
    translate([body_width - 17 - 20, 42, 0]) {button();}
    translate([body_width - 17 - 20, 57, 0]) {button();}
}

climatix_body();


module rod() {
    w = 21;
    h = 4;

    hull() {
        cylinder(h=2,r=4); 
        translate([15, 0, 0]) { cylinder(h=2, r=2); }
    }
    cylinder(h=4,r=4); 
}

module servo(rod_angle=180) {
    cube([servo_width, servo_height, servo_thickness]);    
    translate([-5, 18, 0]) { cube([32, 3, servo_thickness]); }
    translate([servo_thickness / 2, 0, servo_thickness / 2]) { rotate([-90, 0, 0]) { cylinder(h=servo_height + 6, r = servo_thickness / 2); } }
    translate([servo_thickness, 0, servo_thickness / 2]) { rotate([-90, 0, 0]) { cylinder(h=servo_height + 6, r = 2.5); } }
    translate([servo_thickness / 2, 0, servo_thickness / 2]) { rotate([-90, 0, 0]) { cylinder(h=servo_height + 10, r = 2.5); } }

    translate([servo_thickness / 2, 30 + 4, servo_thickness / 2]) { rotate([90, rod_angle, 0]) { rod(); } }
}

holder_thickness = 3;

// bottom left
translate([21, 1, holder_thickness + body_thickness + servo_thickness]) { rotate([0, 180, 0]) { servo(205); } }

// bottom right
translate([140, -1, holder_thickness + body_thickness + servo_thickness]) { rotate([0, 180, 0]) { servo(205); } }

// top right
translate([140, 97, holder_thickness + body_thickness]) { rotate([180, 180, 0]) { servo(155); } }

// middle right
translate([153, 81, holder_thickness + body_thickness + servo_thickness]) { rotate([180, 0, 0]) { servo(205); } }

module holder() {

    difference() {
        difference() {
            difference() {
                translate([-7, 0, body_thickness]) { cube([body_width + 15, body_height, holder_thickness]); }
                translate([15, 25, 0]) { cube([20 + 4, 13 * 3 + 2 * 2 + 4, 60]); }
            }
            translate([body_width - 17 - 20 - 2, 25, 0]) { cube([20 + 4, 13 * 3 + 2 * 2 + 4, 60]); }
        }
        translate([17 + 20 + 6, 25, 0]) { cube([85, 47, 60]); }
    }
}

holder();
