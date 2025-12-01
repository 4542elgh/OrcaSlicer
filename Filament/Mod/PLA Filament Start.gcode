; 4542elgh - Note
; Aux fan is set in filament's Auxiliary Part Cooling Fan
; 4542elgh - end

; 4542elgh - disable part cooling fan base on plate temperature, part cooling will be 0 on first layer
; filament start gcode
; {if  (bed_temperature[current_extruder] >55)||(bed_temperature_initial_layer[current_extruder] >55)}M106 P3 S200
; {elsif(bed_temperature[current_extruder] >50)||(bed_temperature_initial_layer[current_extruder] >50)}M106 P3 S150
; {elsif(bed_temperature[current_extruder] >45)||(bed_temperature_initial_layer[current_extruder] >45)}M106 P3 S50
; {endif}

; {if activate_air_filtration[current_extruder] && support_air_filtration}
M106 P3 S0
; {endif}
; 4542elgh - end
