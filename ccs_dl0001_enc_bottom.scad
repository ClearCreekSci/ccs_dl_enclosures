use <MCAD/boxes.scad>
use <MCAD/regular_shapes.scad>

include <ccs_dl0001_enc_bottom_common.scad
$fa=1;
$fs=0.4;


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


bottom_box();


