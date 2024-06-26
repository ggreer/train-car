use<MCAD/triangles.scad>;

$fa = 1;
$fs = 0.4;

// width = 33;
// length = 65;
// height = 30;
thickness = 3;

boxWidth = 19.0;
boxLength = 51;
boxHeight = 12;

bodyHeight = 12.5;
bodyWidth = 35;
bodyLength = 75;

wheelDiameter = 25;
wheelThickness = 12;
axleDiameter = 8;
axleLength = bodyWidth + (wheelThickness * 2);
axleGap = 1.2;


module wheel () {
  cylinder(d=wheelDiameter, h=wheelThickness/2);
  translate([0, 0, wheelThickness/2])
  cylinder(d1=wheelDiameter, d2=axleDiameter, h=wheelThickness/2);

  cylinder(d=axleDiameter, h=axleLength);

  translate([0, 0, axleLength-wheelThickness]) {
    translate([0, 0, wheelThickness/2])
    cylinder(d=wheelDiameter, h=wheelThickness/2);
    cylinder(d1=axleDiameter, d2=wheelDiameter, h=wheelThickness/2);
  }
}

hitchDiameter = bodyWidth/2 - 3;
module frontHitch () {
  translate([hitchDiameter/2 - 2, bodyWidth/2, 0])
  cylinder(d1=4, d2=3, h=11);
  translate([hitchDiameter/2, bodyWidth/2, -bodyHeight])
  difference() {
    cylinder(d=hitchDiameter, h=bodyHeight);
    translate([0, -bodyWidth/2, -1])
    cube([hitchDiameter/2, bodyWidth, bodyHeight+2]);
  }
}

module rearHitch () {
  translate([-5.5, bodyWidth/2, 0]) {
    cylinder(d1=4, d2=3, h=11);
    translate([-1.5, 0, -bodyHeight])
    difference() {
      cylinder(d=hitchDiameter, h=bodyHeight);
      translate([-hitchDiameter/2, -bodyWidth/2, -1])
      cube([hitchDiameter/2, bodyWidth, bodyHeight+2]);
    }
  }
}

module body() {
  difference() {
    hull() {
      translate([0, bodyWidth/4, 0])
      cube([bodyLength, bodyWidth/2, bodyHeight]);
      rotate([0, 90, 0])
      translate([-bodyHeight/2, bodyHeight/2])
      cylinder(d=bodyHeight, h=bodyLength);
      rotate([0, 90, 0])
      translate([-bodyHeight/2, bodyWidth - bodyHeight/2])
      cylinder(d=bodyHeight, h=bodyLength);
    }

    // Holes for axles
    translate([wheelDiameter/1.4, -1, bodyHeight/2])
    rotate([-90, 0, 0])
    cylinder(d=axleDiameter + axleGap, h=bodyWidth+2);
    translate([bodyLength - wheelDiameter/1.4, -1, bodyHeight/2])
    rotate([-90, 0, 0])
    cylinder(d=axleDiameter + axleGap, h=bodyWidth+2);

    translate([0, 0, -1])
    cylinder(r=bodyWidth/3, h=bodyHeight+2);
    translate([0, bodyWidth, -1])
    cylinder(r=bodyWidth/3, h=bodyHeight+2);
    translate([bodyLength, 0, -1])
    cylinder(r=bodyWidth/3, h=bodyHeight+2);
    translate([bodyLength, bodyWidth, -1])
    cylinder(r=bodyWidth/3, h=bodyHeight+2);

    cubeLength = bodyWidth/5 - 1.5;
    translate([-1, 0, -1])
    cube([cubeLength, bodyWidth, bodyHeight+2]);
    translate([bodyLength - cubeLength +1, 0, -1])
    cube([cubeLength, bodyWidth, bodyHeight+2]);
  }
}

module box() {
  translate([thickness, thickness, 1.2])
  difference() {
    translate([-thickness, -thickness, -thickness])
    hull() {
      cube([boxLength, boxWidth, boxHeight]);
      translate([0, (boxWidth - (bodyWidth - 3.9))/2, 0])
      cube([boxLength, bodyWidth - 3.9, 0.1]);
    }
    for (i = [0:1:2]) {
      translate([i * ((boxLength+8.4)/3) - thickness/2, -thickness/2, 0])
      cube([8.4, boxWidth-thickness, boxHeight]);
    }

    // cube([boxLength - thickness * 2, boxWidth - thickness * 2, boxHeight]);
  }
}

// Wheels
translate([0, -wheelThickness, -bodyHeight/2])
rotate([-90, 0, 0]) {
  translate([wheelDiameter/1.4, 0, 0])
  wheel();
  translate([bodyLength - wheelDiameter/1.4, 0, 0]) {
    // wheelConnection();
    wheel();
  }
}

frontHitch();
translate([bodyLength, 0, 0])
rearHitch();

translate([(bodyLength - boxLength)/2, (bodyWidth - boxWidth) / 2, 0])
box();

translate([0, 0, -bodyHeight])
body();
