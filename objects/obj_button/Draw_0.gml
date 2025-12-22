draw_self()
draw_set_alpha(1)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_set_color(textcolor)
var xcenter = (bbox_right - bbox_left) / 2 + bbox_left
var ycenter = (bbox_bottom - bbox_top) / 2 + bbox_top
draw_text(xcenter, ycenter, text)

if global.debug = true
{
	draw_set_alpha(0.5)
	draw_text(xcenter, ycenter + 15, state)
}