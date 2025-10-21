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


module bme280_top_box_with_pegholes() {
    union() {
        translate([0,0,0.5*TOP_WALL_HEIGHT]) {
            bme280_top_box();
        }

        delta_x = 0.5 * BME280_HOLE_CENTERS_LONG_AXIS;
        delta_y = 0.5 * BME280_HOLE_CENTERS_SHORT_AXIS;

        translate([-delta_x,-delta_y,0]) {
            standoff_with_peghole(STANDOFF_HEIGHT,STANDOFF_RADIUS,BME280_PEGHOLE_HEIGHT,BME280_PEGHOLE_OUTER_RADIUS,BME280_PEGHOLE_INNER_RADIUS);
        }     
        translate([delta_x,-delta_y,0]) {
            standoff_with_peghole(STANDOFF_HEIGHT,STANDOFF_RADIUS,BME280_PEGHOLE_HEIGHT,BME280_PEGHOLE_OUTER_RADIUS,BME280_PEGHOLE_INNER_RADIUS);
        } 
        translate([-delta_x,delta_y,0]) {
            standoff_with_peghole(STANDOFF_HEIGHT,STANDOFF_RADIUS,BME280_PEGHOLE_HEIGHT,BME280_PEGHOLE_OUTER_RADIUS,BME280_PEGHOLE_INNER_RADIUS);
        } 
        translate([delta_x,delta_y,0]) {
            standoff_with_peghole(STANDOFF_HEIGHT,STANDOFF_RADIUS,BME280_PEGHOLE_HEIGHT,BME280_PEGHOLE_OUTER_RADIUS,BME280_PEGHOLE_INNER_RADIUS);
        } 
    }
}

