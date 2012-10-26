/* Brix' Extruder Fan Mount, part of http://www.thingiverse.com/thing:19076
 *
 * A 40x40 mm fan mount for the Prusa V2 X-carriage.
 *
 * Copyright (c) 2012  Henrik Brix Andersen <henrik@brixandersen.dk>
 * License: CC BY-SA
 */

// Rendering
//$fn = 100;
$fs=0.5;
$fa=5;

fan_dia = 47;
length = 50;
screw_dia = 3;
nut_dia = 5.5;
nut_thickness = 2.5;

module fan_mount(panel_thickness, mounting_hole_distance) {

	module nuttrap(nutsize, length) {
		cylinder(r = nutsize / cos(180 / 6) / 2 + 0.05, length, $fn=6);
	}

	union() {
		difference() {
			union() {
				// Outer frame
				hull() {
					for (i = [1, -1]) {
						for (j = [1, -1]) {
							translate([i * fan_dia / 2 - i * fan_dia / 10,
									   j * fan_dia / 2 - j * fan_dia / 10, 0]) {
								rotate([0, 0, 90]) {
									cylinder(r = fan_dia / 10, panel_thickness);
								}
							}
						}
					}
				}

				// Nut trap outlines
				* for (i = [1, -1]) {
					for (j = [1, -1]) {
						translate([i * fan_dia / 2 - i * fan_dia / 10,
								   j * fan_dia / 2 - j * fan_dia / 10, 0]) {
							rotate([0, 0, 90]) {
								cylinder(r = fan_dia / 10, panel_thickness + nut_thickness);
							}
						}
					}
				}

				// Funnel
				cylinder(r1 = fan_dia / 2, r2 = fan_dia / 2.625, h = length);

				// Mounting bracket
				
			}

			// Screw holes
			for (i = [1, -1]) {
				for (j = [1, -1]) {
					translate([i * fan_dia / 2 - i * fan_dia / 10,
							   j * fan_dia / 2 - j * fan_dia / 10,
							 -panel_thickness]) {
						rotate([0, 0, 90]) {
							cylinder(r = screw_dia / 2, panel_thickness * 2 + nut_thickness * 2);
						}
					}
				}
			}

			// Nut traps
			* for (i = [1, -1]) {
				for (j = [1, -1]) {
					translate([i * fan_dia / 2 - i * fan_dia / 10,
							   j * fan_dia / 2 - j * fan_dia / 10,
							   panel_thickness]) {
						rotate([0, 0, i * j * 15]) {
							nuttrap(nut_dia, nut_thickness * 2);
						}
					}
				}
			}
	
			// Funnel cut-out
			translate([0, 0, -0.5]) {
				cylinder(r1 = fan_dia / 2 - panel_thickness, r2 = fan_dia / 2.625 - panel_thickness, h = 61);
			}


			// Funnel cut-off
			rotate([0, -65, 0]) {
				translate([fan_dia / 2 - 5, 0, fan_dia]) {
					cube([fan_dia+45, fan_dia, fan_dia], center = true);
				}
			}



		}


		// Bed and extruder mock-up
		*translate([38.5, 0, 43]) {
			rotate([0, -65, 0]) {
				cube([37 + 10, 10, 10], center = true);
				translate([37 / 2, 0, 37 / 2]) {
					cube([10, 10, 37 + 10], center = true);
				}
				translate([0, 0, 43]) {
					cube([100, 100, 2], center = true);
				}
			}
		}

		// Funnel bottom close-off (Still need hacking when changing sizes)
		rotate([0, -65, 0]) {
			translate([fan_dia / 2 - 9.6, 0, fan_dia/2-1]) {
				cube([fan_dia/2, fan_dia-29.8, 2], center = true);
			}
			translate([fan_dia / 2 - 5 +6, 0, fan_dia/2-1]) {
				cube([fan_dia - 14, fan_dia-22.9, 2], center = true);
			}
			translate([fan_dia / 2 - 5 + 9-0.3, 0, fan_dia/2-1]) {
			 cube([fan_dia - 22, fan_dia-18.1, 2], center = true);
			}
			translate([fan_dia / 2 - 5 + 19-5, 0, fan_dia/2-1]) {
				cube([fan_dia - 24.5, fan_dia-14.9, 2], center = true);
			}
			translate([fan_dia / 2 - 5 + 19, 0, fan_dia/2-1]) {
				cube([fan_dia - 34, fan_dia-12.5, 2], center = true);
			}

		}
	}
}

