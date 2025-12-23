
if isMoving = false
	xspeed -= lerp(0, xspeed * frict, global.time)
	
image_xscale = size * facing
image_yscale = size

hitbox.x = x
hitbox.y = y
sprite.x = x
sprite.y = y
sprite.image_xscale = image_xscale
sprite.image_yscale = image_yscale