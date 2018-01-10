$fn = 100;
include <./modules/wood.scad>;
use <./dowel.scad>;
use <./bearing.scad>;
use <./roller.scad>;
module rollerAssembly()
    {
    length = 36;
    width = one + 4 * mmToIn;
    dowelSize = 8; //8mm
    rollerSpacing = 4 * mmToIn; 
    //Boards
    difference()
    {
        union()
        {
            1x2(length);
            translate([width,0,0])1x2(length);
        }
        
        //Holes for Dowels
        for(i = [rollerSpacing:rollerSpacing:       length*mmToIn])
        {
            translate([one/2,two/2,i])rotate([0,90,0])cylinder(d=dowelSize, h = width);
        }
    }
    $fn = 100;
    for(i = [rollerSpacing:rollerSpacing:length*mmToIn])
    {
        translate([one/2,two/2,i])rotate([0,90,0])dowel();
        translate([width-30+one/2,two/2,i])rotate([0,90,0])dowel();
    
        translate([one/2+30-7,two/2,i])rotate([0,90,0])bearing();
        translate([width+-30+one/2,two/2,i])rotate([0,90,0])bearing();
    
        translate([one,two/2,i])rotate([0,90,0])roller();
    }
}
rollerAssembly();