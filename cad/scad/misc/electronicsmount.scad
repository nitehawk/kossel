// Mounting platform for power supply and ramps board
// note - ramps board this is based on is the gadgets3d board
// with the addon lcd shield

// Platform mounts to the bottom support triangle using
// the space between the rails.

include <../include/configuration.scad>;

// Include the bottom frame parts so we can model the frame for positioning
use <../Frame/alignment_frame_bot.scad>;

flange_length=extrusion;
screw_offset = extrusion/2;

pslen=200;
pswid=100;
pshei=45;
psbuffer=30;

rampswallbuff=10;
rampslen=125;
rampswid=70;
rampshei=45;

bot_t = 2;

$fn=30;

module psup() {
	cube([pslen, pswid, pshei]);
}

module ramps() {
	cube([rampslen, rampswid, rampshei]);
}

module screw_socket() {
  cylinder(r=m3_wide_radius, h=20, center=true);
  translate([0, 0, 3.8]) cylinder(r=3.5, h=5);
}

module flange() {
	difference() {
		cube([flange_length, extrusion+thickness, thickness]);
		translate([screw_offset, screw_offset, 0]) #screw_socket();
	}
}

module electronics_mount() {
	union() {
		// Mounting flanges
		translate([-rampslen/2,0,extrusion]) flange();
		translate([rampslen/2-flange_length, 0, extrusion])
			flange();

		// Walls
		translate([-rampslen/2, extrusion, 0]) cube([rampslen,thickness,extrusion+thickness]);

		// Ramps tray
		translate([-rampslen/2, extrusion, 0])
		{
			cube([rampslen, rampswid+rampswallbuff, bot_t]);
			// Show our 'ramps' device in quick mode
			translate([0,rampswallbuff,bot_t]) % ramps();
		}

		// Power supply tray
		translate([-pslen/2, extrusion+rampswid+rampswallbuff+psbuffer, 0])
		{
			cube([pslen, pswid, bot_t]);
			// Show our 'power supply' device in quick mode
			translate([0,0,bot_t]) % psup();
		}
	}


}




translate([0,0,0]) electronics_mount();

% alignment_frame_bot();
