
difference() {
	union() {
		cube(size = [20,48,15]);
	}

	union() {
		translate(v = [1,10,13])cube(size = [17,40,5]);
		translate(v = [1,3,1])cube(size = [17,17,2]);
		translate(v = [1,2,1])cube(size = [17,18,12]);
		translate(v = [2,-6,1])cube(size = [13,18,5]);
		translate(v = [1,10,3])cube(size = [17,20,12]);
	}
}
