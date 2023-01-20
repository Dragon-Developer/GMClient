enum VK_KEY {
	LEFT,
	RIGHT,
	UP,
	DOWN,
	ENTER,
	JUMP,
	LENGTH
}
ignore_begin_step = false;
if (global.is_mobile) {
	var h = display_get_height();
	display_set_gui_size(h * global.game_ratio, h);	
}

global.has_released = true;

global.virtual_key[VK_KEY.LEFT] = -1;
global.virtual_key[VK_KEY.RIGHT] = -1;
global.virtual_key[VK_KEY.UP] = -1;
global.virtual_key[VK_KEY.DOWN] = -1;
global.virtual_key[VK_KEY.ENTER] = -1;
global.virtual_key[VK_KEY.JUMP] = -1;

global.key_equivalent[VK_KEY.LEFT] = vk_left;
global.key_equivalent[VK_KEY.RIGHT] = vk_right;
global.key_equivalent[VK_KEY.UP] = vk_up;
global.key_equivalent[VK_KEY.DOWN] = vk_down;
global.key_equivalent[VK_KEY.ENTER] = vk_enter;
global.key_equivalent[VK_KEY.JUMP] = vk_space;

for (var i = 0; i < VK_KEY.LENGTH; i++) {
	global.key[i] = false;
	global.key_pressed[i] = false;
	global.key_released[i] = false;
}