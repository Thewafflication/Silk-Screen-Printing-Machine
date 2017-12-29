$fn = 100;
length = 50.8;

wall = 9.525;
slop = 2;

width =  38.1 + slop;
height = 19.05 + slop;

shankdiameter = 8.5;
spacing = 6.35;

difference(){
    cube([width+wall*2,height+wall*2,length+wall],0);
    translate([wall,wall,0])cube([width,height,length],0);
    translate([wall+shankdiameter/2+spacing,-3,length-31.75])rotate([-60,0,0])cylinder(d=shankdiameter, 25);
    translate([width+wall*2-(wall+shankdiameter/2+spacing),-3,length-31.75])rotate([-60,0,0])cylinder(d=shankdiameter, 25);
}
