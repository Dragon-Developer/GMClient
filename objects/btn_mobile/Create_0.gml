image_speed = 0;
key_id = image_index;
rect = [x, y, bbox_right - x, bbox_bottom - y];
depth = -200;
image_alpha = 0.35;
visible = global.is_mobile;
function restartVirtualKeys(force_delete = false) {
	if (!global.is_mobile) exit;
	var r = [rect[0], rect[1], rect[2], rect[3]];
	var ratio = display_get_height() / 256;
	if (global.is_browser) {
		ratio = browser_height / 256;
	}
	for (var i = 0; i < 4; i++) {
		r[i] *= ratio;	
	}
	if (global.virtual_key[key_id] != -1 && force_delete) virtual_key_delete(global.virtual_key[key_id]);
	global.virtual_key[key_id] = virtual_key_add(r[0], r[1], r[2], r[3], global.key_equivalent[key_id]);	
}
restartVirtualKeys();