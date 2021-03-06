// More Fontz! by polymaker http://www.thingiverse.com/thing:13677
include <../include/Orbitron_Medium.scad>;


module kossel_logo() {
	// steps - the amount of detail, the higher the more detailed.
	// center - whether the output is centered or not
	// extra - extra distance between characters
	// height - height of extrusion, 0 for 2d
	Orbitron_Medium("KOSSEL", steps=2, center=true, extra=10, height=5);
}

module kosselhawk_logo() {
	// steps - the amount of detail, the higher the more detailed.
	// center - whether the output is centered or not
	// extra - extra distance between characters
	// height - height of extrusion, 0 for 2d
	Orbitron_Medium("HAWK", steps=2, center=true, extra=10, height=5);
}

kossel_logo();
