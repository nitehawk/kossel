include <../include/configuration.scad>;

separation = 40;
thickness = 6;

horn_thickness = 13;
horn_x = 8;

belt_width = 5;
belt_x = 6.75;
belt_z = 7;

tooth_width=1.3;
tooth_height=.75;
belt_pitch = 2;

stol=0.125;

module teeth(width) {
	for ( i = [round(-width/belt_pitch/2) : round(width/belt_pitch/2)]){
			translate(v = [0,belt_pitch*i,tooth_height])cube(size = [horn_thickness-2, tooth_width, tooth_height*2], center = true);
		}
}



module carriage() {
  // Timing belt (up and down).
  translate([-belt_x, 0, belt_z + belt_width/2]) %
    cube([1.7, 100, belt_width], center=true);
  translate([belt_x, 0, belt_z + belt_width/2]) %
    cube([1.7, 100, belt_width], center=true);
  difference() {
    union() {
      // Main body.
      translate([0, -1, thickness/2])
        cube([27, 50, thickness], center=true);
      // Ball joint mount horns.
      for (x = [-1, 1]) {
        scale([x, 1, 1]) intersection() {
          translate([0, 15, horn_thickness/2])
            cube([separation, 18, horn_thickness], center=true);
          translate([horn_x, 16, horn_thickness/2]) rotate([0, 90, 0])
            cylinder(r1=14, r2=2.5, h=separation/2-horn_x);
        }
      }
      // Belt clamps.
      difference() {
        union() {
          translate([2.25, -1.5, horn_thickness/2+1])
            cube([5.75, 7, horn_thickness-2], center=true);
          translate([10.75, 2.5, horn_thickness/2+1])
            cube([5.5, 15, horn_thickness-2], center=true);
        }
        // Avoid touching diagonal push rods (carbon tube).
        translate([20, -10, 12.5]) rotate([35, 35, 30])
          cube([40, 40, 20], center=true);
      }
		
		translate([2.25, -12, horn_thickness/2+1]) cube([5.75, 8, horn_thickness-2], center=true);
		
		difference() {
			translate([1.75, 8, horn_thickness/2+1]) cube([8, 8, horn_thickness-2], center=true);
			translate([4+tooth_height, 8, horn_thickness/2+2]) rotate([0,90,0]) teeth(8);
		}

		difference() {
			translate([1.75, -22, horn_thickness/2+1]) cube([8, 8, horn_thickness-2], center=true);
			translate([4+tooth_height, -22, horn_thickness/2+2]) rotate([0,90,0]) teeth(8);
		}

		translate([9.5, -19.5, horn_thickness/2+1]) cube([3, 13, horn_thickness-2], center=true);
    }
    // Screws for linear slider.
    for (x = [-10, 10]) {
      for (y = [-10, 10]) {
        translate([x, y, thickness]) #
          cylinder(r=m3_wide_radius+stol, h=30, center=true, $fn=12);
      }
    }
    // Screws for ball joints.
    translate([0, 16, horn_thickness/2]) rotate([0, 90, 0]) #
      cylinder(r=m3_wide_radius+stol, h=60, center=true, $fn=12);
    // Lock nuts for ball joints.
    for (x = [-1, 1]) {
      scale([x, 1, 1]) intersection() {
        translate([horn_x, 16, horn_thickness/2]) rotate([90, 0, -90])
          cylinder(r1=m3_nut_radius, r2=m3_nut_radius+0.5, h=8,
                   center=true, $fn=6);
      }
    }
  }
}

carriage();
//rotate([90,90,0]) teeth(5);
