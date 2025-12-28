image_alpha = 0.4

hitbox = instance_create_layer(x, y, "Instances", obj_hitbox)
hitbox.depth--
sprite = instance_create_layer(x, y, "Entities", obj_sprite)
sprite.depth--

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
stepclimb = 18


isGrounded = false
isMoving = false
facing = 1
frict = 0

function entity_move (topspeed, accel, turn, force)
{
	if force = true or abs(topspeed) >= abs(xspeed)
	{
		isMoving = true
		xspeed = lerp(0, topspeed, min(xspeed/topspeed + accel * global.time, 1))
		if turn = true
		{
			facing = sign(topspeed)
		}
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
	var contact_array = []
	var collidesize = collide_get_size ()
	switch side
	{
		case "down":
		contact = collision_line_list(
		x + collidesize[? side][0], 
		y + collidesize[? side][1], 
		x + collidesize[? side][2], 
		y + collidesize[? side][3], 
		obj_terrain, true, false, contact_list, false)
		for (var i = 0; i < ds_list_size(contact_list); i++) {
			contact_array[i] = ds_list_find_value(contact_list, i);
		}
		array_sort(contact_array, function(elm1, elm2) {return elm1.y - elm2.y})
		if contact != 0 and yspeed <= 0
		{
			for (var i = 0; i < contact; i++)
			{
				var contactTerrain = contact_array[i]
				y -= yspeed
				var ylevel = min(y, contactTerrain.bbox_top - colhitbox_bottom)
				y = lerp(y, ylevel, 0.6 * global.time)
				if yspeed < - 10
					y = ylevel
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
		contact = collision_line_list(
		x + collidesize[? side][0], 
		y + collidesize[? side][1], 
		x + collidesize[? side][2], 
		y + collidesize[? side][3], 
		obj_terrain, true, false, contact_list, false)
		for (var i = 0; i < ds_list_size(contact_list); i++) {
			contact_array[i] = ds_list_find_value(contact_list, i);
		}
		array_sort(contact_array, function(elm1, elm2) {return elm2.y - elm1.y})
		if contact != 0 and yspeed >= 0
		{
			for (var i = 0; i < contact; i++)
			{
				var contactTerrain = contact_array[i]
				y -= yspeed
				var ylevel = max(y, contactTerrain.bbox_bottom + colhitbox_top)
				y = lerp(y, ylevel, 0.6 * global.time)
				if yspeed > 10
					y = ylevel
				yspeed /= 2
			}
		}
		
		break
		
		
		case "left":
		contact = collision_line_list(
		x + collidesize[? side][0], 
		y + collidesize[? side][1], 
		x + collidesize[? side][2], 
		y + collidesize[? side][3],
		obj_terrain, true, false, contact_list, false)
		for (var i = 0; i < ds_list_size(contact_list); i++) {
			contact_array[i] = ds_list_find_value(contact_list, i);
		}
		array_sort(contact_array, function(elm1, elm2) {return elm1.x - elm2.x})
		if contact != 0 and xspeed <= 0
		{
			for (var i = 0; i < contact; i++)
			{
				var contactTerrain = contact_array[i]
				x += xspeed
				var xlevel = max(x, contactTerrain.bbox_right + colhitbox_side)
				x = lerp(x, xlevel, 0.6 * global.time)
				if xspeed > 10
					y = xlevel
				xspeed /= 2
			}
		}
		break
		
		
		case "right":
		contact = collision_line_list(
		x + collidesize[? side][0], 
		y + collidesize[? side][1], 
		x + collidesize[? side][2], 
		y + collidesize[? side][3],
		obj_terrain, true, false, contact_list, false)
		for (var i = 0; i < ds_list_size(contact_list); i++) {
			contact_array[i] = ds_list_find_value(contact_list, i);
		}
		array_sort(contact_array, function(elm1, elm2) {return elm2.x - elm1.x})
		if contact != noone and xspeed >= 0
		{
			for (var i = 0; i < contact; i++)
			{
				var contactTerrain = contact_array[i]
				x += xspeed
				var xlevel = min(x, contactTerrain.bbox_left - colhitbox_side)
				x = lerp(x, xlevel, 0.6 * global.time)
				if xspeed < -10
					x = xlevel
				xspeed /= 2
			}
		}
		break
	}
	ds_list_destroy(contact_list)
	ds_map_destroy(collidesize)
}

function collide_get_size ()
{
	var xcenter = 0
	var ycenter = (colhitbox_top - colhitbox_bottom) / 2
	var vel_down = min(min(yspeed, 0) * -1, ycenter)
	var vel_up = min(max(yspeed, 0), ycenter)
	var vel_left = min(min(xspeed, 0) * -1, colhitbox_side)
	var vel_right = min(max(xspeed, 0), colhitbox_side)
	
	var map_down = [
		-colhitbox_side + vel_left + min(colhitbox_side, slip),
		colhitbox_bottom + vel_down,
		colhitbox_side - vel_right - min(colhitbox_side, slip),
		colhitbox_bottom + vel_down
	]
	var map_up = [
		-colhitbox_side + vel_left + min(colhitbox_side, slip), 
		-colhitbox_top - vel_up, 
		colhitbox_side - vel_right - min(colhitbox_side, slip), 
		-colhitbox_top - vel_up, 
	]
	var map_left = [
		-colhitbox_side - vel_left, 
		-colhitbox_top + vel_up + min(colhitbox_top, slip), 
		-colhitbox_side - vel_left, 
		colhitbox_bottom - vel_down - stepclimb,
	]
	var map_right = [
		colhitbox_side + vel_right, 
		-colhitbox_top + vel_up + min(colhitbox_top, slip), 
		colhitbox_side + vel_right, 
		colhitbox_bottom - vel_down - stepclimb,
	]
	
	var map = ds_map_create()
	ds_map_add(map, "down", map_down)
	ds_map_add(map, "up", map_up)
	ds_map_add(map, "left", map_left)
	ds_map_add(map, "right", map_right)
	
	return map
}