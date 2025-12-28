
draw_self()

if global.debug = true
{
	var xcenter = 0
	var ycenter = (colhitbox_top - colhitbox_bottom) / 2
	var vel_down = min(min(yspeed, 0) * -1, ycenter)
	var vel_up = min(max(yspeed, 0), ycenter)
	var vel_left = min(min(xspeed, 0) * -1, colhitbox_side)
	var vel_right = min(max(xspeed, 0), colhitbox_side)
	draw_set_colour(c_yellow)
	draw_set_alpha(0.9)
	var collidesize = collide_get_size()
	var dirlist = ["down", "up", "left", "right"]
	for (var i = 0; i < 4; i++)
	draw_line_width(
		x + collidesize[? dirlist[i]][0], 
		y + collidesize[? dirlist[i]][1], 
		x + collidesize[? dirlist[i]][2], 
		y + collidesize[? dirlist[i]][3],
		2)
		
	ds_map_destroy(collidesize)
	draw_set_colour(c_white)
	draw_text(x, y - 100, [vel_down, vel_up, vel_left, vel_right])
	draw_text(x, y - 140, collision_order)
}