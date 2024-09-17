; 4542elgh: Set Chamber fan to air filtration speed
{if activate_air_filtration[current_extruder] && support_air_filtration}
    M106 P3 S{during_print_exhaust_fan_speed_num[current_extruder]} 
{endif}

; 4542elgh: Aux fan is set in filament's Auxiliary Part Cooling Fan