//    ccs_dl0001_enc_top_common.scad
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

include <ccs_dl0001_enc_consts.scad>

module pi_top_box() {
    difference() {
     
        // outer_box
        roundedBox(size=[PI_OUTER_LENGTH,PI_OUTER_WIDTH,BOTTOM_WALL_HEIGHT],radius=PI_OUTER_CORNER_RADIUS,sidesonly=true);

        // cut out
        translate([0,0,WALL_WIDTH]) {
            roundedBox(size=[PI_INNER_LENGTH,PI_INNER_WIDTH,BOTTOM_WALL_HEIGHT],radius=PI_INNER_CORNER_RADIUS,sidesonly=true);
        }  

    } // difference
}


module pi_top_box_with_pegholes() {
    union() {
        translate([0,0,0.5*BOTTOM_WALL_HEIGHT]) {
            pi_top_box();
        }

        delta_x = 0.5 * PI_HOLE_CENTERS_LONG_AXIS;
        delta_y = 0.5 * PI_HOLE_CENTERS_SHORT_AXIS;

        translate([-delta_x,-delta_y,0]) {
            standoff_with_peghole(STANDOFF_HEIGHT,STANDOFF_RADIUS,PI_PEGHOLE_HEIGHT,PI_PEGHOLE_OUTER_RADIUS,PI_PEGHOLE_INNER_RADIUS);
        } 
        translate([delta_x,-delta_y,0]) {
            standoff_with_peghole(STANDOFF_HEIGHT,STANDOFF_RADIUS,PI_PEGHOLE_HEIGHT,PI_PEGHOLE_OUTER_RADIUS,PI_PEGHOLE_INNER_RADIUS);
        } 
        translate([-delta_x,delta_y,0]) {
            standoff_with_peghole(STANDOFF_HEIGHT,STANDOFF_RADIUS,PI_PEGHOLE_HEIGHT,PI_PEGHOLE_OUTER_RADIUS,PI_PEGHOLE_INNER_RADIUS);
        } 
        translate([delta_x,delta_y,0]) {
            standoff_with_peghole(STANDOFF_HEIGHT,STANDOFF_RADIUS,PI_PEGHOLE_HEIGHT,PI_PEGHOLE_OUTER_RADIUS,PI_PEGHOLE_INNER_RADIUS);
        } 
    }
}

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
        hdmi_shift = 0.785*PI_OUTER_LENGTH;
        translate([0.5*PI_OUTER_LENGTH-hdmi_shift,0.5*(PI_OUTER_WIDTH-0.05*PI_OUTER_WIDTH)+0.1,TOP_WALL_HEIGHT]) {
            cube([0.35*PI_OUTER_WIDTH,WALL_WIDTH+0.2,0.5*BOTTOM_WALL_HEIGHT+0.2],center=true);
        }

        // Micro USB 2 cutout 
        usb2_shift = 0.37*PI_OUTER_LENGTH;
        translate([0.5*PI_OUTER_LENGTH-usb2_shift,0.5*(PI_OUTER_WIDTH-0.05*PI_OUTER_WIDTH)+0.1,BOTTOM_WALL_HEIGHT]) {
            cube([0.25*PI_OUTER_WIDTH,WALL_WIDTH+0.2,0.5*BOTTOM_WALL_HEIGHT+0.2],center=true);
        }

        // Micro USB 1 cutout 
        usb1_shift = 0.19*PI_OUTER_LENGTH;
        translate([0.5*PI_OUTER_LENGTH-usb1_shift,0.5*(PI_OUTER_WIDTH-0.05*PI_OUTER_WIDTH)+0.1,TOP_WALL_HEIGHT]) {
            cube([0.25*PI_OUTER_WIDTH,WALL_WIDTH+0.2,0.5*BOTTOM_WALL_HEIGHT+0.2],center=true);
        }

    }
}

///////////////////////////////////////////////////////////////////////////////

module bme280_top_box() {

    difference() {
     
        // outer_box
        roundedBox(size=[BME280_OUTER_LENGTH,BME280_OUTER_WIDTH,TOP_WALL_HEIGHT],radius=BME280_OUTER_CORNER_RADIUS,sidesonly=true);

        // cut out
        translate([0,0,WALL_WIDTH]) {
            roundedBox(size=[BME280_INNER_LENGTH,BME280_INNER_WIDTH,TOP_WALL_HEIGHT],radius=BME280_INNER_CORNER_RADIUS,sidesonly=true);
        }  

    } // difference
}


module bme280_top_box_with_pegholes(include_end_pegs) {
    union() {
        translate([0,0,0.5*TOP_WALL_HEIGHT]) {
            bme280_top_box();
        }

        delta_x = 0.5 * BME280_HOLE_CENTERS_LONG_AXIS;
        delta_y = 0.5 * BME280_HOLE_CENTERS_SHORT_AXIS;

        if (include_end_pegs) {
            translate([-delta_x,-delta_y,0]) {
                standoff_with_peghole(STANDOFF_HEIGHT,STANDOFF_RADIUS,BME280_PEGHOLE_HEIGHT,BME280_PEGHOLE_OUTER_RADIUS,BME280_PEGHOLE_INNER_RADIUS);
            }

            translate([delta_x,-delta_y,0]) {
                standoff_with_peghole(STANDOFF_HEIGHT,STANDOFF_RADIUS,BME280_PEGHOLE_HEIGHT,BME280_PEGHOLE_OUTER_RADIUS,BME280_PEGHOLE_INNER_RADIUS);
            }
        }

        translate([-delta_x,delta_y,0]) {
            standoff_with_peghole(STANDOFF_HEIGHT,STANDOFF_RADIUS,BME280_PEGHOLE_HEIGHT,BME280_PEGHOLE_OUTER_RADIUS,BME280_PEGHOLE_INNER_RADIUS);
        }
 
        translate([delta_x,delta_y,0]) {
            standoff_with_peghole(STANDOFF_HEIGHT,STANDOFF_RADIUS,BME280_PEGHOLE_HEIGHT,BME280_PEGHOLE_OUTER_RADIUS,BME280_PEGHOLE_INNER_RADIUS);
        } 
    }
}

module bme280_top_box_with_pegholes_and_cutouts(include_end_pegs) {
    difference() {
        bme280_top_box_with_pegholes(include_end_pegs);

        // Hole for Qwiic connect
        translate([0.5*BME280_OUTER_LENGTH-(0.5*WALL_WIDTH),0,TOP_WALL_HEIGHT]) {
            rotate([0,0,90]) {
                cube([0.25*BME280_OUTER_WIDTH,WALL_WIDTH+0.2,0.5*TOP_WALL_HEIGHT+0.2],center=true);
            }
        }

        // Hole for Qwiic connect
        translate([-0.5*BME280_OUTER_LENGTH+(0.5*WALL_WIDTH),0,TOP_WALL_HEIGHT]) {
            rotate([0,0,90]) {
                cube([0.25*BME280_OUTER_WIDTH,WALL_WIDTH+0.2,0.5*TOP_WALL_HEIGHT+0.2],center=true);
            }
        }
    }
}

