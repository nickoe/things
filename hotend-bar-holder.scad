w = 23;
l = 70;
h = 4;
bar_hole_d = 30;

m3_diameter = 3.6;
m3_nut_diameter = 5.3;

// Based on nophead research
module polyhole(d,h) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
		cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n, center=true);
}

module mountingholes(){
	translate(v = [0, -25, -1]) polyhole(m3_diameter,10);
	translate(v = [0, 25, -1]) polyhole(m3_diameter,10);
}

module holder() {
	difference() {
		union() {
			cube(size = [w,l,h], center = true);
			translate(v = [0, bar_hole_d/2, 0]) cylinder(h = h/2+2, r = m3_nut_diameter, $fn = 24, center=false);
			translate(v = [0, -bar_hole_d/2, 0]) cylinder(h = h/2+2, r = m3_nut_diameter, $fn = 24, center=false);
		}
		union() {
			translate(v = [0, bar_hole_d/2, 0]) {
				polyhole(m3_diameter,20);
				cylinder(h = 7, r=m3_nut_diameter/2, $fn=6, center=false);
			}
			translate(v = [0, -bar_hole_d/2, 0]) {
				polyhole(m3_diameter,20);
				cylinder(h = 7, r=m3_nut_diameter/2, $fn=6, center=false);
			}

			rotate(a=[0,0,20]) mountingholes();
			rotate(a=[0,0,-20]) mountingholes();
			rotate(a=[0,0,0]) mountingholes();


		}
	}
}
holder();

