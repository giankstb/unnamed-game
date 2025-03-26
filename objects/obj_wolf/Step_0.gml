#region enum states
enum AIState {
    IDLE,
    WALKING_CHASE,
    RUNNING_CHASE,
    ATTACKING,
    WANDERING,
    PREPARING,
    HIT
}
#endregion

#region wandering ai
if ai_state = AIState.IDLE
{
    if timer_wandering = undefined then timer_wandering = 300
    if timer_wandering > 0 then timer_wandering--
    if timer_wandering = 0
    {
        var choice = irandom_range(0,100)
        if choice >= 40
        {
            ai_state = AIState.WANDERING
        }
        timer_wandering = undefined
    }    
}
#endregion

#region chasing ai

#region detection radius
if ai_state != AIState.PREPARING and ai_state != AIState.ATTACKING and ai_state != AIState.HIT
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
    if mp_grid_path(obj_grid.grid,path,x,y,x_goal,y_goal,false)
    {
        path_start(path,spd,path_action_stop,false)
    }
}
if ai_state = AIState.PREPARING or ai_state = AIState.ATTACKING or ai_state = AIState.HIT
{
    x_goal = x
    y_goal = y
    if mp_grid_path(obj_grid.grid,path,x,y,x_goal,y_goal,false)
        {
            path_start(path,spd,path_action_stop,false)
        }
}

if ai_state = AIState.WANDERING
{
    if x_goal_wander = undefined then x_goal_wander = x + irandom_range(-300,300)
    if y_goal_wander = undefined then y_goal_wander = y + irandom_range(-300,300)    
    
    if mp_grid_path(obj_grid.grid,path,x,y,x_goal_wander,y_goal_wander,false)
    {
        path_start(path,spd,path_action_stop,false)
    }
    if abs(x - x_goal_wander) < 5 and abs(y - y_goal_wander) < 5{
        x_goal_wander = undefined
        y_goal_wander = undefined
        ai_state = AIState.IDLE
    } 
}
#endregion

#region preparing to jump
if ai_state != AIState.PREPARING and ai_state != AIState.ATTACKING
{
    if distance_to_object(obj_player) < detection_radius div 2
    {
        if timer == undefined then timer = 100
        if timer > 0 then timer--
        if timer == 0
        {
            ai_state = AIState.PREPARING
            timer = undefined
        }
    }
}

if ai_state = AIState.PREPARING
{
    if timer = undefined then timer = 60
    if timer > 0 then timer--
    if timer == 0
    {
        ai_state = AIState.ATTACKING
    }
}
#endregion

#region jumping towards the player
if ai_state = AIState.ATTACKING
{
    var direction_to_jump = point_direction(x,y,obj_player.x,obj_player.y)
    if new_x == undefined then new_x = x + lengthdir_x(jump_size,direction_to_jump)
    if new_y == undefined then new_y = y + lengthdir_y(jump_size,direction_to_jump)
    x = lerp(x,new_x,0.05)
    y = lerp(y,new_y,0.05)
    if abs(x - new_x) < 5 and abs(y - new_y) < 5
    {
        ai_state = AIState.IDLE
        timer = undefined
        new_x = undefined
        new_y = undefined
    }
}

#region damage from player
if ai_state != AIState.HIT
{
    if place_meeting(x,y,obj_spear) and obj_spear.can_attack = false
    {
        ai_state = AIState.HIT
        life -= 50
        new_x = undefined
        new_y = undefined
    }
}

if ai_state = AIState.HIT
{
    var distance_to_hit = 100
    var direction_to_hit = point_direction(x,y,obj_spear.x,obj_spear.y) + 180
    if new_x = undefined then new_x = x + lengthdir_x(distance_to_hit,direction_to_hit)
    if new_y = undefined then new_y = y + lengthdir_y(distance_to_hit,direction_to_hit)
        
    x = lerp(x,new_x,0.05)
    y = lerp(y,new_y,0.05)
    if abs(x - new_x) < 5 and abs(y - new_y) < 5
    {
        new_x = undefined
        new_y = undefined
        ai_state = AIState.IDLE
        timer = undefined
    }
}

if life <= 0
{
    instance_destroy()
}
#endregion

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