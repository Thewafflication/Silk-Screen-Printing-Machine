$fn = 100;
length = 50.8;

wall = 9.525;
slop = 2;

width =  38.1 + slop;
height = 19.05 + slop;

smallshankd = 3.175;
shankdiameter = 8.5;
spacing = 6.35;

difference(){
    union(){
        cube([width+wall*2,height+wall*2,length+        wall],0);
        translate([0,2*(height+wall*2),(length+         wall)-(height+wall*2)])rotate([90,0,0         ])cube([width+wall*2,height+wall*2,         length],0);
    }
    translate([wall,wall,0])cube([width,height,length],0);

      translate([0,2*(height+wall*2),(length+         wall)-(height+wall*2)])rotate([90,0,0])translate([wall,wall,0])cube([width,height,length],0);

    //holes
    translate([wall+shankdiameter/2+spacing,-3,length-31.75])rotate([-60,0,0])cylinder(d=smallshankd, 25);
    translate([width+wall*2-(wall+shankdiameter/2+spacing),-3,length-31.75])rotate([-60,0,0])cylinder(d=smallshankd, 25);
}
