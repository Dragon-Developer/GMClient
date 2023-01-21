just_created = false;
if (!is_me) {
	event_user(0);
	exit;
}
// Keys
axis_h = global.key[VK_KEY.RIGHT] - global.key[VK_KEY.LEFT];
axis_v = global.key[VK_KEY.DOWN] - global.key[VK_KEY.UP];

if (axis_h != 0) {
	image_speed = 1;
	xscale = axis_h;
} else {
	image_index = 0;
	image_speed = 0;
}
// Horizontal Movement
h_speed = walk_speed * axis_h;
// Jump
if (global.key_pressed[VK_KEY.JUMP] && place_meeting(x, y + 1, obj_block)) {
	v_speed = -6;	
}
// Gravity
v_speed = clamp(v_speed + grav, -6, 6);
// Check collision and move
h_speed = move_x(h_speed);
v_speed = move_y(v_speed);

if (x < -16) x = room_width;
if (x > room_width) x = -16;
var _x = x;
var _y = y;
network_send_data({
	type: "player_state",
	x: _x,
	y: _y,
	xscale: xscale,
	sprite: sprite_index,
	index: image_index
});

obj_camera.target = id;
instance_event_user(obj_camera, 0);