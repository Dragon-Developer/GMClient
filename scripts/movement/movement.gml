/// @function							move_x(speed, block)
/// @description						Move instance in x axis at the given speed until it collides.
/// @param {Real} speed					Movement speed.
/// @param {Asset.GMObject} [block]		Object to collide with.
/// @returns {Real}
function move_x(_speed, _block = obj_block) {
	if (place_meeting(x + _speed, y, _block)) {
		while (!place_meeting(x + sign(_speed), y, _block)) {
			x += sign(_speed);
		}
		_speed = 0;
	}
	x += _speed;
	return _speed;
}
/// @function							move_y(speed, block)
/// @description						Move instance in y axis at the given speed until it collides.
/// @param {Real} speed					Movement speed.
/// @param {Asset.GMObject} [block]		Object to collide with.
/// @returns {Real}
function move_y(_speed, _block = obj_block) {
	if (place_meeting(x, y + _speed, _block)) {
		while (!place_meeting(x, y + sign(_speed), _block)) {
			y += sign(_speed);
		}
		_speed = 0;
	}
	y += _speed;
	return _speed;
}