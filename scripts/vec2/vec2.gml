/// @function			vec2()
/// @description		Vector 2D.
/// @param {Real} [x]	X coordinate of the vector.
/// @param {Real} [y]	Y coordinate of the vector.
function vec2(_x = 0, _y = 0) constructor {
	x = _x;
	y = _y;
	/// @function						add()
	/// @description					Add this vector to another.
	/// @param {Struct.vec2} vector		Vector to sum.
	/// @returns {Struct.vec2}
	static add = function(v) {
		return new vec2(x + v.x, y + v.y);	
	}
	/// @function						copy()
	/// @description					Create a copy from this vector.
	/// @returns {Struct.vec2}
	static copy = function() {
		return new vec2(x, y);	
	}
}