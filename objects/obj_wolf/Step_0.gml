#region animation
var direction_interval = 45
var direction_calculate = floor(direction / direction_interval)

switch(direction_calculate) {
	case 0:
		sprite_index = spr_wolf_run_right
	break;
	
	case 1:
		sprite_index = spr_wolf_run_up
	break;
	
	case 2:
		sprite_index = spr_wolf_run_up
	break;
	
	case 3:
		sprite_index = spr_wolf_run_left
	break;
	
	case 4:
		sprite_index = spr_wolf_run_left
	break;
	
	case 5:
		sprite_index = spr_wolf_run_down
	break;
	
	case 6:
		sprite_index = spr_wolf_run_down
	break;
	
	case 7:
		sprite_index = spr_wolf_run_right
	break;
}
#endregion

depth = -y