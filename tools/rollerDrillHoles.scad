$fn = 100;
$fs = 120;
mmToIn = 25.4;
one    = 0.75 * mmToIn;
two    = 1.5  * mmToIn;
four   = 3.5  * mmToIn;

module 1x2(length){
     cube([one,two,length*mmToIn],0);
}
module 2x4(length){
     cube([two,four,length*mmToIn],0);
}

module 1x4(length){
     cube([one,four,length*mmToIn],0);
}
drillDepth = 12;
union(){

	difference(){
		translate([-one*0.1,-two*0.075,0])cube([one*1.2,two*1.15,12],0);
		1x2(one/2);
		translate([0,two*1.15*3/4,0])translate([-one*0.1-drillDepth,-two*0.075,6])rotate([0,90,0])cylinder(drillDepth+8,d=8,true);
	}
	translate([0,two*1.15*3/4,0])translate([-one*0.1-drillDepth,-two*0.075,6])rotate([0,90,0])difference(){
		cylinder(drillDepth,r=6,true);
        cylinder(drillDepth+8,r=4,true);
		
	}
	
}
