//    ccs_dl0001_enc_bottom_with_feet.scad
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

include <ccs_dl0001_enc_bottom_common.scad>
$fa=1;
$fs=0.4;

module foot(length,width,corner_radius,hole_radius) {
    difference() {
        roundedBox(size=[length+0.2,width+0.2,WALL_WIDTH],radius=corner_radius,sidesonly=true);

        // hole
        translate([corner_radius,0,0]) {
            cylinder(h=WALL_WIDTH+0.2,r=hole_radius,center=true);
        } 
    }
}


module bottom_box() {
    union() {

        pi_bottom_box_with_pegs_and_cutouts();

        t = 0.5*PI_OUTER_LENGTH + 0.5*BME280_OUTER_WIDTH - WALL_WIDTH;
        translate([t,0,0]) {
            rotate([0,0,90]) {
                bme280_bottom_box_with_pegs_and_cutouts();
            }
        }

        // Close the gap in the wall between the two...
        translate([0.5*PI_OUTER_LENGTH,0.5*PI_OUTER_WIDTH-0.5*WALL_WIDTH,0.5*BOTTOM_WALL_HEIGHT]) {
            cube([10,WALL_WIDTH,BOTTOM_WALL_HEIGHT],center=true);
        }

        translate([0.5*PI_OUTER_LENGTH,-(0.5*PI_OUTER_WIDTH-0.5*WALL_WIDTH),0.5*BOTTOM_WALL_HEIGHT]) {
            cube([10,WALL_WIDTH,BOTTOM_WALL_HEIGHT],center=true);
        }
    }
}

module bottom_box_with_feet() {
    union() {
        bottom_box();

        translate([-0.5*(PI_INNER_LENGTH)+7,0.5*PI_OUTER_WIDTH+2.5,0.5*WALL_WIDTH]) {
            rotate([0,0,90]) {
                foot(12,8,2,1.5);
            }
        }

        translate([0.5*(PI_INNER_LENGTH)+ 0.5 * BME280_OUTER_WIDTH+5,0.5*PI_OUTER_WIDTH+2.5,0.5*WALL_WIDTH]) {
            rotate([0,0,90]) {
                foot(12,8,2,1.5);
            }
        }

        translate([-0.5*(PI_INNER_LENGTH)+7,-0.5*PI_OUTER_WIDTH-2.5,0.5*WALL_WIDTH]) {
            rotate([0,0,-90]) {
                foot(12,8,2,1.5);
            }
        }

        translate([0.5*(PI_INNER_LENGTH)+ 0.5 * BME280_OUTER_WIDTH+5,-0.5*PI_OUTER_WIDTH-2.5,0.5*WALL_WIDTH]) {
            rotate([0,0,-90]) {
                foot(12,8,2,1.5);
            }
        }
    }
}

bottom_box_with_feet();


