$fn = 80;
include <./modules/wood.scad>
module bearing()
{
	//inside diameter
	id = 8;  //mm
	//outside diameter
	od = 22; //mm
	//width
	w  = 7;  //mm
	difference()
	{
		cylinder(d=od,h=w);
		cylinder(d=id,h=w);	
	}		
}
