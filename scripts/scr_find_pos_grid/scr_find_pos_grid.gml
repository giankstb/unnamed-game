// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function find_pos_grid(){
    for (var i = 0; i < obj_map_grid.magarnan_map_grid_height; i++) {
        for (var j = 0; j < obj_map_grid.magarnan_map_grid_width; j++) {
            if obj_map_grid.magarnan_map_grid[i, j] == room {
                return [i, j]
            }
        }
    }
    return [-1, -1]
}