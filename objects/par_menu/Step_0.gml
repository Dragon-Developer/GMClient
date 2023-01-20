menu.step(global.key_pressed[VK_KEY.DOWN] - global.key_pressed[VK_KEY.UP]);
if (global.has_released && global.key_pressed[VK_KEY.ENTER]) {
	menu.executeSelectedItem();
	global.has_released = false;
}