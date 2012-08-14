// Bushing types
bushing_type = 1; // old style

m3_diameter = 3.6;
m3_nut_diameter = 5.3;
m4_nut_diameter = 4.5; 

// Extruder position
E_pos = [0, -6, 0];

// Based on nophead research
module polyhole(d,h) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
}

module mountingholes(){
	translate(v = [0, -25, -1]) polyhole(m3_diameter,10);
	translate(v = [0, -25, 4]) cylinder(h = 10, r=m3_nut_diameter/2, $fn=6, center=false);
	//translate(v = [0, -25, 5]) cylinder(h = 9, r=m4_nut_diameter/2, $fn=6, center=true);		
	translate(v = [0, 25, -1]) polyhole(m3_diameter,10);
	translate(v = [0, 25, 4]) cylinder(h = 10, r=m3_nut_diameter/2, $fn=6, center=false);
	//translate(v = [0, 25, 5]) cylinder(h = 9, r=4.5, $fn=6, center=true);
}

module mountingholes_extra(){
	translate(v = [0, -25, 0]) cylinder(h = 7, r=m3_nut_diameter, $fn=6, center=false);
	translate(v = [0, 25, 0]) cylinder(h = 7, r=m3_nut_diameter, $fn=6, center=false);
}

module old_style_bushing() {
	difference() {
		translate(v = [0,0,7.5])cube(size = [26,10,15], center = true);
		translate(v = [0,0,10.6])cube(size = [18,11,9], center = true);
	}
}

module xcarriage() {

difference(){
	union(){
		//Base block
		translate(v = [0,0,2.5])cube(size = [70,70,5], center = true);

		//Bushing
		translate(v = [-25, 30, 0])old_style_bushing();
		translate(v = [-25, -30, 0])old_style_bushing();
		translate(v = [25, -30, 0])old_style_bushing();
		translate(v = [25, 30, 0])old_style_bushing();

		//Belt clamp arms
		translate(v = [33-(7.5/2), -18, 2.5]) cube(size = [45-7.5,15,5], center = true);
		translate(v = [33+45/2-7.5, -18, 2.5]) cylinder(h = 5, r=7.5, $fn=18, center=true);
		translate(v = [33-(7.5/2), 18, 2.5]) cube(size = [45-7.5,15,5], center = true);
		translate(v = [33+45/2-7.5, 18, 2.5]) cylinder(h = 5, r=7.5, $fn=18, center=true);

		//Belt clamp holes extrusion hex
		translate(v = [30, -18, 3.5]) cylinder(h = 7, r=m3_nut_diameter, $fn=6, center=true);
		translate(v = [48, -18, 3.5]) cylinder(h = 7, r=m3_nut_diameter, $fn=6, center=true);
		translate(v = [30, 18, 3.5]) cylinder(h = 7, r=m3_nut_diameter, $fn=6, center=true);
		translate(v = [48, 18, 3.5]) cylinder(h = 7, r=m3_nut_diameter, $fn=6, center=true);

		//Extra material for mounting holes  //TODO, theese elements should be hull()'ed in each end
		translate(v = E_pos){
			rotate(a=[0,0,20]) mountingholes_extra();
			rotate(a=[0,0,-20]) mountingholes_extra();
			rotate(a=[0,0,0]) mountingholes_extra();
		}

		//Niceties
		translate(v = [0, -26, 0]) cylinder(h = 5, r=15, $fn=6, center=false);
	}
	union(){
		//Hotend hole and mounting holes
		translate(v = E_pos){
			//Hotend hole
			cylinder(h = 20, r=20, $fn=18, center=true);
			translate(v = [-12, 0, -1]) rotate(a=[0,0,30]) cylinder(h = 7, r=12, $fn=6, center=false);
			//Extruder mounting holes
			rotate(a=[0,0,22]) mountingholes();
			rotate(a=[0,0,-22]) mountingholes();
			rotate(a=[0,0,0]) mountingholes();
		}

		//Belt clamp holes intrusion hex and hole
		translate(v = [30, -18, 2]) cylinder(h = 10, r=m3_diameter/2, $fn=9, center=true);
		translate(v = [30, -18, 9]) cylinder(h = 10, r=m3_nut_diameter/2, $fn=6, center=true);
		translate(v = [48, -18, 2]) cylinder(h = 10, r=m3_diameter/2, $fn=9, center=true);
		translate(v = [48, -18, 9]) cylinder(h = 10, r=m3_nut_diameter/2, $fn=6, center=true);
		translate(v = [30, 18, 2]) cylinder(h = 10, r=m3_diameter/2, $fn=9, center=true);
		translate(v = [30, 18, 9]) cylinder(h = 10, r=m3_nut_diameter/2, $fn=6, center=true);
		translate(v = [48, 18, 2]) cylinder(h = 10, r=m3_diameter/2, $fn=9, center=true);
		translate(v = [48, 18, 9]) cylinder(h = 10, r=m3_nut_diameter/2, $fn=6, center=true);
	


		//Niceties
		translate(v = [0, 40, -1]) cylinder(h = 7, r=15, $fn=6, center=false);
		}
	}
}

xcarriage();
