// Connecting room
if (room == rm_connect) {
	draw_set_font(fnt_menu);
	draw_set_valign(fa_middle);
	draw_text(room_width / 2 - string_width("Connecting...") / 2, room_height / 2, connecting_text);
	draw_set_valign(fa_top);
}
// Any other room
else if (ping) {
	draw_set_halign(fa_right);
	draw_set_font(fnt_ping);
	draw_text(room_width - 16, 16, string(ping) + " ms");
	draw_set_halign(fa_left);
}