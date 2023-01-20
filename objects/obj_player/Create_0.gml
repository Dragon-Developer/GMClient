is_me = false;
client_id = -1;

color = c_blue;

xscale = 1;
yscale = 1;
image_speed = 0;
walk_speed = 4;
grav = 0.25;
h_speed = 0;
v_speed = 0;

axis_h = 0;
axis_v = 0;

pos_list = ds_list_create();
pos_limit = 20;
pos_max_limit = 40;
pos_delete_frequency = 1;

/// @function				addState(state)
/// @description			Insert state to list in order to make the movement smoother.
/// @param {Struct} state	New State.
addState = function(_state) {
	ds_list_add(pos_list, {
		x: _state.x,
		y: _state.y,
		xscale: _state.xscale,
		sprite: _state.sprite,
		index: _state.index
	});
}

just_created = true;

/// @function				userEvent(numb)
/// @description			Execute user event.
/// @param {Real} numb		Event Number.
userEvent = function(numb) {
	event_user(numb);
	just_created = false;
}