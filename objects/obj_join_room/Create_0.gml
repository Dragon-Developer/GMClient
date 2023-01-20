event_inherited();
menu.pos = new vec2(room_width / 2 - 160, room_height / 2 - 120);
menu.setItemsPosition(new vec2(96, 48))

function setRooms(rooms) {
	
	for (var i = 0; i < array_length(rooms); i++) {
		menu.addItem(new RoomItem(rooms[i]));
	}
	menu.addItem(new Item("Back", function() {
		room_goto(rm_main);
	}));
	menu.selectItem(global.selected_room_item);
}

alarm[0] = 60;
setRooms(obj_client.rooms);