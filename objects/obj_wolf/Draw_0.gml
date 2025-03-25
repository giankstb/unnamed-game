draw_self()

draw_path(path,x,y,false)
draw_circle(x,y-(sprite_height / 2),detection_radius,true)
draw_circle_color(x,y-(sprite_height / 2),detection_radius div 2, c_red,c_red,true)

switch(ai_state) {
    case 0:
        draw_text(x,y-40,"IDLE")
    break;
    
    case 1:
        draw_text(x,y-40,"WALKING")
    break;
    
    case 2:
        draw_text(x,y-40,"RUNNING")
    break;
    
    case 3:
        draw_text(x,y-40,"ATTACKING")
    break;
    
    case 4:
        draw_text(x,y-40,"WANDERING")
    break;
    
    case 5:
        draw_text(x,y-40,"PREPARING")
    break;
}

draw_text(x,y-60,string(timer))