module mountEar(mountHeight = 10){
	rotate([0,90,0])
		 difference(){
			union(){
			 cylinder(r=5, h=3.5-wiggle, center=true);
			 translate([mountHeight/2,0,0])
			 cube([mountHeight, 10, 3.5-wiggle], center=true);
			}
			cylinder(r=1.5+wiggle, h=3.5, center=true);
		 }	// end diff
}


// Prusa mounting bits
module prusaMountEar(height){
	difference(){
	 hull(){
	  translate([0,-15,0])
	   cube([16.2, 2, height], center=true);
	   cylinder(r=19.2/2, h=height, center=true);
	  }
	 // drill holes
	 cylinder(r=3/2, h=height*2, center=true);
      }
}

module prusaMountEars(height){
	for (i=[-1,1]){
	 translate([i*11, 0, 0 ])
	 prusaMountEar(height);
 	}
}

// This part goes on the fan
module fanMountingBracket(mountHeight = 10, mountSpacing = 2){
	union(){
		// bottom
		cube([10,10,2], center=true);
		// 2x mount ears
		for (i = [1,-1]){
		 translate([i*mountSpacing,0,mountHeight])
		 mountEar(mountHeight);
		} // end for
	}	// end union
} // end module

// This part goes on the carriage, mates the fan to the prusaMountingEars
module carriageMountingBracket(mountHeight = 10, mountSpacing = 2){		
 difference(){	
  union(){	   		
	// mount plate
	hull(){
	// outer diameters of drill holes	
	  for (i = [1,-1]){	
		translate([i*19, 8, 4])
		 cylinder(r=4+wiggle, h=2, center=true);
	  } 
	// stuck onto a plate for mounting ears 	
	  rotate([90,0,0])
	  cube([16,10,4], center=true);
	}	   

	rotate([90,0,0])
	// 3x mount ears
	union(){
		for (i = [2,0,-2]){
		 translate([i*mountSpacing, 0, mountHeight])
		 mountEar(mountHeight);
		} // end for
	}
  }
	// Through holes, space for prusa mounts
	for (i = [1,-1]){	
		translate([i*19, 8, 0 ])
		  cylinder(r=1.5+wiggle, h=25, center=true);
		translate([i*19, 8, -7])
		  rotate([0,0,180])
		  prusaMountEar(20);
	} // end for 	

 } // end top-level difference
}

// STL Creation / mockup mode options
printPart = "fan";
// values "fan", "mount", "mockup"

wiggle=0.6; // values 0.1 - 0.2 seem about right.  

if (printPart == "fan" || printPart=="mockup"){
color("IndianRed")
 union(){
	fan_mount(2, 22);
	translate([fan_dia/2.1,0,5])
	rotate([90,0,90])
	fanMountingBracket(10,3.2);	
 }
//translate([24.5, 0, 0.1]) cube(size=[11, 8, 0.2], center=true);
}

if (printPart == "mockup"){ 
  translate([37,0,21.0])
  rotate([-65, 0, -270])
  color("steelBlue")
  prusaMountEars(5);

  translate([fan_dia/2.1+14,0,14])
  rotate([65,0,-90])
  color("oliveDrab") carriageMountingBracket(10, 3.2);

	translate([0,15,0])#cube(size=[37,2,2], center=true);
}

if (printPart == "mount"){
 translate([0,8,0])
 rotate([180,0,0])
 color("oliveDrab") carriageMountingBracket(10, 3.2);
//translate([0, 14, -4.9]) cube(size=[12, 10.4, 0.2], center=true);
}
