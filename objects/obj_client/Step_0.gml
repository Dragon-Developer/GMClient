// These codes could be in a separate object or/and inside methods
// Connecting text
if (room == rm_connect && connecting) {
	connecting_t++;
	if (connecting_t >= 60) connecting_t = 0;
	connecting_text = "Connecting" + string_repeat(".", 1 + (connecting_t / 20));
}
// Toggle fullscreen
if (keyboard_check_pressed(vk_enter) && keyboard_check(vk_alt)) {
	window_set_fullscreen(!window_get_fullscreen());
}

// If we sent a ping and it is taking longer than the limit
if (ping_last_time != 0 && current_time - ping_last_time > ping_limit) {
	request_close = show_message_async("Disconnected");
	ping_last_time = 0;
	network_destroy(socket);
}

if (!global.is_browser) exit;
// Resize window and restart virtual keys if the user resized the brwoser
if (browser_width / browser_height != global.browser_ratio
|| global.browser_w != browser_width
|| global.browser_h != browser_height
) {
	global.browser_w = browser_width;
	global.browser_h = browser_height;
	global.browser_ratio = browser_width / browser_height;
	
	if (global.browser_ratio >= global.game_ratio) {
		window_set_size(browser_height * global.game_ratio, browser_height);
	} else {
		window_set_size(browser_width, browser_width / global.game_ratio);
	}
	with (btn_mobile) {
		restartVirtualKeys(true);	
	}
}