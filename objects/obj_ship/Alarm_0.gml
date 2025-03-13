/// @description Collision timer handler
if alarm_collision_started = false
{
	alarm_collision_started = true
	alarm[0] = 2*60
}
else
{
	boat_stranded = true
}
