$fn = 80;
include <./modules/wood.scad>;
use <./rollerAssembly.scad>;
horizontalLength = 36;
tableHeight = 36;
legGap = 19;
tableGap = 5;
totalXGap = tableGap + 11;
module table(){
    //Vertical Boards
    for(a = [0:1:1]){
        translate([0,(3.5+legGap)*mmToIn*a,0])2x4(tableHeight);
        translate([(1.5+totalXGap)*mmToIn,(3.5+legGap)*mmToIn*a,0])2x4(tableHeight);
    }
    //Horizontal Boards
    translate([0,(26+5)*mmToIn,(horizontalLength-3.5)*mmToIn])rotate([90,0,0])translate([-1.5*mmToIn,0,0])2x4(horizontalLength);
    
    
    //Just Under Top Horizontal
    color("blue")translate([23.5*mmToIn,(26+5)*mmToIn,(horizontalLength-3.5)*mmToIn])rotate([90,0,0])translate([-1.5*mmToIn,0,0])2x4(horizontalLength);
    
    //Top Horizontals
    translate([-two,-5*mmToIn,36*mmToIn])rotate([-90,-90,0])2x4(36);
    translate([(totalXGap+1)*mmToIn,-5*mmToIn,36*mmToIn])rotate([-90,-90,0])2x4(36);
    
    
    //MidHorizontal Supports
    translate([0,3.5*mmToIn,(18-3.5)*mmToIn])rotate([90,0,90])2x4((3+totalXGap));
    translate([0,(19-1.5+3.5)*mmToIn,(18-3.5)*mmToIn])rotate([90,0,90])2x4((3+totalXGap));
    
    translate([1.5*mmToIn,(horizontalLength-5)*mmToIn,(tableHeight-1.5)*mmToIn])rotate([90,0,0])rollerAssembly();
    translate([(totalXGap+1.5)*mmToIn,(horizontalLength-5)*mmToIn,(tableHeight-1.5)*mmToIn])mirror([1,0,0])rotate([90,0,0])rollerAssembly();
}
table();