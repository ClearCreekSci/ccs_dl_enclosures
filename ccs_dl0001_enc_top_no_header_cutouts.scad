//    ccs_dl0001_enc_top_no_header_cutouts.scad
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


module pi_top_box_with_pegholes_and_cutouts() {
    difference() {
        pi_top_box_with_pegholes();
      
        // SD card cutout 
        translate([-(0.5*PI_OUTER_LENGTH-0.5*WALL_WIDTH),-0.05*PI_OUTER_WIDTH,TOP_WALL_HEIGHT]) {
            rotate([0,0,90]) {
                cube([0.35*PI_OUTER_WIDTH,WALL_WIDTH+0.2,0.5*TOP_WALL_HEIGHT+0.2],center=true);
            }
        }
         
        // Mini HDMI cutout 
        hdmi_shift = 0.20*PI_OUTER_LENGTH;
        translate([-(0.5*PI_OUTER_LENGTH-hdmi_shift+1),0.5*(PI_OUTER_WIDTH-0.05*PI_OUTER_WIDTH)+0.1,TOP_WALL_HEIGHT]) {
            cube([0.40*PI_OUTER_WIDTH,WALL_WIDTH+0.2,0.5*BOTTOM_WALL_HEIGHT+0.2],center=true);
        }

        // Micro USB 1 cutout 
        usb1_shift = 0.20*PI_OUTER_LENGTH;
        translate([0.5*PI_OUTER_LENGTH-usb1_shift,0.5*(PI_OUTER_WIDTH-0.05*PI_OUTER_WIDTH)+0.1,TOP_WALL_HEIGHT]) {
            cube([0.30*PI_OUTER_WIDTH,WALL_WIDTH+0.2,0.5*BOTTOM_WALL_HEIGHT+0.2],center=true);
        }

        // Micro USB 2 cutout 
        usb2_shift = 0.40*PI_OUTER_LENGTH;
        translate([0.5*PI_OUTER_LENGTH-usb2_shift,0.5*(PI_OUTER_WIDTH-0.05*PI_OUTER_WIDTH)+0.1,BOTTOM_WALL_HEIGHT]) {
            cube([0.30*PI_OUTER_WIDTH,WALL_WIDTH+0.2,0.5*BOTTOM_WALL_HEIGHT+0.2],center=true);
        }

        // Ventilation holes
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

        for (dx=[-(PI_INNER_LENGTH/2-3*VHOLE_RADIUS):2.5*VHOLE_RADIUS:PI_INNER_LENGTH/2-2*VHOLE_RADIUS]) {
            translate([dx,-4*VHOLE_RADIUS,-VHOLE_OVERLAP]) {
                rotate([0,0,30]) {
                    hexagonal_prism(VHOLE_HEIGHT,VHOLE_RADIUS);
                }
            }
        }
   
    }
}

module pi_top_box_complete() {
    difference() {
        pi_top_box_with_pegholes_and_cutouts(); 

        translate([-0.5*(PI_HOLE_CENTERS_LONG_AXIS-7),-0.5*(PI_HOLE_CENTERS_SHORT_AXIS-6),0.5]) {
            rotate([0,180,90]) {
                linear_extrude(1) {
                    text("1",2);
                }
            }
        }

    }
}

