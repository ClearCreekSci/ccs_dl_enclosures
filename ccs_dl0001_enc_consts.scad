//    ccs_dl0001_enc_consts.scad
//    OpenSCAD model for the CCS Data Logger enclosure
//
//    Copyright (C) 2025 Clear Creek Scientific
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <https://www.gnu.org/licenses/>.

// X-axis is long axis
// Y-axis is short axis 

// Raspberry Pi Measurements:
// Hole centers on the long axis: 57.4 mm
// Hole centers on the short axis: 22.65 mm
//
//

WALL_WIDTH = 1.5;
BOTTOM_WALL_HEIGHT = 6; 
TOP_WALL_HEIGHT = 6; 

STANDOFF_HEIGHT = 0.5*BOTTOM_WALL_HEIGHT;
STANDOFF_RADIUS = 2;

// For some reason, this overlap has to include the entire wall height, otherwise
// the holes don't show up. 
VHOLE_OVERLAP = 0.5 * BOTTOM_WALL_HEIGHT + 0.1;
VHOLE_RADIUS = 1.5;
VHOLE_HEIGHT = WALL_WIDTH+2*(VHOLE_OVERLAP);


PI_PEG_HEIGHT = 5;
PI_PEGHOLE_HEIGHT = 7;
PI_PEG_RADIUS = 1.1;
PI_PEGHOLE_INNER_RADIUS = 1.3;
PI_PEGHOLE_OUTER_RADIUS = 2.2;
PI_HOLE_CENTERS_LONG_AXIS = 57.4;
PI_HOLE_CENTERS_SHORT_AXIS = 22.65;
// These hole measurements are not accurate, but don't change the total distance, because
// it seems to work correct
PI_HOLE_RADIUS = 0.75; 
PI_HOLE_PERIMETER = 1.25;
PI_GAP_WIDTH = 3;
PI_INNER_LENGTH = PI_HOLE_CENTERS_LONG_AXIS + 2*PI_HOLE_RADIUS + 2*PI_HOLE_PERIMETER + 2*PI_GAP_WIDTH;
PI_OUTER_LENGTH = PI_INNER_LENGTH + 2*WALL_WIDTH;
PI_INNER_WIDTH = PI_HOLE_CENTERS_SHORT_AXIS + 2*PI_HOLE_RADIUS + 2*PI_HOLE_PERIMETER + 2*PI_GAP_WIDTH;
PI_OUTER_WIDTH = PI_INNER_WIDTH + 2*WALL_WIDTH;
PI_OUTER_CORNER_RADIUS = 4; 
PI_INNER_CORNER_RADIUS = 3; 

BME280_HOLE_CENTERS_LONG_AXIS = 19.80;
BME280_HOLE_CENTERS_SHORT_AXIS = 11.80;
// These hole measurements are not accurate, but don't change the total distance, because
// it seems to work 
BME280_HOLE_RADIUS = 0.75; 
BME280_HOLE_PERIMETER = 1.25;

BME280_PEG_HEIGHT = 4;
BME280_PEGHOLE_HEIGHT = 8;
BME280_PEG_RADIUS = 0.80;
BME280_PEGHOLE_INNER_RADIUS = 0.82;
BME280_PEGHOLE_OUTER_RADIUS = 1.5;
BME280_GAP_WIDTH_LONG_AXIS = 0.5 * (PI_INNER_WIDTH - (BME280_HOLE_CENTERS_LONG_AXIS + 2*BME280_HOLE_RADIUS + 2*BME280_HOLE_PERIMETER)); 
BME280_GAP_WIDTH_SHORT_AXIS = 3; 
BME280_INNER_LENGTH = BME280_HOLE_CENTERS_LONG_AXIS + 2*BME280_HOLE_RADIUS + 2*BME280_HOLE_PERIMETER + 2*BME280_GAP_WIDTH_LONG_AXIS;
BME280_OUTER_LENGTH = BME280_INNER_LENGTH + 2*WALL_WIDTH;
BME280_INNER_WIDTH = BME280_HOLE_CENTERS_SHORT_AXIS + 2*BME280_HOLE_RADIUS + 2*BME280_HOLE_PERIMETER + 2*BME280_GAP_WIDTH_SHORT_AXIS;
BME280_OUTER_WIDTH = BME280_INNER_WIDTH + 2*WALL_WIDTH;

BME280_OUTER_CORNER_RADIUS = 4; 
BME280_INNER_CORNER_RADIUS = 3; 


module my_hexagon(radius)
{ 
  regular_polygon(6,radius);
}
  
module hexagonal_prism(height,radius)
{ 
  linear_extrude(height=height) my_hexagon(radius);
}


module peg(height,radius) {
    union() {
        translate([0,0,0.5*height]) {
            cylinder(h=height,r=radius,center=true);
        }
        translate([0,0,height]) {
            sphere(radius);
        }
    }
}

module peghole(height,outer_radius,inner_radius) {
    difference() {
        translate([0,0,0.5*height]) {
            cylinder(h=height,r=outer_radius,center=true);
        }
        translate([0,0,0.5*height]) {
            cylinder(h=height+0.1,r=inner_radius,center=true);
        }
    }
}

module standoff_with_peg(base_height,base_radius,peg_height,peg_radius) {
    union() {
        translate([0,0,0.5*base_height]) {
            cylinder(h=base_height,r=base_radius,center=true);
        }
        peg(peg_height,peg_radius);
    }
}

module standoff_with_peghole(base_height,base_radius,peg_height,peg_outer_radius,peg_inner_radius) {
    union() {
        translate([0,0,0.5*base_height]) {
            cylinder(h=base_height,r=base_radius,center=true);
        }
        peghole(peg_height,peg_outer_radius,peg_inner_radius);
    }
}

