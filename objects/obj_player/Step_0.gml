#region functions
keymapping()
moving(1.7)
#endregion

#region rolling
if keyboard_check_pressed(vk_shift) and action_rolling = false
{
	end_x = x
	end_y = y
	action_rolling = true
	obj_controlador.player_can_move = false
	rolling_direction = point_direction(xprevious,yprevious,x,y)
	rolling_distance = 96
	end_x += lengthdir_x(rolling_distance,rolling_direction)
	end_y += lengthdir_y(rolling_distance,rolling_direction)
	if xprevious == x and yprevious == y
	{
		end_x = x
		end_y = y
	}
}

if action_rolling
{
	if collision_line(x,y,end_x,end_y,obj_wall,false,true)
	{
		end_x = x
		end_y = y
	}
	x = lerp(x,end_x,0.1)
	y = lerp(y,end_y,0.1)
	if abs(x - end_x) < 8 and abs(y - end_y) < 8
	{
		alarm[0] = 1
		obj_controlador.player_can_move = true
	}
}
#endregion

#region ship sailing
if keyboard_check_pressed(ord("K")) and distance_to_object(obj_ship) < 20
{
	sailing_ship = !sailing_ship
	
}

if instance_exists(obj_ship)
{
	if sailing_ship
	{
		obj_controlador.sailing_ship = true
		obj_controlador.player_can_move = false
		obj_controlador.player_can_roll = false
		obj_spear.enable_spear = false
		obj_camera.follow = obj_ship
		image_alpha = 0
		obj_spear.image_alpha = 0
		x = obj_ship.x - 12
		y = obj_ship.y - 8
		new_cam_width = 960
		new_cam_height = 540
		camera_set_view_size(view_camera[0], obj_camera.cam_width, obj_camera.cam_height)
		obj_camera.cam_follow_speed = 4
	}
	else
	{
		obj_controlador.sailing_ship = false
		obj_controlador.player_can_move = true
		obj_controlador.player_can_roll = true
		obj_spear.enable_spear = true
		obj_camera.follow = obj_player
		image_alpha = 1
		obj_spear.image_alpha = 1
		new_cam_width = 640
		new_cam_height = 360
		camera_set_view_size(view_camera[0], obj_camera.cam_width, obj_camera.cam_height)
		obj_camera.cam_follow_speed = 16
	}
	obj_camera.cam_width = lerp(obj_camera.cam_width,new_cam_width,0.2)
	obj_camera.cam_height = lerp(obj_camera.cam_height,new_cam_height,0.2)
}
#endregion

#region animating
if going_down then last_direction = 0
if going_up then last_direction = 1
if going_left then last_direction = 2
if going_right then last_direction = 3

if !going_down and !going_up and !going_right and !going_left
{
	if last_direction = 0
	{
		sprite_index = spr_player
		obj_spear.depth = -y
	}
	if last_direction = 1
	{
		sprite_index = spr_player_up
		obj_spear.depth = 1
	}
	if last_direction = 2
	{
		sprite_index = spr_player_horizontal
		image_xscale = 1
		obj_spear.depth = -y
	}
	if last_direction = 3
	{
		sprite_index = spr_player_horizontal
		image_xscale = -1
		obj_spear.depth = -y
	}
}

if obj_controlador.player_can_move
{
	if going_up then sprite_index = spr_player_run_up
	if going_down then sprite_index = spr_player_run
	if going_left
	{
		sprite_index = spr_player_run_horizontal
		image_xscale = 1
	}
	if going_right
	{
		sprite_index = spr_player_run_horizontal
		image_xscale = -1
	}
}

 mouse_direction = point_direction(x,y,mouse_x,mouse_y)
 mouse_direction_interval = 45
 mouse_direction_final = floor(mouse_direction / mouse_direction_interval)

if !going_down and !going_up and !going_right and !going_left or obj_spear.can_attack = false
{
	if mouse_direction_final == 0 then last_direction = 3
	if mouse_direction_final == 1 then last_direction = 1
	if mouse_direction_final == 2 then last_direction = 1
	if mouse_direction_final == 3 then last_direction = 2
	if mouse_direction_final == 4 then last_direction = 2
	if mouse_direction_final == 5 then last_direction = 0
	if mouse_direction_final == 6 then last_direction = 0
	if mouse_direction_final == 7 then last_direction = 3
	
	if last_direction = 0
	{
		sprite_index = spr_player
		obj_spear.depth = -y
	}
	if last_direction = 1
	{
		sprite_index = spr_player_up
		obj_spear.depth = 1
	}
	if last_direction = 2
	{
		sprite_index = spr_player_horizontal
		image_xscale = 1
		obj_spear.depth = -y
	}
	if last_direction = 3
	{
		sprite_index = spr_player_horizontal
		image_xscale = -1
		obj_spear.depth = -y
	}
}
#endregion

depth = -y