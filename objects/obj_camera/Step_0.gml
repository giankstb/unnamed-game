if keyboard_check_pressed(vk_f11)
{
    fullscreen = !fullscreen
}

window_enable_borderless_fullscreen(fullscreen)
window_set_fullscreen(fullscreen)

if instance_exists(obj_player) and follow = noone
{
	follow = obj_player
}

if !instance_exists(obj_player) and follow != noone
{
	follow = noone
}

if (follow != noone)
{
	x_to = follow.x;
	y_to = follow.y;
}

x += (x_to - x)/cam_follow_speed
y += (y_to - y)/cam_follow_speed

x = clamp(x, cam_width/2, room_width-cam_width/2)
y = clamp(y, cam_height/2, room_height-cam_height/2)

camera_set_view_pos(view_camera[0],x-cam_width/2,y-cam_height/2)