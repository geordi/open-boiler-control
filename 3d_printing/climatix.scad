body_width = 173;
body_height = 95;
body_thickness = 15;

servo_width = 23;
servo_height = 22;
servo_thickness = 12;

holder_thickness = 3;


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


module rod() {
    w = 21;
    h = 4;

    hull() {
        cylinder(h=2,r=4); 
        translate([15, 0, 0]) { cylinder(h=2, r=2); }
    }
    cylinder(h=4,r=4); 
}


module servo(rod_angle=180, left_holder=true, right_holder=true) {
    cube([servo_width, servo_height, servo_thickness]); // servo main body
    difference() { // holding plate
        translate([-5, 18, 0]) { cube([32, 3, servo_thickness]); }
        translate([-2.5, 22, servo_thickness / 2]) { rotate([90, 0, 0]) { cylinder(h=10, r=1); } }
        translate([servo_width + 2.5, 22, servo_thickness / 2]) { rotate([90, 0, 0]) { cylinder(h=10, r=1); } }
    }

    // gearbox and axle
    translate([servo_thickness / 2, 0, servo_thickness / 2]) { rotate([-90, 0, 0]) { cylinder(h=servo_height + 6, r = servo_thickness / 2); } }
    translate([servo_thickness, 0, servo_thickness / 2]) { rotate([-90, 0, 0]) { cylinder(h=servo_height + 6, r = 2.5); } }
    translate([servo_thickness / 2, 0, servo_thickness / 2]) { rotate([-90, 0, 0]) { cylinder(h=servo_height + 10, r = 2.5); } }

    translate([servo_thickness / 2, 30 + 4, servo_thickness / 2]) { rotate([90, rod_angle, 0]) { rod(); } }

    if ( left_holder ) {
        servo_holder_left();
    }
    if ( right_holder ) {
        servo_holder_right();
    }
}


module main_plate_holder() {
    difference() {
        translate([-7, 0, body_thickness]) { cube([body_width + 15, body_height, holder_thickness]); }
        translate([15, 25, 0]) { cube([20 + 4, 13 * 3 + 2 * 2 + 4, 60]); }
        translate([body_width - 17 - 20 - 2, 25, 0]) { cube([20 + 4, 13 * 3 + 2 * 2 + 4, 60]); }
        translate([17 + 20 + 6, 25, 0]) { cube([85, 47, 60]); }
    }
}


module servo_holder_left() {
    servo_holder_height = 4;
    difference() {
        translate([-12, 18 - servo_holder_height, 0]) { cube([12, servo_holder_height, servo_thickness]); }
        translate([-2.5, 22, servo_thickness / 2]) { rotate([90, 0, 0]) { cylinder(h=10, r=1); } }
    }
}


module servo_holder_right() {
    servo_holder_height = 4;
    difference() {
        translate([servo_width, 18 - servo_holder_height, 0]) { cube([12, servo_holder_height, servo_thickness]); }
        translate([servo_width + 2.5, 22, servo_thickness / 2]) { rotate([90, 0, 0]) { cylinder(h=10, r=1); } }
    }
}


climatix_body();

main_plate_holder();

// bottom left
translate([6, 0, holder_thickness + body_thickness]) { rotate([0, 0, 0]) { servo(25); } }

// bottom right
translate([body_width - 37, 0, holder_thickness + body_thickness + servo_thickness]) { rotate([0, 180, 0]) { servo(205); } }

// top right
translate([body_width - 37, body_height + 4, holder_thickness + body_thickness]) { rotate([180, 180, 0]) { servo(155); } }

// middle right
translate([153, 81, holder_thickness + body_thickness + servo_thickness]) { rotate([180, 0, 0]) { servo(205, false, true); } }