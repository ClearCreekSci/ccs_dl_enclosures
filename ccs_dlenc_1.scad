use <MCAD/boxes.scad>
use <MCAD/regular_shapes.scad>

$fa=1;
$fs=0.4;

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


PI_PEG_HEIGHT = WALL_WIDTH+5;
PI_PEGHOLE_HEIGHT = WALL_WIDTH+5;
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

BME280_PEG_HEIGHT = WALL_WIDTH+4;
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

module pi_bottom_box() {
    difference() {
     
        // outer_box
        roundedBox(size=[PI_OUTER_LENGTH,PI_OUTER_WIDTH,BOTTOM_WALL_HEIGHT],radius=PI_OUTER_CORNER_RADIUS,sidesonly=true);

        // cut out
        translate([0,0,WALL_WIDTH]) {
            roundedBox(size=[PI_INNER_LENGTH,PI_INNER_WIDTH,BOTTOM_WALL_HEIGHT],radius=PI_INNER_CORNER_RADIUS,sidesonly=true);
        }  

        // Make some holes for ventilation
        //for (dy=[-(PI_INNER_WIDTH/2-3*VHOLE_RADIUS):2.5*VHOLE_RADIUS:PI_INNER_WIDTH/2-2*VHOLE_RADIUS]) {
        //    for (dx=[-(PI_INNER_LENGTH/2-3*VHOLE_RADIUS):2.5*VHOLE_RADIUS:PI_INNER_LENGTH/2-2*VHOLE_RADIUS]) {
        //        translate([dx,dy,-VHOLE_OVERLAP]) {
        //            rotate([0,0,30]) {
        //                hexagonal_prism(VHOLE_HEIGHT,VHOLE_RADIUS);
        //            }
        //        }
        //    }
        // }

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
   
    } // difference
}


module pi_bottom_box_with_pegs() {
    union() {


        translate([0,0,0.5*BOTTOM_WALL_HEIGHT]) {
            pi_bottom_box();
        }

        delta_x = 0.5 * PI_HOLE_CENTERS_LONG_AXIS;
        delta_y = 0.5 * PI_HOLE_CENTERS_SHORT_AXIS;

        translate([-delta_x,-delta_y,0]) {
            standoff_with_peg(STANDOFF_HEIGHT,STANDOFF_RADIUS,PI_PEG_HEIGHT,PI_PEG_RADIUS);
        } 
        translate([delta_x,-delta_y,0]) {
            standoff_with_peg(STANDOFF_HEIGHT,STANDOFF_RADIUS,PI_PEG_HEIGHT,PI_PEG_RADIUS);
        } 
        translate([-delta_x,delta_y,0]) {
            standoff_with_peg(STANDOFF_HEIGHT,STANDOFF_RADIUS,PI_PEG_HEIGHT,PI_PEG_RADIUS);
        } 
        translate([delta_x,delta_y,0]) {
            standoff_with_peg(STANDOFF_HEIGHT,STANDOFF_RADIUS,PI_PEG_HEIGHT,PI_PEG_RADIUS);
        } 
    }
}

