event_inherited();
menu.pos = new vec2(room_width / 2 - 240, room_height / 2 - 120);

menu.addItem(new Item("Create Room", function() {
	room_goto(rm_create);
}));

menu.addItem(new Item("Search Room", function() {
	network_send_data({
		type: "search_room"
	});
	room_goto(rm_join_room);
}));

menu.addItem(new Item("Exit", function() {
	game_end();	
}));

