
slip = lerp(8, 12, ((abs(xspeed) + abs(yspeed)) / 50))

if !isGrounded
	yspeed -= global.gravity * global.time

x += xspeed * global.time
y -= yspeed * global.time

var xaxis = ["right", "left"]
if xspeed < 0
	xaxis = [xaxis[1], xaxis[0]]
var yaxis = ["up", "down"]
if yspeed <= 0
	yaxis = [yaxis[1], yaxis[0]]

	

if abs(xspeed) <= abs(yspeed) {
	collision_order = [yaxis[0], xaxis[0], yaxis[1], xaxis[1]]
} else {
	collision_order = [xaxis[0], yaxis[0], xaxis[1], yaxis[1]]
}
collide_terrain_order(collision_order)