module bme280_top_box_with_pegholes_and_cutouts() {
    difference() {
        bme280_top_box_with_pegholes();

        translate([0.5*BME280_OUTER_LENGTH-(0.5*WALL_WIDTH),0,TOP_WALL_HEIGHT]) {
            rotate([0,0,90]) {
                cube([0.25*BME280_OUTER_WIDTH,WALL_WIDTH+0.2,0.5*TOP_WALL_HEIGHT+0.2],center=true);
            }
        }

        translate([-0.5*BME280_OUTER_LENGTH+(0.5*WALL_WIDTH),0,TOP_WALL_HEIGHT]) {
            rotate([0,0,90]) {
                cube([0.25*BME280_OUTER_WIDTH,WALL_WIDTH+0.2,0.5*TOP_WALL_HEIGHT+0.2],center=true);
            }
        }

        // Make some holes for ventilation

        for (dx=[-(BME280_INNER_LENGTH/2-6*VHOLE_RADIUS):2.5*VHOLE_RADIUS:BME280_INNER_LENGTH/2-5*VHOLE_RADIUS]) {
            translate([dx,0,-VHOLE_OVERLAP]) {
                rotate([0,0,30]) {
                    hexagonal_prism(VHOLE_HEIGHT,VHOLE_RADIUS);
                }
            }
        }

        for (dx=[-(BME280_INNER_LENGTH/2-7*VHOLE_RADIUS):2.5*VHOLE_RADIUS:BME280_INNER_LENGTH/2-7*VHOLE_RADIUS]) {
            translate([dx,2*VHOLE_RADIUS,-VHOLE_OVERLAP]) {
                rotate([0,0,-30]) {
                    hexagonal_prism(VHOLE_HEIGHT,VHOLE_RADIUS);
                }
            }
        }

        for (dx=[-(BME280_INNER_LENGTH/2-7*VHOLE_RADIUS):2.5*VHOLE_RADIUS:BME280_INNER_LENGTH/2-7*VHOLE_RADIUS]) {
            translate([dx,-2*VHOLE_RADIUS,-VHOLE_OVERLAP]) {
                rotate([0,0,-30]) {
                    hexagonal_prism(VHOLE_HEIGHT,VHOLE_RADIUS);
                }
            }
        }

        for (dx=[-(BME280_INNER_LENGTH/2-8*VHOLE_RADIUS):2.5*VHOLE_RADIUS:BME280_INNER_LENGTH/2-7*VHOLE_RADIUS]) {
            translate([dx,-4*VHOLE_RADIUS,-VHOLE_OVERLAP]) {
                rotate([0,0,30]) {
                    hexagonal_prism(VHOLE_HEIGHT,VHOLE_RADIUS);
                }
            }
        }

        for (dx=[-(BME280_INNER_LENGTH/2-8*VHOLE_RADIUS):2.5*VHOLE_RADIUS:BME280_INNER_LENGTH/2-7*VHOLE_RADIUS]) {
            translate([dx,4*VHOLE_RADIUS,-VHOLE_OVERLAP]) {
                rotate([0,0,30]) {
                    hexagonal_prism(VHOLE_HEIGHT,VHOLE_RADIUS);
                }
            }
        }
    }
}

module top_box() {
    union() {

        pi_top_box_complete();

        t = 0.5*PI_OUTER_LENGTH + 0.5*BME280_OUTER_WIDTH - WALL_WIDTH;
        translate([t,0,0]) {
            rotate([0,0,90]) {
                bme280_top_box_with_pegholes_and_cutouts();
            }
        }

        // Close the gap in the wall between the two...
        translate([0.5*PI_OUTER_LENGTH,0.5*PI_OUTER_WIDTH-0.5*WALL_WIDTH,0.5*TOP_WALL_HEIGHT]) {
            cube([10,WALL_WIDTH,TOP_WALL_HEIGHT],center=true);
        }

        translate([0.5*PI_OUTER_LENGTH,-(0.5*PI_OUTER_WIDTH-0.5*WALL_WIDTH),0.5*TOP_WALL_HEIGHT]) {
            cube([10,WALL_WIDTH,TOP_WALL_HEIGHT],center=true);
        }
    }
}

module top_box_with_via() {

    difference() {
        top_box();

        // Internal via between the two boards
        translate([0.5*PI_INNER_LENGTH+0.5*WALL_WIDTH,-0.15*PI_INNER_WIDTH,BOTTOM_WALL_HEIGHT]) {
            cube([WALL_WIDTH+0.2,5.2,BOTTOM_WALL_HEIGHT+0.2],center=true);
        }
    }
}

top_box_with_via();


