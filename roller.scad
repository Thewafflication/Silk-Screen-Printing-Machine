$fn = 100;
include <./modules/wood.scad>
module roller()
{
	//inside diameter
	id = 20.93;  //mm
	//outside diameter
	od = 26.67; //mm
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