if (ignore_begin_step) {
	ignore_begin_step--;
	exit;
}
if (global.key_released[VK_KEY.ENTER] )
	global.has_released = true;

for (var i = 0; i < VK_KEY.LENGTH; i++) {
	var last = global.key[i];
	global.key[i] = keyboard_check(global.key_equivalent[i]);
	global.key_pressed[i] = (!last && global.key[i]);
	global.key_released[i] = (last && !global.key[i]);
}