module pi_bottom_box_with_pegs_and_cutouts() {
    difference() {
        pi_bottom_box_with_pegs();
      
        // SD card cutout 
        translate([-(0.5*PI_OUTER_LENGTH-0.5*WALL_WIDTH),-0.05*PI_OUTER_WIDTH,BOTTOM_WALL_HEIGHT]) {
            rotate([0,0,90]) {
                cube([0.35*PI_OUTER_WIDTH,WALL_WIDTH+0.2,0.5*BOTTOM_WALL_HEIGHT+0.2],center=true);
            }
        }
         
        // Mini HDMI cutout 
        hdmi_shift = 0.20*PI_OUTER_LENGTH;
        translate([-(0.5*PI_OUTER_LENGTH-hdmi_shift),-0.5*(PI_OUTER_WIDTH-0.05*PI_OUTER_WIDTH)-0.1,BOTTOM_WALL_HEIGHT]) {
            cube([0.25*PI_OUTER_WIDTH,WALL_WIDTH+0.2,0.5*BOTTOM_WALL_HEIGHT+0.2],center=true);
        }

        // Micro USB 1 cutout 
        usb1_shift = 0.20*PI_OUTER_LENGTH;
        translate([0.5*PI_OUTER_LENGTH-usb1_shift,-0.5*(PI_OUTER_WIDTH-0.05*PI_OUTER_WIDTH)-0.1,BOTTOM_WALL_HEIGHT]) {
            cube([0.20*PI_OUTER_WIDTH,WALL_WIDTH+0.2,0.5*BOTTOM_WALL_HEIGHT+0.2],center=true);
        }

        // Micro USB 2 cutout 
        usb2_shift = 0.37*PI_OUTER_LENGTH;
        translate([0.5*PI_OUTER_LENGTH-usb2_shift,-0.5*(PI_OUTER_WIDTH-0.05*PI_OUTER_WIDTH)-0.1,BOTTOM_WALL_HEIGHT]) {
            cube([0.20*PI_OUTER_WIDTH,WALL_WIDTH+0.2,0.5*BOTTOM_WALL_HEIGHT+0.2],center=true);
        }
    }
}

module bme280_bottom_box() {

    difference() {
     
        // outer_box
        roundedBox(size=[BME280_OUTER_LENGTH,BME280_OUTER_WIDTH,BOTTOM_WALL_HEIGHT],radius=BME280_OUTER_CORNER_RADIUS,sidesonly=true);

        // cut out
        translate([0,0,WALL_WIDTH]) {
            roundedBox(size=[BME280_INNER_LENGTH,BME280_INNER_WIDTH,BOTTOM_WALL_HEIGHT],radius=BME280_INNER_CORNER_RADIUS,sidesonly=true);
        }  

        // Make some holes for ventilation

        for (dx=[-(BME280_INNER_LENGTH/2-5*VHOLE_RADIUS):2.2*VHOLE_RADIUS:BME280_INNER_LENGTH/2-5*VHOLE_RADIUS]) {
            translate([dx,0,-VHOLE_OVERLAP]) {
                rotate([0,0,30]) {
                    hexagonal_prism(VHOLE_HEIGHT,VHOLE_RADIUS);
                }
            }
        }

        for (dx=[-(BME280_INNER_LENGTH/2-6*VHOLE_RADIUS):2.2*VHOLE_RADIUS:BME280_INNER_LENGTH/2-6*VHOLE_RADIUS]) {
            translate([dx,2*VHOLE_RADIUS,-VHOLE_OVERLAP]) {
                rotate([0,0,-30]) {
                    hexagonal_prism(VHOLE_HEIGHT,VHOLE_RADIUS);
                }
            }
        }

        for (dx=[-(BME280_INNER_LENGTH/2-6*VHOLE_RADIUS):2.2*VHOLE_RADIUS:BME280_INNER_LENGTH/2-6*VHOLE_RADIUS]) {
            translate([dx,-2*VHOLE_RADIUS,-VHOLE_OVERLAP]) {
                rotate([0,0,-30]) {
                    hexagonal_prism(VHOLE_HEIGHT,VHOLE_RADIUS);
                }
            }
        }
    } // difference
}


module bme280_bottom_box_with_pegs() {
    union() {
        translate([0,0,0.5*BOTTOM_WALL_HEIGHT]) {
            bme280_bottom_box();
        }

        delta_x = 0.5 * BME280_HOLE_CENTERS_LONG_AXIS;
        delta_y = 0.5 * BME280_HOLE_CENTERS_SHORT_AXIS;

        translate([-delta_x,-delta_y,0]) {
            standoff_with_peg(STANDOFF_HEIGHT,STANDOFF_RADIUS,BME280_PEG_HEIGHT,BME280_PEG_RADIUS);
        }     
        translate([delta_x,-delta_y,0]) {
            standoff_with_peg(STANDOFF_HEIGHT,STANDOFF_RADIUS,BME280_PEG_HEIGHT,BME280_PEG_RADIUS);
        } 
        translate([-delta_x,delta_y,0]) {
            standoff_with_peg(STANDOFF_HEIGHT,STANDOFF_RADIUS,BME280_PEG_HEIGHT,BME280_PEG_RADIUS);
        } 
        translate([delta_x,delta_y,0]) {
            standoff_with_peg(STANDOFF_HEIGHT,STANDOFF_RADIUS,BME280_PEG_HEIGHT,BME280_PEG_RADIUS);
        } 
    }
}

