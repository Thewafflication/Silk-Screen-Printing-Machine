$fn = 80;
include <./modules/wood.scad>
module roller()
{
    mmToIn = 25.4;
	//inside diameter
	id = 0.824 * mmToIn;
	//outside diameter
	od = 1.05 * mmToIn; //mm
	//width
	w  = 4 * mmToIn;  //mm
	difference()
	{
		cylinder(d=od,h=w);
		cylinder(d=id,h=w);
        cylinder(d=22,h=7);
        translate([0,0,w-7])cylinder(d=22,h=7);
	}	

}
roller();