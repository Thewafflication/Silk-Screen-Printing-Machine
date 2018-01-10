$fn = 100;
use <hinge.scad>;
use <frame.scad>;
use <table.scad>;
include <./modules/wood.scad>;
use <./rollerAssembly.scad>;

translate([two,10.5*mmToIn,0])rotate([0,0,90])translate([0,-one,36*mmToIn+one])
    {
    frame();
    translate([5.5*mmToIn,one+0.09375*mmToIn,two])
    rotate([-90,0,90])hinge();
    translate([11*mmToIn,one+0.09375*mmToIn,two])rotate([-90,0,90])hinge();
}

translate([two,5*mmToIn,0])table();