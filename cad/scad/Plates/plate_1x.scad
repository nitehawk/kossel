include <../include/configuration.scad>;

use <../motion/effector.scad>;
use <../probe/retractable.scad>;
use <../misc/power_supply.scad>;
use <../motion/extruder.scad>;

% translate([0, 0, -3]) cylinder(r=85, h=3);
translate([0, 30, 0]) union() {
  translate([0, 0, 4]) effector();
  translate([0, -30, 0]) power_supply();
  translate([0, -42, 0]) rotate([0, 0, 180]) power_supply();
  translate([-20, -65, 0]) rotate([0, 0, 45]) retractable();
  translate([-8, -47, 0]) extruder();
}
