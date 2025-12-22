
if isMoving = false
	xspeed -= lerp(0, xspeed * frict, global.time)
	
image_xscale = size * facing
image_yscale = size