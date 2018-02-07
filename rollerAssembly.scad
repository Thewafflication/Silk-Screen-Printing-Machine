$fn = 80;
include <./modules/wood.scad>;
use <./dowel.scad>;
use <./bearing.scad>;
use <./roller.scad>;
module rollerAssembly()
{
    length = 36;
    mmToIn = 25.4;
    lengthInner = length - 1.75;
    width = one + 4 * mmToIn;
    dowelSize = 8; //8mm
    rollerSpacing = 3.5 * mmToIn; 
    rollerHeight = 1.125 * mmToIn;
    rollerOffset = 1.05 / 2 * mmToIn;
    //Outside
    union()
    {    
        difference()
        {
            1x2(length);
            //Holes for Dowels
            for(i = [rollerOffset:rollerSpacing:length*mmToIn])
            {
                translate([one/2,rollerHeight,i])rotate([0,90,0])cylinder(d=dowelSize, h = width);
            }
        }
        difference()
        {
            translate([width,0,0])1x2(length-2);        
            //Holes for Dowels
            for(i = [rollerOffset:rollerSpacing : lengthInner*mmToIn])
            {
                translate([one/2,rollerHeight,i])rotate([0,90,0])cylinder(d=dowelSize, h = width);
            }
        }
    }
    for(i = [rollerOffset:rollerSpacing:lengthInner*mmToIn])
    {
        translate([one/2,rollerHeight,i])rotate([0,90,0])dowel();
        translate([width-30+one/2,rollerHeight,i])rotate([0,90,0])dowel();
    
        translate([one/2+30-7,rollerHeight,i])rotate([0,90,0])bearing();
        translate([width+-30+one/2,rollerHeight,i])rotate([0,90,0])bearing();
    
        translate([one,rollerHeight,i])rotate([0,90,0])roller();
    }
}
rollerAssembly();