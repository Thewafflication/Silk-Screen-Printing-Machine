$fn    = 10;
include <./modules/wood.scad>;
use <./rollerAssembly.scad>;
horizontalLength = 36;

module table(){
    //Vertical Boards
    for(a = [0:1:1]){
        translate([0,(3.5+19)*mmToIn*a,0])2x4(36);
        translate([(1.5+19)*mmToIn,(3.5+19)*mmToIn*a,0])2x4(36);
    }
    //Horizontal Boards
    translate([0,(26+5)*mmToIn,(horizontalLength-3.5)*mmToIn])rotate([90,0,0])translate([-1.5*mmToIn,0,0])2x4(horizontalLength);
    
    color("blue")translate([23.5*mmToIn,(26+5)*mmToIn,(horizontalLength-3.5)*mmToIn])rotate([90,0,0])translate([-1.5*mmToIn,0,0])2x4(horizontalLength);
    
    translate([-two,-5*mmToIn,36*mmToIn])rotate([-90,-90,0])1x4(36);
    
    color("red")translate([20*mmToIn,-5*mmToIn,36*mmToIn])rotate([-90,-90,0])1x4(36);
    
    translate([0,3.5*mmToIn,(18-3.5)*mmToIn])rotate([90,0,90])2x4((3+19));
    
    translate([0,(19-1.5+3.5)*mmToIn,(18-3.5)*mmToIn])rotate([90,0,90])2x4((3+19));
    
    translate([two,-5*mmToIn,36*mmToIn])rotate([-90,0,0])rollerAssembly();
    translate([19*mmToIn-2.75*mmToIn-two,-5*mmToIn,36*mmToIn])rotate([-90,0,0])rollerAssembly();
}
table();