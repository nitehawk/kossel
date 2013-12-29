// Mounting tabs for glass build bed without heated bed
// Need 1 left and 1 right for each face of the base triangle

include <../include/configuration.scad>;

beddiameter = 300;
screw_offset = extrusion/2;
support_size = 40;
screw_tol=.125;

module glass_support_left()
{
	difference()
	{
		// Support plate
		cube([support_size, support_size, thickness*2]);
		// Remove area for glass bed to rest
		translate([beddiameter/2,support_size*2,thickness]) cylinder(r=beddiameter/2, h=thickness, $fn=beddiameter);
		// Make first mounting hole
		translate([screw_offset, screw_offset, 0]) cylinder(r=m3_wide_radius, h=thickness*2, $fn=12);
	}
}

module glass_support_right()
{
	difference()
	{
		// Support plate
		cube([support_size, support_size, thickness*2]);
		// Remove area for glass bed to rest
		translate([beddiameter/2,-(support_size),thickness]) cylinder(r=beddiameter/2, h=thickness, $fn=beddiameter);
		// Make first mounting hole
		translate([screw_offset, support_size - screw_offset, 0]) cylinder(r=m3_wide_radius, h=thickness*2, $fn=12);
	}
}

translate([-support_size,0,0]) glass_support_left();
translate([support_size,0,0]) glass_support_right();