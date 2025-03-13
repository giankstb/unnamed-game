function keymapping(){
	going_up = keyboard_check(ord("W"))
	going_down = keyboard_check(ord("S"))
	going_right = keyboard_check(ord("D"))
	going_left = keyboard_check(ord("A"))
}

function moving(player_speed){
	var _x_input = going_right - going_left
	var _y_input = going_down - going_up
	
	var vector = sqrt(_x_input*_x_input + _y_input*_y_input)
	
	if vector > 0 
	{
        _x_input /= vector
        _y_input /= vector
    }
	
	if obj_controlador.player_can_move == true
	{
		move_and_collide(_x_input*player_speed,_y_input*player_speed,obj_wall)
	}
	show_debug_message(string(vector) + " " + string(_x_input * player_speed) + " " + string(_y_input * player_speed))
}

function animation(sprite_run,sprite_idle){
	var running = false
	if going_up or going_down or going_right or going_left
	{
		running = true
		sprite_index = sprite_run
	}
	else
	{
		running = false
		sprite_index = sprite_idle
	}
	if running and going_left
	{
		image_xscale = -1
	}
	if running and going_right
	{
		image_xscale = 1
	}
	
	//idle mouse direction
	looking_direction = int64(point_direction(x,y,mouse_x,mouse_y))
	if !running
	{
		if looking_direction > 90 and looking_direction < 270
		{
			image_xscale = -1
		}
		else
		{
			image_xscale = 1
		}
	}
}