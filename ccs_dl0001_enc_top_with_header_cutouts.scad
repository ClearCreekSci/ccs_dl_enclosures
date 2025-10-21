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
        pi_top_box_with_pegholes_and_cutouts();

        translate([0,-0.5*PI_HOLE_CENTERS_SHORT_AXIS,BOTTOM_WALL_HEIGHT-(0.5*BOTTOM_WALL_HEIGHT)]) {
            cube([PI_HOLE_CENTERS_LONG_AXIS-6,7,BOTTOM_WALL_HEIGHT+0.2],center=true); 
        }
    }
}

module pi_top_box_complete() {
    difference() {
        pi_top_box_with_header_cutout();
        // pi_top_box_with_pegholes_and_cutouts(); 

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
        for (dx=[-(BME280_INNER_LENGTH/2-5*VHOLE_RADIUS):2.5*VHOLE_RADIUS:BME280_INNER_LENGTH/2-5*VHOLE_RADIUS]) {
            translate([dx,0,-VHOLE_OVERLAP]) {
                rotate([0,0,30]) {
                    hexagonal_prism(VHOLE_HEIGHT,VHOLE_RADIUS);
                }
            }
        }

        for (dx=[-(BME280_INNER_LENGTH/2-6*VHOLE_RADIUS):2.5*VHOLE_RADIUS:BME280_INNER_LENGTH/2-6*VHOLE_RADIUS]) {
            translate([dx,2*VHOLE_RADIUS,-VHOLE_OVERLAP]) {
                rotate([0,0,-30]) {
                    hexagonal_prism(VHOLE_HEIGHT,VHOLE_RADIUS);
                }
            }
        }

        for (dx=[-(BME280_INNER_LENGTH/2-6*VHOLE_RADIUS):2.5*VHOLE_RADIUS:BME280_INNER_LENGTH/2-6*VHOLE_RADIUS]) {
            translate([dx,-2*VHOLE_RADIUS,-VHOLE_OVERLAP]) {
                rotate([0,0,-30]) {
                    hexagonal_prism(VHOLE_HEIGHT,VHOLE_RADIUS);
                }
            }
        }
    }
}

module bme280_top_box_with_header_cutout() {

    difference() {
        bme280_top_box_with_pegholes_and_cutouts();

        translate([0,-0.5*BME280_HOLE_CENTERS_SHORT_AXIS-1,BOTTOM_WALL_HEIGHT-(0.5*BOTTOM_WALL_HEIGHT)]) {
            cube([BME280_HOLE_CENTERS_LONG_AXIS-4.5,4,BOTTOM_WALL_HEIGHT+0.2],center=true); 
        }
    }
}

module top_box() {
    union() {

        pi_top_box_complete();

        t = 0.5*PI_OUTER_LENGTH + 0.5*BME280_OUTER_WIDTH - WALL_WIDTH;
        translate([t,0,0]) {
            rotate([0,0,90]) {
                bme280_top_box_with_header_cutout();
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



top_box();


