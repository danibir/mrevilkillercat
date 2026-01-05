sprite_state = "idle"

var myspeed = 5
var myaccel = 1/8
if isGrounded = false
	myaccel /= 2
if keyboard_check(ord("A"))
{
	sprite_state = "moving"
	entity_move(-myspeed, myaccel, true, false)
}
if keyboard_check(ord("D"))
{
	sprite_state = "moving"
	entity_move(myspeed, myaccel, true, false)
}
if keyboard_check_pressed(vk_space) and isGrounded = true
{
	yspeed = 13
	if isGrounded
		y--
	isJumping = true
}
if yspeed < 0
	isJumping = false
if isGrounded = false
{
	sprite_state = "air"
}
if not keyboard_check(vk_space) and isJumping = true
	yspeed *= 1 - 0.2 * global.time


switch sprite_state
{
	case "moving":
	anim_walkout = min(anim_walkout_max, anim_walkout_max - anim_walkin)
	sprite.sprite_index = spr_arrow
	anim_walkin -= 1 * global.time
	if anim_walkin >= 0
		sprite.sprite_index = spr_arrow_short
	break
	case "air":
	sprite.sprite_index = spr_circle
	anim_walkin = 0
	anim_walkout = 0
	anim_land = anim_land_max
	break
	case "idle":
	anim_walkin = anim_walkin_max
	sprite.sprite_index = spr_line
	anim_walkout -= 1 * global.time
	anim_land -= 1 * global.time
	if isMoving = true
		anim_land = -1
	if anim_land >= 0
		sprite.sprite_index = spr_flat
	if anim_walkout >= 0
		sprite.sprite_index = spr_arrow_back
	break
}

if keyboard_check(vk_shift)
{
	var _speed = 30
	xspeed = 0
	yspeed = 0
	if keyboard_check(ord("W"))
		yspeed = _speed
	if keyboard_check(ord("A"))
		xspeed = -_speed
	if keyboard_check(ord("S"))
		yspeed = -_speed
	if keyboard_check(ord("D"))
		xspeed = _speed
}

event_inherited()

