$fn    = 100;
include <./modules/wood.scad>;

length = 15;
width  = 12.5;
module frame(){
//Top
rotate([90,0,90])1x2(length);
//Bottom
translate([0,-1*width*mmToIn-one,0])rotate([90,0,90])1x2(length);
//Left
rotate([90,0,0])1x2(width);
//Right
translate([length*mmToIn-one,0,0])rotate([90,0,0])1x2(width);
}
frame();