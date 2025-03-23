#region enum states
enum AIState {
    IDLE,
    WALKING_CHASE,
    RUNNING_CHASE,
    ATTACKING,
    WANDERING,
    PREPARING
}
#endregion

#region wandering ai

#endregion

#region chasing ai

#region detection radius
if ai_state != AIState.PREPARING
{
    if distance_to_object(obj_player) <= detection_radius and detection_radius > detection_radius div 2
    {
        ai_state = AIState.RUNNING_CHASE
        debug_log("RUNNING CHASE")
    }
    
    if distance_to_object(obj_player) < detection_radius div 2
    {
        ai_state = AIState.WALKING_CHASE
        debug_log("WALKING CHASE")
    }
}
#endregion

#region speed defining
if ai_state = AIState.WALKING_CHASE then spd = 1.4
if ai_state = AIState.RUNNING_CHASE then spd = 2.4
#endregion

#region path start
if ai_state = AIState.WALKING_CHASE or ai_state = AIState.RUNNING_CHASE
{
    x_goal = obj_player.x
    y_goal = obj_player.y
    if mp_grid_path(obj_grid.grid,path,x,y,x_goal,y_goal,true)
    {
        path_start(path,spd,path_action_stop,false)
    }
}
else {
    x_goal = x
    y_goal = y
}
#endregion
    
#endregion


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