
/*
An OpenSCAD program to create hinges

CC3-SA
https://creativecommons.org/licenses/by-sa/3.0/

Author: Steve Weller; https://www.thingiverse.com/Bagelturf/about

Changes: Gap between hinge pair optimised for modeling, rather than printing.  Seperated from examples.

hingeAdditiveParts() and hingeSubtractiveParts() make a hinge that stands vertically and assumes a plate drawn in the -X and +Z directions, with the hinge abutting the Z axis. The thickness of the plate is in the -Y direction. You union your plate with the additive parts and then difference the subtractive parts.

hingedPlate() makes a vertically-standing hinge as an example

hingedPlatePair() makes a pair of hinges separated by a small distance as an example

* Allows all dimensions and the number of "hingelets" to be modified
* Includes the ability to make half-height hinge pairs
* Makes well-formed STLs


Steve Weller
bagelturf@mac.com
http://www.thingiverse.com/bagelturf/
*/




// Fidelity of cylinders
$fs = 0.5;

// Creates a clearance block that removes part of the hinge and the plate so that the opposite hinge has space
module clearanceBlock(clearanceLength,clearanceHeight,hingeOutsideDiameter,hingePlateGap)
{
	delta = 0.5;
	halfDiameter = hingeOutsideDiameter * 0.5;
	clearanceDepth = halfDiameter + hingePlateGap;				// Amount into the plate
	clearanceOpposingDepth = halfDiameter + delta;		// Amount away from the plate
	translate([-clearanceDepth,-(clearanceHeight+delta),0]) cube([clearanceDepth+clearanceOpposingDepth,clearanceHeight+delta*2,clearanceLength]);
}


// The additive parts comprise the hinge barrel cylinder
module hingeAdditiveParts(plateHeight, plateThickness, hingeOutsideDiameter, hingeTopInset=0, hingeBottomInset=0, hingeLower=false, hingeUpper=false, hingeUpperLowerGap=0.3) {
	halfOutsideDiameter = hingeOutsideDiameter * 0.5;
	
	insetHingeLength = plateHeight-hingeBottomInset-hingeTopInset;
	effectiveHingeLength = (hingeLower || hingeUpper) ? (insetHingeLength+hingeUpperLowerGap)*0.5-hingeUpperLowerGap : insetHingeLength;
	effectiveTopInset = (hingeLower && !hingeUpper) ? hingeTopInset + effectiveHingeLength + hingeUpperLowerGap : hingeTopInset;
	effectiveBottomInset = (hingeUpper && !hingeLower) ?  hingeBottomInset + effectiveHingeLength + hingeUpperLowerGap : hingeBottomInset;
	color("LightGreen") translate([0,-halfOutsideDiameter,effectiveBottomInset]) cylinder(h=effectiveHingeLength,r=halfOutsideDiameter);
}

// The subtractive parts comprise the hole in the hinge and clearance blocks that remove the pieces of the hinge barrel and plate
// The design assumes that the plate is connected to the hinge on the -X side, is flat with the ZX plane, and extends into the -ZX space
module hingeSubtractiveParts(plateHeight, plateThickness, hingeOutsideDiameter, hingeInsideDiameter, hingeSectionCount, hingeTopInset=0, hingeBottomInset=0, hingeLower=false, hingeUpper=false, hingeUpperLowerGap=0.3, hingePlateGap=0.5, hingeBearingGap=0.2, hingeOutside=true) {
	delta = 0.5;
	halfInsideDiameter = hingeInsideDiameter * 0.5;
	halfOutsideDiameter = hingeOutsideDiameter * 0.5;
	insetHingeLength = plateHeight-hingeBottomInset-hingeTopInset;
	effectivePinLength = plateHeight+delta*4;
	
	// Apply upper/lower conditionals to get effective insets
	effectiveHingeLength = (hingeLower || hingeUpper) ? (insetHingeLength+hingeUpperLowerGap)*0.5-hingeUpperLowerGap : insetHingeLength;
	effectiveTopInset = (hingeLower && !hingeUpper) ? hingeTopInset + effectiveHingeLength + hingeUpperLowerGap : hingeTopInset;
	effectiveBottomInset = (hingeUpper && !hingeLower) ?  hingeBottomInset + effectiveHingeLength + hingeUpperLowerGap : hingeBottomInset;
	
	// The pin hole
	color("LemonChiffon") translate([0,-halfOutsideDiameter,-delta*2]) cylinder(h=effectivePinLength,r=halfInsideDiameter);

	// Figure hingelet length and stride
	hingeletStride = (effectiveHingeLength+hingeBearingGap)/(hingeSectionCount-0);
	hingeletLength = hingeletStride-hingeBearingGap;

