event_inherited();
menu.pos = new vec2(room_width / 2 - 240, room_height / 2 - 120);
menu.setItemsPosition(new vec2(96, 64))

#region Name
input_name = new InputItem("Name", function(name) {
	show_debug_message(name)
});
input_name.value = "Room Name";
menu.addItem(input_name);
#endregion

#region Limit
input_limit = new InputItem("Limit", function(name) {
	show_debug_message(name)
});
input_limit.value = "10";
menu.addItem(input_limit);
#endregion

#region Create
menu.addItem(new Item("Create", function() {
	network_send_data({
		type: "create_room",
		name: input_name.value,
		limit: input_limit.value
	});
}));
#endregion

#region Back
menu.addItem(new Item("Back", function() {
	room_goto(rm_main);
}));
#endregion