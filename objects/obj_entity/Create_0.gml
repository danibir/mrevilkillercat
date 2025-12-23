image_alpha = 0.4

sprite = instance_create_layer(x, y, "Instances", obj_sprite)
hitbox = instance_create_layer(x, y, "Instances", obj_hitbox)

sprite_state = ""
anim_walkin_max = 7
anim_walkin = 0
anim_walkout_max = 7
anim_walkout = 0

size = 1

xspeed = 0
yspeed = 0

collision_order = []

colhitbox_bottom = 0
colhitbox_side = 24
colhitbox_top = 56
slip = 4
stepclimb = 17


isGrounded = false
isMoving = false
facing = 1
frict = 0

function entity_move (topspeed, accel, turn)
{
	isMoving = true
	xspeed = lerp(0, topspeed, min(xspeed/topspeed + accel * global.time, 1))
	if turn = true
	{
		facing = sign(topspeed)
	}
}
function collide_terrain_order (list)
{
	for (var i = 0; i < array_length(list); i++)
		collide_terrain(list[i])
}
function collide_terrain (side)
{
	var contact
	var contact_list = ds_list_create()
	var xcenter = 0
	var ycenter = (colhitbox_top - colhitbox_bottom) / 2
	var vel_down = min(yspeed, 0) * -1
	var vel_up = max(yspeed, 0)
	var vel_left = min(xspeed, 0) * -1
	var vel_right = max(xspeed, 0)
	switch side
	{
		case "down":
		contact = collision_line_list(
		x - colhitbox_side - vel_left + min(colhitbox_side, slip), 
		y + colhitbox_bottom, 
		x + colhitbox_side + vel_right - min(colhitbox_side, slip), 
		y + colhitbox_bottom, 
		obj_terrain, true, false, contact_list, false)
		var contact_array = []
		for (var i = 0; i < ds_list_size(contact_list); i++) {
			contact_array[i] = ds_list_find_value(contact_list, i);
		}
		array_sort(contact_array, function(elm1, elm2){return elm1.y - elm2.y})
		if contact != 0 and yspeed <= 0
		{
			for (var i = 0; i < contact; i++)
			{
				var contactTerrain = contact_array[i]
				var ylevel = min(y, contactTerrain.bbox_top - colhitbox_bottom)
				y = lerp(y, ylevel, 0.6 * global.time)
				yspeed = 0
				isGrounded = true
				frict = contactTerrain.frict
			}
		}
		else
		{
			isGrounded = false
			frict = 0.01
		}
		break
		
		
		case "up":
		contact = collision_line(
		x - colhitbox_side - vel_left + min(colhitbox_side, slip), 
		y - colhitbox_top, 
		x + colhitbox_side + vel_right - min(colhitbox_side, slip), 
		y - colhitbox_top, 
		obj_terrain, true, false)
		if contact != noone and yspeed >= 0
		{
			y = contact.bbox_bottom + colhitbox_top
			yspeed /= 2
		}
		
		break
		
		
		case "left":
		contact = collision_line(
		x - colhitbox_side + xspeed * 1.2 * global.time, 
		y - colhitbox_top + vel_down + min(colhitbox_top, slip), 
		x - colhitbox_side + xspeed * 1.2 * global.time, 
		y + colhitbox_bottom - vel_down - stepclimb,
		obj_terrain, true, false)
		if contact != noone and xspeed <= 0
		{
			x = contact.bbox_right + colhitbox_side
			xspeed = 0
		}
		break
		
		
		case "right":
		contact = collision_line(
		x + colhitbox_side + xspeed * 1.2 * global.time, 
		y - colhitbox_top + vel_up + min(colhitbox_top, slip), 
		x + colhitbox_side + xspeed * 1.2 * global.time, 
		y + colhitbox_bottom - vel_down - stepclimb, 
		obj_terrain, true, false)
		if contact != noone and xspeed >= 0
		{
			x = contact.bbox_left - colhitbox_side
			xspeed = 0
		}
		break
	}
}