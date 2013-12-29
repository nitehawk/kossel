// Build the bottom frame of the printer for use in aligning parts for test fits

include <../include/configuration.scad>;
use <../Frame/vertex.scad>;

module alignment_frame() {
	// Extrusion pieces
	translate([-frame_base_size/2, 0, 0])
		cube([frame_base_size, extrusion, extrusion]);
	translate([-frame_base_size/2-13.5, extrusion+22.5, 0]) rotate([0,0,60])
		cube([frame_base_size, extrusion, extrusion]);
	translate([frame_base_size/2+26.25, extrusion+30.25, 0]) rotate([0,0,120])
		cube([frame_base_size, extrusion, extrusion]);

	// Frame Vertices
	translate([(-frame_base_size/2)-11.5, extrusion+8.5, extrusion/2])
		rotate([0,0,-60]) vertex(15, idler_offset=0, idler_space=10);
	translate([(frame_base_size/2)+11.5, extrusion+8.5, extrusion/2])
		rotate([0,0,60])  vertex(15, idler_offset=0, idler_space=10);

	// Math for third point position
	point3=((sqrt(3)*frame_base_size)/2)+43;
	translate([0, point3, extrusion/2])
		rotate([0,0,180])  vertex(15, idler_offset=0, idler_space=10);
}

alignment_frame();