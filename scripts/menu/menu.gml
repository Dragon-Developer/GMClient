/// @function				Menu(x, y)
/// @description			Game Menu which contains items in a vertical list.
/// @param {Real} [x]		X axis
/// @param {Real} [y] 		Y axis
function Menu(_x = 0, _y = 0) constructor {
	draw_set_font(fnt_menu);
	items = ds_list_create();
	pos = new vec2(_x, _y);
	owner = noone;
	line_width = 2*string_height("A");
	next_item_pos = new vec2(16, 16);
	selected_index = 0;
	/// @function					getPos()
	/// @description				Get the menu's position
	/// @returns {Struct.vec2}
	static getPos = function() {
		return pos.copy();	
	}
	/// @function					setItemsPosition()
	/// @description				Set the position of next item
	/// @param {Struct.vec2} position
	static setItemsPosition = function(_position) {
		next_item_pos = _position;
	}
	/// @function					selectItem()
	/// @description				Select item from the given index
	/// @param {Real} index			Item index
	static selectItem = function(index) {
		var size = ds_list_size(items);
		if (index < size) {
			selected_index = index;	
		}
		for (var i = 0; i < size; i++) {
			var item = items[| i];
			item.text_color = (i == index) ? item.text_selected_color : item.text_normal_color;
		}
	}
	/// @function					step()
	/// @description				Move in the menu 
	/// @param {Real} direction		Movement direction (UP = -1, DOWN = 1)
	static step = function(_direction) {
		_direction = sign(_direction);
		selectItem(clamp(selected_index + _direction, 0, ds_list_size(items) - 1));
	}
	/// @function					addItem()
	/// @description				Add new Item to the Menu.
	/// @param {Struct.Item} item	Menu Item.
	static addItem = function(item) {
		ds_list_add(items, item);
		item.owner = self;
		item.pos = next_item_pos.copy();
		next_item_pos.y += line_width;	
		selectItem(0);
	}
	/// @function					setTitle()
	/// @description				Set the title item.
	/// @param {Struct.Item} item	Title Item.
	static setTitle = function(item) {
		title = item;
		title.owner = self;
	}
	/// @function					draw()
	/// @description				Draw Menu.
	static draw = function() {
		title.draw();
		for (var i = 0, size = ds_list_size(items); i < size; i++) {
			items[| i].draw();	
		}
	}
	/// @function					executeSelectedItem()
	/// @description				Execute the selected item.
	static executeSelectedItem = function() {
		if (selected_index >= ds_list_size(items)) exit;
		if (is_undefined(items[| selected_index].run)) exit;
		items[| selected_index].run();
	}
	setTitle(new Item(""));
	setItemsPosition(new vec2(192, 80));
}

/// @function					Item(text, func)
/// @description				Menu Item.
/// @param {String}   text		Display text.
/// @param {Function} [func]	Function this item will execute.
function Item(_text, _func = undefined) constructor {
	text = _text;
	text_normal_color = c_white;
	text_selected_color = 0x3bb143;
	text_color = text_normal_color;
	pos = new vec2();
	owner = noone;
	run = _func;
	request_id = -1;
	/// @function				getPos()
	/// @description			Get the Item's position.
	/// @returns {Struct.vec2}
	static getPos = function() {
		if (owner != noone) {
			return pos.add(owner.getPos());	
		}
		return pos.copy();
	}
	/// @function				draw()
	/// @description			Draw Item.
	static draw = function() {
		draw_set_font(fnt_menu);
		var p = self.getPos();
		draw_set_color(text_color);
		draw_text(p.x, p.y, text);
		draw_set_color(c_white);
	}
}
/// @function				RoomItem(data)
/// @description			Menu Item that contains info from a hosted room and allow players to connect to it.
/// @param {Struct} data	Room data (name, playerTotal, limit, id).
function RoomItem(_data) : Item("") constructor {
	data = _data;
	data.playerTotal ??= 0;
	text = data.name + " (" + string(data.playerTotal) + "/" + string(data.limit) + ")";
	/// @function				run()
	/// @description			Connect to room
	run = function() {
		network_send_data({
			type: "join_room",
			id: data.id
		});
	}
}
/// @function					InputItem(text, func)
/// @description				This item gets the user input and runs an function when the user confirms.
/// @param {String}	text		Display text.
/// @param {Function} [func]	Function this item will execute.
function InputItem(_text, _func = undefined) : Item(_text, _func) constructor {
	func = _func;
	value = "";
	question = "";
	value_offset = new vec2(200, 0);
	/// @function				run()
	/// @description			Get user input and set it as the value.
	run = function() {
		request_id = get_string_async(question, value);
	}
	/// @function				draw()
	/// @description			Draw text and value.
	static draw = function() {
		// Draw text
		draw_set_font(fnt_menu);
		draw_set_color(text_color);
		var p = getPos();
		draw_text(p.x, p.y, text);
		// Draw value
		p = p.add(value_offset);
		draw_text(p.x, p.y, value);
		draw_set_color(c_white);
	}
}