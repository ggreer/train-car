$fa = 1;
$fs = 0.4;

thickness=3;

module linkage (length) {
  difference() {
    hull() {
      translate([length, 0, 0])
      cylinder(d=8, h=thickness);
      cylinder(d=8, h=thickness);
    }
    translate([0, 0, -1]) {
      translate([length, 0, 0])
      cylinder(d=4.5, h=thickness + 2);
      cylinder(d=4.5, h=thickness + 2);
    }
  }
}

linkage(20);
