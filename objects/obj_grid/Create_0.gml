cell_size = 32

grid = mp_grid_create(0,0,room_width div cell_size,room_height div cell_size,cell_size,cell_size)

mp_grid_add_instances(grid,obj_wall,true)