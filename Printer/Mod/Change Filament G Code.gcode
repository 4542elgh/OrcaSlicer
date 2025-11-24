; 4542elgh - Notes
; 1. Parking chute position X60 Y265
; 2. Y max is 265, anything more will cause collision
; 3. Moving toolhead Y direction away from poop chute handle should be done with X>100 so poop chute handle doesnt bind with toolhead and make a loud sound
; 4542elgh - end

M620 S[next_extruder]A
M204 S9000
{if toolchange_count > 1 && (z_hop_types[current_extruder] == 0 || z_hop_types[current_extruder] == 3)}
G17
G2 Z{z_after_toolchange + 0.4} I0.86 J0.86 P1 F10000 ; spiral lift a little from second lift
{endif}
G1 Z{max_layer_z + 3.0} F1200

G1 X70 F21000
G1 Y245
G1 Y265 F3000
M400
M106 P1 S0
M106 P2 S0
{if old_filament_temp > 142 && next_extruder < 255}
M104 S[old_filament_temp]
{endif}
{if long_retractions_when_cut[previous_extruder]}
M620.11 S1 I[previous_extruder] E-{retraction_distances_when_cut[previous_extruder]} F{old_filament_e_feedrate}
{else}
M620.11 S0
{endif}
M400
G1 X90 F3000
G1 Y255 F4000
G1 X100 F5000
G1 X120 F15000
G1 X20 Y50 F21000
G1 Y-3
{if toolchange_count == 2}
; get travel path for change filament
M620.1 X[travel_point_1_x] Y[travel_point_1_y] F21000 P0
M620.1 X[travel_point_2_x] Y[travel_point_2_y] F21000 P1
M620.1 X[travel_point_3_x] Y[travel_point_3_y] F21000 P2
{endif}
M620.1 E F[old_filament_e_feedrate] T{nozzle_temperature_range_high[previous_extruder]}
T[next_extruder]
M620.1 E F[new_filament_e_feedrate] T{nozzle_temperature_range_high[next_extruder]}

{if next_extruder < 255}
{if long_retractions_when_cut[previous_extruder]}
M620.11 S1 I[previous_extruder] E{retraction_distances_when_cut[previous_extruder]} F{old_filament_e_feedrate}
M628 S1
G92 E0
G1 E{retraction_distances_when_cut[previous_extruder]} F[old_filament_e_feedrate]
M400
M629 S1
{else}
M620.11 S0
{endif}
G92 E0
{if flush_length_1 > 1}
M83
; FLUSH_START
; always use highest temperature to flush
M400
{if filament_type[next_extruder] == "PETG"}
M109 S260
{elsif filament_type[next_extruder] == "PVA"}
M109 S210
{else}
M109 S[nozzle_temperature_range_high]
{endif}
{if flush_length_1 > 23.7}
G1 E23.7 F{old_filament_e_feedrate} ; do not need pulsatile flushing for start part
G1 E{(flush_length_1 - 23.7) * 0.02} F50
G1 E{(flush_length_1 - 23.7) * 0.23} F{old_filament_e_feedrate}
G1 E{(flush_length_1 - 23.7) * 0.02} F50
G1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}
G1 E{(flush_length_1 - 23.7) * 0.02} F50
G1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}
G1 E{(flush_length_1 - 23.7) * 0.02} F50
G1 E{(flush_length_1 - 23.7) * 0.23} F{new_filament_e_feedrate}
{else}
G1 E{flush_length_1} F{old_filament_e_feedrate}
{endif}
; FLUSH_END
G1 E-[old_retract_length_toolchange] F1800
G1 E[old_retract_length_toolchange] F300
{endif}

{if flush_length_2 > 1}

; 4542elgh - This is moving the excuder X3, weird movement
;G91
;G1 X3 F12000; move aside to extrude
;G90
;M83
; 4542elgh - end

; FLUSH_START
G1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}
G1 E{flush_length_2 * 0.02} F50
G1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}
G1 E{flush_length_2 * 0.02} F50
G1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}
G1 E{flush_length_2 * 0.02} F50
G1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}
G1 E{flush_length_2 * 0.02} F50
G1 E{flush_length_2 * 0.18} F{new_filament_e_feedrate}
G1 E{flush_length_2 * 0.02} F50
; FLUSH_END
G1 E-[new_retract_length_toolchange] F1800
G1 E[new_retract_length_toolchange] F300
{endif}

