//    ccs_dl0001_enc_top_with_header_cutouts.scad
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

use <MCAD/boxes.scad>
use <MCAD/regular_shapes.scad>
include <ccs_dl0001_enc_top_common.scad>

$fa=1;
$fs=0.4;


module pi_top_box_with_ventilation() {
    difference() {
        pi_top_box_with_pegholes_and_cutouts();
      
        // ventilation holes
        for (dx=[-(PI_INNER_LENGTH/2-3*VHOLE_RADIUS):2.5*VHOLE_RADIUS:PI_INNER_LENGTH/2-2*VHOLE_RADIUS]) {
            translate([dx,0,-VHOLE_OVERLAP]) {
                rotate([0,0,30]) {
                    hexagonal_prism(VHOLE_HEIGHT,VHOLE_RADIUS);
                }
            }
        }

        for (dx=[-(PI_INNER_LENGTH/2-4*VHOLE_RADIUS):2.5*VHOLE_RADIUS:PI_INNER_LENGTH/2-3*VHOLE_RADIUS]) {
            translate([dx,2*VHOLE_RADIUS,-VHOLE_OVERLAP]) {
                rotate([0,0,-30]) {
                    hexagonal_prism(VHOLE_HEIGHT,VHOLE_RADIUS);
                }
            }
        }

        for (dx=[-(PI_INNER_LENGTH/2-3*VHOLE_RADIUS):2.5*VHOLE_RADIUS:PI_INNER_LENGTH/2-2*VHOLE_RADIUS]) {
            translate([dx,4*VHOLE_RADIUS,-VHOLE_OVERLAP]) {
                rotate([0,0,30]) {
                    hexagonal_prism(VHOLE_HEIGHT,VHOLE_RADIUS);
                }
            }
        }
   
        for (dx=[-(PI_INNER_LENGTH/2-4*VHOLE_RADIUS):2.5*VHOLE_RADIUS:PI_INNER_LENGTH/2-3*VHOLE_RADIUS]) {
            translate([dx,-2*VHOLE_RADIUS,-VHOLE_OVERLAP]) {
                rotate([0,0,-30]) {
                    hexagonal_prism(VHOLE_HEIGHT,VHOLE_RADIUS);
                }
            }
        }

    }
}

module pi_top_box_with_header_cutout() {

    difference() {
        pi_top_box_with_ventilation();

        translate([0,-0.5*PI_HOLE_CENTERS_SHORT_AXIS,BOTTOM_WALL_HEIGHT-(0.5*BOTTOM_WALL_HEIGHT)]) {
            cube([PI_HOLE_CENTERS_LONG_AXIS-6,7,BOTTOM_WALL_HEIGHT+0.2],center=true); 
        }
    }
}

module pi_top_box_complete() {
    difference() {
        pi_top_box_with_header_cutout();

        translate([-0.5*(PI_HOLE_CENTERS_LONG_AXIS-7),-0.5*(PI_HOLE_CENTERS_SHORT_AXIS-6),0.5]) {
            rotate([0,180,90]) {
                linear_extrude(1) {
                    text("1",2);
                }
            }
        }
    }
}

///////////////////////////////////////////////////////////////////////////////

module bme280_top_box_with_ventilation() {
    difference() {
        bme280_top_box_with_pegholes_and_cutouts(false);

        // Make some holes for ventilation
        for (dx=[-(BME280_INNER_LENGTH/2-5*VHOLE_RADIUS):2.5*VHOLE_RADIUS:BME280_INNER_LENGTH/2-5*VHOLE_RADIUS]) {
            translate([dx,-1,-VHOLE_OVERLAP]) {
                rotate([0,0,30]) {
                    hexagonal_prism(VHOLE_HEIGHT,VHOLE_RADIUS);
                }
            }
        }

        for (dx=[-(BME280_INNER_LENGTH/2-6*VHOLE_RADIUS):2.5*VHOLE_RADIUS:BME280_INNER_LENGTH/2-4*VHOLE_RADIUS]) {
            translate([dx,2*VHOLE_RADIUS-1,-VHOLE_OVERLAP]) {
                rotate([0,0,-30]) {
                    hexagonal_prism(VHOLE_HEIGHT,VHOLE_RADIUS);
                }
            }
        }
    }
}

module bme280_top_box_with_header_cutout() {

    difference() {
        bme280_top_box_with_ventilation();

        translate([0,-0.5*BME280_HOLE_CENTERS_SHORT_AXIS-1,BOTTOM_WALL_HEIGHT-(0.5*BOTTOM_WALL_HEIGHT)]) {
            cube([BME280_HOLE_CENTERS_LONG_AXIS-1.0,4,BOTTOM_WALL_HEIGHT+0.2],center=true); 
        }
    }
}

///////////////////////////////////////////////////////////////////////////////

module top_box() {
    union() {

        pi_top_box_complete();

        t = 0.5*PI_OUTER_LENGTH + 0.5*BME280_OUTER_WIDTH - WALL_WIDTH;
        translate([t,0,0]) {
            rotate([0,0,90]) {
                bme280_top_box_with_header_cutout();
            }
        }

        // Close the gap in each wall with an extruded triangle
        translate([0.5*PI_OUTER_LENGTH-0.5*WALL_WIDTH,0.5*PI_OUTER_WIDTH-2.25,0]) {
            rotate([0,0,180]) {
                triangle_prism(TOP_WALL_HEIGHT,4.5);
            }
        }
 
        translate([0.5*PI_OUTER_LENGTH-0.5*WALL_WIDTH,-0.5*(PI_OUTER_WIDTH-4.5),0]) {
            triangle_prism(TOP_WALL_HEIGHT,4.5);
        }
    }
}


module top_box_with_screw_holes() {
    difference() {
        top_box();

        // Finally,  put a hole in each triangle for a screw
        translate([0.5*PI_OUTER_LENGTH-0.5*WALL_WIDTH,0.5*PI_OUTER_WIDTH-3.25,0.5*TOP_WALL_HEIGHT]) {
            cylinder(h=TOP_WALL_HEIGHT+WALL_WIDTH+0.2,r=1.1,center=true);
        }
         
        translate([0.5*PI_OUTER_LENGTH-0.5*WALL_WIDTH,-0.5*(PI_OUTER_WIDTH-6),0.5*TOP_WALL_HEIGHT]) {
            cylinder(h=TOP_WALL_HEIGHT+WALL_WIDTH+0.2,r=1.1,center=true);
        }
    }
}

top_box_with_screw_holes();


