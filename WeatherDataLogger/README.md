# Introduction 
This is a collection of [OpenSCAD](https://openscad.org/) source files, modelling various enclosures for the Clear Creek Scientific Weather Data logger. The models are split into a bottom half and a top half. There are multiple variations of the bottom and top halves, each offering different features. You should choose one each of the bottom and top files to produce the enclosure you want. See the list below for a description of each file:

## Version 0001 (Enclosure for Raspberry Pi Zero and Adafruit BME280 sensor)

* **ccs_dl0001_enc_consts.scad**: Constant values used by each of the following models.

### Bottom Half

* **_ccs_dl0001_enc_bottom_common.scad**: Common elements of the bottom half of a non-embellised enclosure for a Raspberry Pi Zero and an Adafruit BME280 temperature, humidity and pressure sensor. Requires *ccs_dl0001_enc_consts.scad*.
* **ccs_dl0001_enc_bottom.scad**: Bottom half of a non-embellised enclosure for a Raspberry Pi Zero and an Adafruit BME280 temperature, humidity and pressure sensor. Requires *ccs_dl0001_enc_bottom_common.scad*.
* **ccs_dl0001_enc_bottom_with_feet.scad**: Bottom half of an enclosure for a Raspberry Pi Zero and an Adafruit BME280 temperature, humidity and pressure sensor. It has tabs on the sides to help fasten it to a flat surface. Requires *ccs_dl0001_enc_bottom_common.scad*.

### Top Half

* **ccs_dl0001_enc_top_common.scad**: Top half of a non-embellised enclosure for a Raspberry Pi Zero and an Adafruit BME280 temperature, humidity and pressure sensor. *Requires ccs_dl0001_enc_consts.scad*.
* **ccs_dl0001_enc_top_no_header_cutouts.scad**: Top half of an enclosure for a Raspberry Pi Zero and an Adafruit BME280 temperature, humidity and pressure sensor. *Requires ccs_dl0001_enc_top_common.scad*.
* **ccs_dl0001_enc_bottom_with_feet.scad**: Top half of an enclosure for a Raspberry Pi Zero and an Adafruit BME280 temperature, humidity and pressure sensor. It has rectangular holes that allow access to attached header pins in each of the boards. Requires *ccs_dl0001_enc_top_common.scada*.

