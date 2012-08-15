SRC=$(shell echo *.scad)

.SUFFIXES: .stl .scad

.scad.stl: ; openscad -o stl/$@ $<

STL_GEN=$(SRC:.scad=.stl)

stl: $(STL_GEN)

clean:
	rm stl/*.stl

