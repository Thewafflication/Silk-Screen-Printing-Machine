$fn = 100;

diameter = 8; //8mm
height = 30;  //30mm
module dowel(d=diameter,h=height)
{
    cylinder(d=diameter,h=height);
}
dowel();