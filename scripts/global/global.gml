/// @function		global_variables_load()
/// @description	Defines global variables related to game settings.
function global_variables_load() {
	
	global.test_mode = false;

	global.is_mobile = os_type == os_android || os_type == os_ios;
	global.is_browser = browser_not_a_browser != os_browser;

	global.browser_h = 0;
	global.browser_w = 0;
	global.browser_ratio = 0;

	global.game_width = 448;
	global.game_height = 256;
	global.game_ratio = global.game_width / global.game_height;

}