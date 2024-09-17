X1C and P1 series
# Filament setting
## Chamber heater
Other than X1E (Enterprise) all other printers does not have Chamber heater

Filament -> Printer chamber temperature -> Activate temperature control will do nothing
## Aux fan (beefy part cooling fan from left side)
Filament -> Cooling -> Auxiliary part cooling fan -> Fan speed = Aux fan
## Chamber fan (circulation fan going through carbon filter)
Filament -> Cooling -> Exhaust fan -> Activate air filtration = Chamber fan

# Printer setting
## Disable input shaper buzz
Comment out mech mode fast check to disable input shaper buzzing sound during startup. This should not be done at every check if you have a stable surface
```gcode
;===== mech mode fast check============================
;G1 X128 Y128 Z10 F20000
;M400 P200
;M970.3 Q1 A7 B30 C80  H15 K0
;M974 Q1 S2 P0
;
;G1 X128 Y128 Z10 F20000
;M400 P200
;M970.3 Q0 A7 B30 C90 Q0 H15 K0
;M974 Q0 S2 P0
;
;M975 S1
;G1 F30000
;G1 X230 Y15
;G28 X ; re-home XY
;===== fmech mode fast check============================
```

## Reduce purge line to 50mm at 2 pass at edge plate center
```gcode
;===== nozzle load line ===============================
M975 S1
G90
M83
T1000
;G1 X18.0 Y1.0 Z0.8 F18000;Move to start position
; This govern the starting point of the purge line (100, 1)
G1 X100 Y1.0 Z0.8 F18000;Move to start position
M109 S{nozzle_temperature_initial_layer[initial_extruder]}
G1 Z0.2
G0 E2 F300
;G0 X240 E15 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}
; This govern the ending point of the purge line (150, 1) y is not mentioned, thus unchanged
G0 X150 E15 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}
; This part is the vertical purge line, I dont want it
;G0 Y11 E0.700 F{outer_wall_volumetric_speed/(0.3*0.5)/ 4 * 60}
;G0 X239.5
;G0 E0.2
; This govern the y distance travel (100, 1.5 - 1) = 0.5mm
G0 Y1.5 E0.700
;G0 X18 E15 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}
; This govern the return point of the purge line (100, 1.5)
G0 X100 E15 F{outer_wall_volumetric_speed/(0.3*0.5)     * 60}
M400
```