module bme280_bottom_box_with_pegs_and_cutouts() {
    difference() {
        bme280_bottom_box_with_pegs();

        translate([0.5*BME280_OUTER_LENGTH-(0.5*WALL_WIDTH),0,BOTTOM_WALL_HEIGHT]) {
            rotate([0,0,90]) {
                cube([0.25*BME280_OUTER_WIDTH,WALL_WIDTH+0.2,0.5*BOTTOM_WALL_HEIGHT+0.2],center=true);
            }
        }

        translate([-0.5*BME280_OUTER_LENGTH+(0.5*WALL_WIDTH),0,BOTTOM_WALL_HEIGHT]) {
            rotate([0,0,90]) {
                cube([0.25*BME280_OUTER_WIDTH,WALL_WIDTH+0.2,0.5*BOTTOM_WALL_HEIGHT+0.2],center=true);
            }
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


module pi_top_box() {
    difference() {
     
        // outer_box
        roundedBox(size=[PI_OUTER_LENGTH,PI_OUTER_WIDTH,BOTTOM_WALL_HEIGHT],radius=PI_OUTER_CORNER_RADIUS,sidesonly=true);

        // cut out
        translate([0,0,WALL_WIDTH]) {
            roundedBox(size=[PI_INNER_LENGTH,PI_INNER_WIDTH,BOTTOM_WALL_HEIGHT],radius=PI_INNER_CORNER_RADIUS,sidesonly=true);
        }  

        // Make some holes for ventilation
        //for (dy=[-(PI_INNER_WIDTH/2-3*VHOLE_RADIUS):2.5*VHOLE_RADIUS:PI_INNER_WIDTH/2-2*VHOLE_RADIUS]) {
        //    for (dx=[-(PI_INNER_LENGTH/2-3*VHOLE_RADIUS):2.5*VHOLE_RADIUS:PI_INNER_LENGTH/2-2*VHOLE_RADIUS]) {
        //        translate([dx,dy,-VHOLE_OVERLAP]) {
        //            rotate([0,0,30]) {
        //                hexagonal_prism(VHOLE_HEIGHT,VHOLE_RADIUS);
        //            }
        //        }
        //    }
        // }

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
   
    } // difference
}


module pi_top_box_with_pegholes() {
    union() {
        translate([0,0,0.5*BOTTOM_WALL_HEIGHT]) {
            pi_bottom_box();
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
        translate([-(0.5*PI_OUTER_LENGTH-0.5*WALL_WIDTH),0.05*PI_OUTER_WIDTH,TOP_WALL_HEIGHT]) {
            rotate([0,0,90]) {
                cube([0.35*PI_OUTER_WIDTH,WALL_WIDTH+0.2,0.5*TOP_WALL_HEIGHT+0.2],center=true);
            }
        }
         
        // Mini HDMI cutout 
        hdmi_shift = 0.20*PI_OUTER_LENGTH;
        translate([-(0.5*PI_OUTER_LENGTH-hdmi_shift),0.5*(PI_OUTER_WIDTH-0.05*PI_OUTER_WIDTH)+0.1,TOP_WALL_HEIGHT]) {
            cube([0.25*PI_OUTER_WIDTH,WALL_WIDTH+0.2,0.5*BOTTOM_WALL_HEIGHT+0.2],center=true);
        }

        // Micro USB 1 cutout 
        usb1_shift = 0.20*PI_OUTER_LENGTH;
        translate([0.5*PI_OUTER_LENGTH-usb1_shift,0.5*(PI_OUTER_WIDTH-0.05*PI_OUTER_WIDTH)+0.1,TOP_WALL_HEIGHT]) {
            cube([0.20*PI_OUTER_WIDTH,WALL_WIDTH+0.2,0.5*BOTTOM_WALL_HEIGHT+0.2],center=true);
        }

        // Micro USB 2 cutout 
        usb2_shift = 0.37*PI_OUTER_LENGTH;
        translate([0.5*PI_OUTER_LENGTH-usb2_shift,0.5*(PI_OUTER_WIDTH-0.05*PI_OUTER_WIDTH)+0.1,BOTTOM_WALL_HEIGHT]) {
            cube([0.20*PI_OUTER_WIDTH,WALL_WIDTH+0.2,0.5*BOTTOM_WALL_HEIGHT+0.2],center=true);
        }
    }
}

module pi_top_box_with_header_cutout() {

    difference() {
        pi_top_box_with_pegholes_and_cutouts();

        translate([0,-0.5*PI_HOLE_CENTERS_SHORT_AXIS,BOTTOM_WALL_HEIGHT-(0.5*BOTTOM_WALL_HEIGHT)]) {
            cube([PI_HOLE_CENTERS_LONG_AXIS-8,5,BOTTOM_WALL_HEIGHT+0.2],center=true); 
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

module bme280_top_box() {

    difference() {
     
        // outer_box
        roundedBox(size=[BME280_OUTER_LENGTH,BME280_OUTER_WIDTH,TOP_WALL_HEIGHT],radius=BME280_OUTER_CORNER_RADIUS,sidesonly=true);

        // cut out
        translate([0,0,WALL_WIDTH]) {
            roundedBox(size=[BME280_INNER_LENGTH,BME280_INNER_WIDTH,TOP_WALL_HEIGHT],radius=BME280_INNER_CORNER_RADIUS,sidesonly=true);
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
    } // difference
}


module bme280_top_box_with_pegholes() {
    union() {
        translate([0,0,0.5*TOP_WALL_HEIGHT]) {
            bme280_bottom_box();
        }

        delta_x = 0.5 * BME280_HOLE_CENTERS_LONG_AXIS;
        delta_y = 0.5 * BME280_HOLE_CENTERS_SHORT_AXIS;

        translate([-delta_x,-delta_y,0]) {
            standoff_with_peghole(STANDOFF_HEIGHT,STANDOFF_RADIUS,BME280_PEG_HEIGHT,BME280_PEGHOLE_OUTER_RADIUS,BME280_PEGHOLE_INNER_RADIUS);
        }     
        translate([delta_x,-delta_y,0]) {
            standoff_with_peghole(STANDOFF_HEIGHT,STANDOFF_RADIUS,BME280_PEG_HEIGHT,BME280_PEGHOLE_OUTER_RADIUS,BME280_PEGHOLE_INNER_RADIUS);
        } 
        translate([-delta_x,delta_y,0]) {
            standoff_with_peghole(STANDOFF_HEIGHT,STANDOFF_RADIUS,BME280_PEG_HEIGHT,BME280_PEGHOLE_OUTER_RADIUS,BME280_PEGHOLE_INNER_RADIUS);
        } 
        translate([delta_x,delta_y,0]) {
            standoff_with_peghole(STANDOFF_HEIGHT,STANDOFF_RADIUS,BME280_PEG_HEIGHT,BME280_PEGHOLE_OUTER_RADIUS,BME280_PEGHOLE_INNER_RADIUS);
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
    }
}

module bme280_top_box_with_header_cutout() {

    difference() {
        bme280_top_box_with_pegholes_and_cutouts();

        translate([0,-0.5*BME280_HOLE_CENTERS_SHORT_AXIS-1,BOTTOM_WALL_HEIGHT-(0.5*BOTTOM_WALL_HEIGHT)]) {
            cube([BME280_HOLE_CENTERS_LONG_AXIS-6,2,BOTTOM_WALL_HEIGHT+0.2],center=true); 
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



union() {
   translate([0,-20,0]) {
       bottom_box();
   }

   translate([0,20,0]) {
       top_box();
   }
}


