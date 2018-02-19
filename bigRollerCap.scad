$fn = 80;

difference(){
    cylinder(d=34,h=26);
    cylinder(r=4,h=26);
    
    translate([0,0,2])difference(){
        cylinder(d=34,h=26);
        cylinder(d=26,h=26);
    }
}