	// Clearances for outside hinge case
	if(hingeOutside) {
		assign(
			clearanceBase = effectiveBottomInset + hingeletLength, 				// Skip bottom hinge 
			clearanceLength = hingeletLength + hingeBearingGap*2,
			clearanceStride = (hingeletLength + hingeBearingGap)*2,
			insetCount = floor(hingeSectionCount*0.5) ) {					// Round down to skip top hinge
			for(i=[0:insetCount-1]) {
				color("MediumSlateBlue") translate([0,0,i*clearanceStride+clearanceBase]) clearanceBlock(clearanceLength, hingeOutsideDiameter, hingeOutsideDiameter, hingePlateGap);
			}
	}
	
	// Clearances for inside hinge case
	} else {
		// Bottom hinge clearance
		assign(
			bottomBase = -delta,
			bottomLength = effectiveBottomInset + hingeletLength + hingeBearingGap + delta ) {
			color("Blue") translate([0,0,bottomBase]) clearanceBlock(bottomLength, hingeOutsideDiameter, hingeOutsideDiameter, hingePlateGap);
		}

		// Middle hinges clearance
		assign(
			clearanceBase = effectiveBottomInset + hingeletLength*2 + hingeBearingGap,
			clearanceLength = hingeletLength + hingeBearingGap*2,
			clearanceStride = (hingeletLength + hingeBearingGap)*2,
			insetCount = floor(hingeSectionCount*0.5)-2  ) {				// Skip top and bottom
				if(insetCount>=0) {	
					for(i=[0:insetCount]) {
						color("IndianRed") translate([0,0,i*clearanceStride+clearanceBase]) clearanceBlock(clearanceLength, hingeOutsideDiameter, hingeOutsideDiameter, hingePlateGap);
					}
				}
		}

		// Top hinge clearance
		assign(
			topBase = plateHeight - effectiveTopInset - hingeletLength - hingeBearingGap,
			topLength = effectiveTopInset + hingeletLength + hingeBearingGap + delta ) {
			color("Chocolate") translate([0,0,topBase]) clearanceBlock(topLength, hingeOutsideDiameter, hingeOutsideDiameter, hingePlateGap);
		}
	}
}


// An example plate with a hinge attached
// The plate is drawn in the -X and +Z directions, with the hinge abutting the Z axis. The thickness of the plate is in the -Y direction
// plateWidth				The X size of the plate
// plateHeight				The Z size of the plate
// plateThickness			The Y thickness of the plate
// hingeOutsideDiameter		Diameter of the hinge. The hinge rests on the XZ plane
// hingeInsideDiameter		The diameter of the hole through the hinge. This should be slightly larger for the inner hinge so it slips easily.
// hingeSectionCount		The number of sections in the hinge. Must be >=3 and odd
// hingeTopInset			Distance between the top of the plate and the top of the hinge
// hingeBottomInset			Distance between the bottom of the plate and the bottom of the hinge
// hingeLower				If true, make a half-hinge at the bottom
// hingeUpper				If true, make a half-hinge at the top
// hingeUpperLowerGap		Distance between upper and lower hinge pairs, if used
// hingePlateGap			Distance between the hinge cylinder and the opposing plate (default 1)
// hingeBearingGap			Distance between each hinge section and the next (default 0.2)
// innerHingeAdjustment		Small amount to add to the inside diameter of the inner hinge so that it rotates smoothly
// hingeOutside				If true makes a hinge with the hinge sections abutting the top and bottom. If false makes a hinge with sections that avoid the top and bottom. A hinge with hingeOutside true mates with a hinge with hingeOutside false

module hingedPlate(plateWidth, plateHeight, plateThickness, hingeOutsideDiameter, hingeInsideDiameter, hingeSectionCount, hingeTopInset, hingeBottomInset, hingeLower, hingeUpper, hingeUpperLowerGap, hingePlateGap, hingeBearingGap, innerHingeAdjustment, hingeOutside) {
	
	difference() {
		union() {
			translate([-plateWidth,-plateThickness,0]) cube([plateWidth,plateThickness,plateHeight]);
 			hingeAdditiveParts(plateHeight, plateThickness, hingeOutsideDiameter, hingeTopInset, hingeBottomInset, hingeLower, hingeUpper, hingeUpperLowerGap);
		}
		
		// The inside hinge has a slightly larger inside diameter
 		if(hingeOutside) {
			hingeSubtractiveParts(plateHeight, plateThickness, hingeOutsideDiameter, hingeInsideDiameter, hingeSectionCount, hingeTopInset, hingeBottomInset, hingeLower, hingeUpper, hingeUpperLowerGap, hingePlateGap, hingeBearingGap, hingeOutside);
 		} else {
			hingeSubtractiveParts(plateHeight, plateThickness, hingeOutsideDiameter, hingeInsideDiameter+innerHingeAdjustment, hingeSectionCount, hingeTopInset, hingeBottomInset, hingeLower, hingeUpper, hingeUpperLowerGap, hingePlateGap, hingeBearingGap, hingeOutside);
		}
	}
}


// Example hinged plate pair

module hingedPlatePair(plateWidth, plateHeight, plateThickness, hingeOutsideDiameter, hingeInsideDiameter, hingeSectionCount) 
{
	assign(hingeTopInset=0.0, hingeBottomInset=0.0, hingeUpperLowerGap=2.0, hingePlateGap=0.3, hingeBearingGap=0.2, innerHingeAdjustment=0.1, hingeLower=false, hingeUpper=false) {
		// Lefthand with outside sections
		hingedPlate(plateWidth, plateHeight, plateThickness, hingeOutsideDiameter, hingeInsideDiameter, hingeSectionCount, hingeTopInset, hingeBottomInset, hingeLower, hingeUpper, hingeUpperLowerGap, hingePlateGap, hingeBearingGap, innerHingeAdjustment, true);

		// Righthand with inside sections
		translate([0,0,0]) mirror([1,0,0])
		hingedPlate(plateWidth, plateHeight, plateThickness, hingeOutsideDiameter, hingeInsideDiameter, hingeSectionCount, hingeTopInset, hingeBottomInset, hingeLower, hingeUpper, hingeUpperLowerGap, hingePlateGap, hingeBearingGap, innerHingeAdjustment, false);
	}
}

// Instantiate
hingedPlatePair(plateWidth=24, plateHeight=40, plateThickness=1.0, hingeOutsideDiameter=4, hingeInsideDiameter=2.16, hingeSectionCount=5 );






