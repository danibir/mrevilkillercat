zoom = 1
default_view_width = 1600
default_view_height = 900

tug = false
tugx = x
tugy = y

cam = camera_create()
camera_set_view_pos(cam, x - default_view_width / 2, y - default_view_height / 2)
camera_set_view_size(cam, default_view_width * zoom, default_view_height * zoom)
camera_apply(cam)
view_set_camera(0, cam)
view_set_visible(0, true)
view_enabled = true