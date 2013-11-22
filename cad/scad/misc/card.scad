use <../misc/logotype.scad>;

scale([-1, 1, 1]) difference() {
  minkowski() {
    cube([66, 29, 0.2], center=true);
    cylinder(r=10, h=0.2, $fn=24);
  }
  difference() {
    translate([1, -4, 0]) scale([0.2, 0.2, 1]) kossel_logo();
    # translate([-17.2, 0, 0]) cube([1, 20, 20], center=true);
  }
}
