$fn = 80;

difference(){
    cylinder(d=33,h=26);
    translate([0,0,2])difference(){
        cylinder(d=33,h=26);
        cylinder(d=26,h=26);
}
}
translate([0,0,-25.4*3/4])difference(){
        cylinder(r=25.4/2/2,h=25.4*3/4);
        difference(){
            cylinder(r=3,h=25.4/2);
            translate([-4.944/2,1.7,0])cube([4.944,1.3,25.4*2/4],0);
        }
 translate([0,25.4/2/2,25.4*1/4])rotate([90,0,0])cylinder(d=2.2606,h=4.65);
        translate([0,25.4/2/2,25.4*7/16])rotate([90,0,0])cylinder(d=2.2606,h=4.65);
        
    cylinder(r=3,h=25.4*1/8);
}
