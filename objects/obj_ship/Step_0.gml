if obj_controlador.sailing_ship
{
	#region keymapping
	var up		= keyboard_check(ord("W"))
	var left	= keyboard_check(ord("A"))
	var right	= keyboard_check(ord("D"))
	#endregion
	
	#region anchoring
	if keyboard_check_pressed(vk_space)
	{
		boat_anchor = !boat_anchor
	}

	if boat_anchor
	{
		boat_speed -= 0.02
	}
	#endregion
	
	#region sail type
	if keyboard_check_pressed(ord("E"))
	{
		boat_sail = !boat_sail
	}

	if boat_sail = false
	{
		if boat_speed > 0.5
		{
			boat_speed -= 0.1
		}
	}
	else
	{
		boat_maxspeed = 1
	}
	#endregion
	
	#region boat turning
	if boat_speed > 0
	{
			if left then direction += 0.5
			if right then direction -= 0.5
	}
	#endregion
	
	#region boat acceleration and stopping
	if !boat_anchor
	{
		if up
		{
			if boat_acceleration < boat_maxacceleration
			{
				boat_acceleration += 0.0001
			}
			boat_speed += boat_acceleration
		}
		else
		{
			boat_speed -= boat_friction
		}
	}
	#endregion
	
	#region boat speed limit
	boat_speed = clamp(boat_speed,0,boat_maxspeed)
	#endregion
	
	#region applying speed
	x += lengthdir_x(boat_speed,direction)
	y += lengthdir_y(boat_speed,direction)
	#endregion
	
	#region boat animation
	var boat_direction = direction
	var boat_direction_interval = 22.5
	var boat_direction_final = floor(boat_direction / boat_direction_interval)
	image_index = boat_direction_final
	#endregion
	
	#region boat collision
	if place_meeting(x,y,obj_ship_strand)
	{
		if alarm_collision_started = false
		{
			alarm[0] = 1
		}
	}
	if !place_meeting(x,y,obj_ship_strand)
	{
		alarm[0] = -1
		alarm_collision_started = false
	}

	if boat_stranded
	{
		boat_speed -= 0.3
	}
	#endregion
	if place_meeting(x,y,obj_ship_stranded_final)
	{
		boat_stranded = true
	}
}