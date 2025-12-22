
//listener
if (mouse_x > bbox_left and mouse_x < bbox_right) and (mouse_y > bbox_top and mouse_y < bbox_bottom)
{
	state = "hover"
	if mouse_check_button_pressed(mb_left)
		active = true
	if active = true
	{
		if mouse_check_button(mb_left)
			state = "hold"
		if mouse_check_button_released(mb_left)
			state = "release"
	}
}
else
{
	state = "inactive"
	active = false
}

//logic
switch state
{
	case "inactive":
	image_blend = c_gray
	break
	case "hover":
	image_blend = c_white
	break
	case "hold":
	image_blend = c_ltgray
	break
	case "release":
	image_blend = c_dkgray
	break
}