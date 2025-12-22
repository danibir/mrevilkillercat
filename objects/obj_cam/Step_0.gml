var view_width = default_view_width / zoom
var view_height = default_view_height / zoom
camera_set_view_size(cam, view_width, view_height)
camera_set_view_pos(cam, x - view_width / 2, y - view_height / 2)

if tug = true
{
	if mouse_check_button(mb_left)
	{
		var x_dif = tugx - mouse_x
		var y_dif = tugy - mouse_y
		x += x_dif
		y += y_dif
	}
	tugx = mouse_x
	tugy = mouse_y
}