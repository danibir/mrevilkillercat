
draw_self()

if global.debug = true
{
	draw_set_colour(c_yellow)
	draw_set_alpha(0.4)
	draw_rectangle(
	x - colhitbox_side + max(0, xspeed), 
	y - colhitbox_top - min(0, yspeed), 
	x + colhitbox_side + min(0, xspeed), 
	y + colhitbox_bottom - max(0, yspeed), 
	false)
	draw_set_colour(c_white)
}