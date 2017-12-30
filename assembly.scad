$fn = 100;
use <hinge.scad>;
use <frame.scad>;

include <./modules/wood.scad>;

frame();
translate([5.5*mmToIn,one+0.09375*mmToIn,two])
rotate([-90,0,90])hinge();
translate([11*mmToIn,one+0.09375*mmToIn,two])rotate([-90,0,90])hinge();

