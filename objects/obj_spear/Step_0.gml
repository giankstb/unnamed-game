#region player controlling
if keyboard_check_pressed(ord("1"))
{
	holstered = !holstered
}


if enable_spear = true {
	if !holstered
	{
		if !can_attack
		{
			obj_controlador.player_can_move = false
			obj_controlador.player_can_roll = false
		}
		if can_attack
		{
			x = obj_player.x
			y = obj_player.y - 16
			obj_controlador.player_can_move = true
			obj_controlador.player_can_roll = true
			start_x = x
			start_y = y
			new_x = x
			new_y = y
		}
	}
	else
	{
		if obj_player.last_direction == 0
		{
			x = obj_player.x + 10
			y = obj_player.y - 25
			image_angle = 225
			depth = 1
		}
		if obj_player.last_direction == 1
		{
			x = obj_player.x + 10
			y = obj_player.y - 25
			image_angle = 225
			depth = obj_player.depth - 1
		}
		if obj_player.last_direction == 2
		{
			x = obj_player.x + 5
			y = obj_player.y - 29
			image_angle = 270
			depth = 1
		}
		if obj_player.last_direction == 3
		{
			x = obj_player.x - 5
			y = obj_player.y - 29
			image_angle = 270
			depth = 1
		}
	}
#endregion

#region attack
if !holstered
{
	if !holstered and obj_player.last_direction != 1 then depth = obj_player.depth - 1 else depth = -y
	
	var direction_attack = point_direction(x,y,mouse_x,mouse_y)
	var direction_interval = 30

	var direction_final = floor(direction_attack / direction_interval)

	var ang_dif = angle_difference(direction_attack,image_angle)
	if can_attack then image_angle += ang_dif * 0.25


	if mouse_check_button_pressed(mb_left) and can_attack
	{
		new_x += lengthdir_x(32,image_angle)
		new_y += lengthdir_y(32,image_angle)
		can_attack = false
	}

	if !can_attack and !can_retrieve
	{	
		x = lerp(x,new_x,0.3)
		y = lerp(y,new_y,0.3)
		attacking = true
		if abs(x - new_x) <= 10 and abs(y - new_y) <= 10
		{
			can_retrieve = true
			attacking = false
		}
	}

	if can_retrieve
	{
		timer++
		if timer >= 15
		{
			x = lerp(x,start_x,0.2)
			y = lerp(y,start_y,0.2)
			if timer >= 30
			{
				can_attack = true
				can_retrieve = false
				timer = 0
				new_x = x
				new_y = y
				depth = -y
			}
		}
	}
}
}
#endregion

#region damage
var nearest_wolf = instance_place(x,y,obj_wolf)

if !holstered
{
	if attacking
	{
		if place_meeting(x,y,nearest_wolf)
		{
			instance_destroy(nearest_wolf)
		}
	}
}