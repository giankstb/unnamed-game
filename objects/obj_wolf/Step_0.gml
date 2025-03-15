#region chasing
if collision_line(x,y,obj_player.x,obj_player.y,obj_wall,true,false)
{
	can_attack_1_phase = false  //Condição inteira para impedir o inimigo de atacar se
	can_attack_2_phase = false  //Tiver uma parede no caminho, pra não entrar dentro da parede
	attacking = false                      //quando atacar
	new_x = x
	new_y = y
	cooldown_attack = 100
}

if !chasing and !can_attack_1_phase or !can_attack_2_phase or !attacking 
and distance_to_object(obj_player) < 96 then chasing = true

if chasing = true
{
	if !attacking or can_attack_1_phase or can_attack_2_phase
	{
		x_goal = obj_player.x
		y_goal = obj_player.y
	}
	else
	{
		x_goal = x
		y_goal = y
	}
	
	if mp_grid_path(obj_grid.grid,path,x,y,x_goal,y_goal,true)
	{
		path_start(path,spd,path_action_stop,false)
	}
}
#endregion

#region attack cooldown
if chasing
{
	if cooldown_attack > 0 then cooldown_attack--
}

if cooldown_attack == 0 then can_attack_1_phase = true
#endregion

#region attacking
if can_attack_1_phase and distance_to_object(obj_player) < 72
{
	cooldown_attack = 100
	chasing = false
	can_attack_1_phase = false
	can_attack_2_phase = true
}

if can_attack_2_phase
{
	direction = point_direction(x,y,obj_player.x,obj_player.y)
	attacking = true
	can_attack_2_phase = false
	new_x = x
	new_y = y
	new_x += lengthdir_x(jump_size,direction)
	new_y += lengthdir_y(jump_size,direction)
}

if attacking
{
	x = lerp(x,new_x,0.05)
	y = lerp(y,new_y,0.05)
	if (new_x - x) < 5 and (new_y - y) < 5
	{
		cooldown_attack = 100
		attacking = false
	}
}
#endregion

