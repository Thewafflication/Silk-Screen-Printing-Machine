$fn    = 100;
include <./modules/wood.scad>;
/**
*
*Inside Dimensions 
*13.5" x Direction
*11"   y Direction
*
*/
length = 15;    //outside board
width  = 12.5;  //inside board
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