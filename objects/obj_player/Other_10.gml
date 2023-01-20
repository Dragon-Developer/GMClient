/// @description Remove repeated positions
if (ds_list_size(pos_list) > 0) {
	var p = pos_list[| 0];
	while (ds_list_size(pos_list) > 1) {
		if (pos_list[| 1].x == p.x && pos_list[| 1].y == p.y) {
			ds_list_delete(pos_list, 1);	
		} else break;
	}
}
while (ds_list_size(pos_list) > pos_max_limit) {
	ds_list_delete(pos_list, 0);	
}
if (ds_list_size(pos_list) >= pos_limit) {
	pos_delete_frequency = 2;
}
else if (ds_list_size(pos_list) <= pos_limit / 2) {
	pos_delete_frequency = 1;
}
if (ds_list_size(pos_list) > 0) {
	var s = pos_list[| 0];
	x = s.x;
	y = s.y;
	xscale = s.xscale;
	sprite_index = s.sprite;
	image_index = s.index;
	repeat(pos_delete_frequency) {
		if (ds_list_size(pos_list) > 1)
			ds_list_delete(pos_list, 0);
	}
}