$fn = 100;
include <../modules/wood.scad>

drillDepth = 12;
mmToIn = 25.4;
one    = 0.75 * mmToIn;
two    = 1.5  * mmToIn;
union(){

	difference(){
		translate([-one*0.1,-two*0.075,0])cube([one*1.2,two*1.15,12],0);
		1x2(one/2);
		translate([0,two*1.15*3/4,0])translate([-one*0.1-drillDepth,-two*0.075,6])rotate([0,90,0])cylinder(d=8,h=drillDepth+8,true);
	}
	translate([0,two*1.15*3/4,0])translate([-one*0.1-drillDepth,-two*0.075,6])rotate([0,90,0])difference(){
		cylinder(d=12,h=drillDepth,true);
		cylinder(d=8,h=drillDepth+8,true);
	}
	
}