{if flush_length_3 > 1}

; 4542elgh - This is moving the excuder X3, weird movement
;G91
;G1 X3 F12000; move aside to extrude
;G90
;M83
; 4542elgh - end

; FLUSH_START
G1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}
G1 E{flush_length_3 * 0.02} F50
G1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}
G1 E{flush_length_3 * 0.02} F50
G1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}
G1 E{flush_length_3 * 0.02} F50
G1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}
G1 E{flush_length_3 * 0.02} F50
G1 E{flush_length_3 * 0.18} F{new_filament_e_feedrate}
G1 E{flush_length_3 * 0.02} F50
; FLUSH_END
G1 E-[new_retract_length_toolchange] F1800
G1 E[new_retract_length_toolchange] F300
{endif}

{if flush_length_4 > 1}

; 4542elgh - This is moving the excuder X3, weird movement
;G91
;G1 X3 F12000; move aside to extrude
;G90
;M83
; 4542elgh - end

; FLUSH_START
G1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}
G1 E{flush_length_4 * 0.02} F50
G1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}
G1 E{flush_length_4 * 0.02} F50
G1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}
G1 E{flush_length_4 * 0.02} F50
G1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}
G1 E{flush_length_4 * 0.02} F50
G1 E{flush_length_4 * 0.18} F{new_filament_e_feedrate}
G1 E{flush_length_4 * 0.02} F50
; FLUSH_END
{endif}
; FLUSH_START
M400
M109 S[new_filament_temp]
G1 E2 F{new_filament_e_feedrate} ;Compensate for filament spillage during waiting temperature
; FLUSH_END
M400
G92 E0
G1 E-[new_retract_length_toolchange] F1800
M106 P1 S255 ; turn on toolhead fan
M400 S3 ; wait for 3 seconds

; 4542elgh - Y265 is max, anything more will caused collision
; This part is for wiping nozzle against wipper
;G1 X70 F5000
;G1 X90 F3000
;G1 Y255 F4000
;G1 X105 F5000
;G1 Y265 F5000
;G1 X70 F10000
;G1 X100 F5000
;G1 X70 F10000
;G1 X100 F5000

;G1 X70 F5000

G1 X90 F3000 ; circular motion to disconnect the poop from toolhead 2 times
G1 Y263
G1 X70
G1 Y265
G1 X90
G1 Y263
G1 X70
G1 Y265

G1 X70 F10000 ; scrub against wipper 5 times
G1 X100 F5000
G1 X70 F10000
G1 X100 F5000
G1 X70 F10000
G1 X100 F5000
G1 X70 F10000
G1 X100 F5000
G1 X70 F10000
G1 X100 F5000
; 4542elgh - end

G1 X70 F10000
G1 X80 F15000

; 4542elgh - shake the purge handle (x direction) to shake the garbage down
;G1 X60
;G1 X80
;G1 X60
;G1 X80 ; shake to put down garbage
;G1 X100 F5000

G1 X50 F8000 ; shake handle bar left right 6 times
G1 X110
G1 X50
G1 X110
G1 X50
G1 X110
G1 X50
G1 X110
G1 X50
G1 X110
G1 X50
G1 X150 ; move toolhead to further place so it does not bind with chute handle when moving to front

G1 Y240 F3000 ; make sure toolhead not binding with chute handle
G1 X60 ; reposition toolhead to chute
G1 Y265 ; Move toolhead front and back (y direction) to push the purge handle 4 times
G1 Y240
G1 Y265
G1 Y240
G1 Y265
G1 Y240
G1 Y265
; 4542elgh - end

G1 X165 F15000; wipe and shake
G1 Y256 ; move Y to aside, prevent collision
M400
G1 Z{max_layer_z + 3.0} F3000
{if layer_z <= (initial_layer_print_height + 0.001)}
M204 S[initial_layer_acceleration]
{else}
M204 S[default_acceleration]
{endif}
{else}
G1 X[x_after_toolchange] Y[y_after_toolchange] Z[z_after_toolchange] F12000
{endif}
M621 S[next_extruder]A
