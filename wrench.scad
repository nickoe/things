size = 7;
dia = 7;
height = dia/2;

difference() {
	union() {
		cylinder(h = height, r = dia*1.2, $fn = 16);
		translate([0,-dia*1.1/2,0]) cube(size = [dia*9,dia*1.1,height]);
		translate([dia*9,0,0]) cylinder(h = height, r = dia*1.1/2, $fn = 16);
		rotate([0, 0, 70]) translate([dia/6, -dia*2, 0]) cube(size = [dia,dia*2,height]);
		rotate([0, 0, -70]) translate([dia/6, 0, 0]) cube(size = [dia,dia*2,height]);
	}
	union() {
		rotate([0, 0, 360/12]) {
			cylinder(h = 20, r = (dia/2)*1.156, $fn = 6, center = true);
			rotate([0, 0, 360/12]) translate([-dia/2, 0, -1]) cube(size = [dia,80,50]);
		}
	}
}
