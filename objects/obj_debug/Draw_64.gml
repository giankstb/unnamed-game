draw_set_color(c_white)

var _y = 400
var _x = 10

for (var i = array_length(debug_messages) - 1; i >= 0; i--) {
    draw_text(_x, _y, debug_messages[i])
    _y += 16
}