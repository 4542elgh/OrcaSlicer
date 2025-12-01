; 4542elgh - Note
; M106 P1 - Part cooling fan - is set in filament's Part Cooling Fan
; M106 P2 - Aux fan - is set in filament's Auxiliary Part Cooling Fan
; M106 P3 - Exhaust fan - is set in filament's Exhaust Fan - Air Filtration
; 4542elgh - end

; 4542elgh - disable exhause fan base on plate temperature, exhaust fan will be 0 forever (already set to 0 in Machine Start G-Code)
; filament start gcode
; {if  (bed_temperature[current_extruder] >55)||(bed_temperature_initial_layer[current_extruder] >55)}M106 P3 S200
; {elsif(bed_temperature[current_extruder] >50)||(bed_temperature_initial_layer[current_extruder] >50)}M106 P3 S150
; {elsif(bed_temperature[current_extruder] >45)||(bed_temperature_initial_layer[current_extruder] >45)}M106 P3 S50
; {endif}

; {if activate_air_filtration[current_extruder] && support_air_filtration}
; M106 P3 S0
; {endif}
; 4542elgh - end