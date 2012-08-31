
numpoints = 16;
numwings = 2;

difference() {
	union() {
		intersection_for(n = [1 : numpoints])
		{
				rotate([0, 0, n * 360/numpoints])
				{
				    translate([12,0,0])
				    sphere(r=28);
				}
		}
//#		translate(v = [0, 0, 17/2]) cylinder(h = 17, r = 14/2, $fn = 13, center = true);

	}

	union() {
		// Make it hollow
		translate(v = [0, 0, -3]) 
		intersection_for(n = [1 : numpoints])
		{
				rotate([0, 0, n * 360/numpoints])
				{
				    translate([17,0,0])
				    sphere(r=32);
				}
		}
		
		// Cut away bottom half
		translate(v = [0, 0, -20]) 
		cube(size = [40,40,40], center = true);

		// Wing cutouts
		for(i=[0:numwings]) {
		 rotate(360*i/numwings) {
				translate(v = [0, -5, 0])
				rotate([90, -60, 0])
				cylinder(h = 20, r = 10, $fn = 3);
		 }
		}

		// Cross section view
		//translate(v = [0, 0, -10]) cube(size = [40,40,40]);
	}
}

