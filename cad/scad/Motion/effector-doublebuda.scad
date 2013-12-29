include <../include/configuration.scad>;
use <../include/m5_internal.scad>;

separation = 40;  // Distance between ball joint mounting faces.
offset = 60;  // Same as DELTA_EFFECTOR_OFFSET in Marlin.
mount_radius = 12.5;  // Hotend mounting screws, standard would be 25mm.
hotend_radius = 8;  // Hole for the hotend (J-Head diameter is 16mm).
push_fit_height = 4;  // Length of brass threaded into printed plastic.
height = 8;
cone_r1 = 2.5;
cone_r2 = 14;
buda_width = 51;
buda_hole_separation = 42;

module arm_mounts() {
		for (ang = [0, 120, 240]) rotate([0, 0, ang]) {
			//LED strips
			//translate([0, offset-10,-((height+3)/2)]) % cube ([51, 10, 3], center=true);
			for (s = [-1, 1]) scale([s, 1, 1]) {
			  translate([0, offset, 0]) difference() {
				intersection() {
				  cube([separation, 40, height], center=true);
				  translate([0, -4, 0]) rotate([0, 90, 0])
				cylinder(r=10, h=separation, center=true);
				  translate([separation/2-7, 0, 0]) rotate([0, 90, 0])
				cylinder(r1=cone_r2, r2=cone_r1, h=14, center=true, $fn=24);
				}
				rotate([0, 90, 0])
				  cylinder(r=m3_radius+0.1, h=separation+1, center=true, $fn=12);
				rotate([90, 0, 90])
				  cylinder(r=m3_nut_radius, h=separation-24, center=true, $fn=6);
			  }
			}
		}
}

module buda_effector() {
	union() {
		difference() {
			cylinder(r=offset-1, h=height, center=true, $fn=6);
			cylinder(r=offset-12, h=height+5, center=true, $fn=6);
		}
		// Buda mounting braces
		difference() {
			translate([buda_width/2+2,0,0])
				cube([12, (offset-15.5)*2, height], center=true);
			translate([buda_width/2+2,buda_hole_separation/2,0])
			  #	cylinder(r=m5_radius+0.2, h=height*2, center=true, $fn=20);
			translate([buda_width/2+2,-buda_hole_separation/2,0])
			  #	cylinder(r=m5_radius+0.2, h=height*2, center=true, $fn=20);
		}

		difference() {
			translate([-buda_width/2-2,0,0])
				cube([12, (offset-15.5)*2, height], center=true);
			translate([-buda_width/2-2,buda_hole_separation/2,0])
			  #	cylinder(r=m5_radius+0.2, h=height*2, center=true, $fn=20);
			translate([-buda_width/2-2,-buda_hole_separation/2,0])
			  #	cylinder(r=m5_radius+0.2, h=height*2, center=true, $fn=20);
		}

		 arm_mounts();
	}
}

module effector() {
  difference() {
    union() {
      //cylinder(r=offset-3, h=height, center=true, $fn=60);
      for (a = [60:120:359]) rotate([0, 0, a]) {
	rotate([0, 0, 30]) translate([offset-13, 0, 0])
	  cube([10, 48, height], center=true);
	for (s = [-1, 1]) scale([s, 1, 1]) {
	  translate([0, offset, 0]) difference() {
	    intersection() {
	      cube([separation, 40, height], center=true);
	      translate([0, -4, 0]) rotate([0, 90, 0])
		cylinder(r=10, h=separation, center=true);
	      translate([separation/2-7, 0, 0]) rotate([0, 90, 0])
		cylinder(r1=cone_r2, r2=cone_r1, h=14, center=true, $fn=24);
	    }
	    rotate([0, 90, 0])
	      cylinder(r=m3_radius, h=separation+1, center=true, $fn=12);
	    rotate([90, 0, 90])
	      cylinder(r=m3_nut_radius, h=separation-24, center=true, $fn=6);
	  }
        }
      }
    }
    translate([0, 0, push_fit_height-height/2])
      cylinder(r=hotend_radius, h=height, $fn=36);
    translate([0, 0, -6]) # m5_internal();
    for (a = [0:60:359]) rotate([0, 0, a]) {
      translate([0, mount_radius, 0])
	cylinder(r=m3_wide_radius, h=2*height, center=true, $fn=12);
    }
  }
}


translate([0, 0, height/2]) buda_effector();
