/// @description Start connection 
global_variables_load();
force_reliable = global.is_browser; 

// Socket Config
socket = network_create_socket(network_socket_ws);
socket_reconnect = -1; // Used only for reconnecting (keep free glitch.com server alive)
url = "127.0.0.1";
port = 80;

// Connecting text
connecting = true;
connecting_t = 0;
connecting_text = "Connecting";

// Dialog
request_close = -1;

// Start Connection
try {
	network_connect_raw_async(socket, url, port);
} catch (ex) {
	connecting = false;
	connecting_text = ex.message;
}

#region Ping

ping = 0;			// Latency
ping_last_time = 0;	// Last (in ms)
ping_limit = 60000;	// Limit (in ms)

/// @function				sendPing(room)
/// @description			Send ping after some time
/// @param {Real} time		Time in frames
sendPing = function(time = 60) {
	alarm[0] = time;	
}

#endregion

#region Handle Received Message

message_function = ds_map_create();
var msg = message_function;
// Use the data.property ??= default_value to remove the warning (only referenced once)
msg[? "connect"] = function(data) {
	// It is only used for keeping the glitch server alive
	socket_reconnect = network_create_socket(network_socket_ws);
	network_connect_raw_async(socket_reconnect, url, port);
}

msg[? "ping"] = function(data) {
	ping = current_time - data.time;
	sendPing();	
}

msg[? "room_list"] = function(data) {
	data.rooms ??= [];
	if (room == rm_join_room) {
		rooms = data.rooms;
		gotoRoom(rm_join_room);
	}
}

msg[? "created_room"] = function(data) {
	gotoRoom(rm_game);
	player = createPlayer(data, true);
}

msg[? "joined_room"] = function(data) {
	gotoRoom(rm_game);
	player = createPlayer(data, true);
}

msg[? "deleted_room"] = function(data) {
	room_goto(rm_main);
	with (obj_player) {
		instance_destroy();	
	}
}

msg[? "player_state"] = function(data) {
	var p = getPlayer(data.id);
	if (p == noone) exit;
	p.addState(data);
	if (p.just_created) {
		instance_event_user(p, 0);
	}
}

msg[? "player_left"] = function(data) {
	with (obj_player) {
		if (client_id == data.client_id) {
			instance_destroy();
		}
	}
}

msg[? "error"] = function(data) {
	show_message(data.text);	
}

#endregion

global.selected_room_item = 0;

player = noone;
rooms = [];

// HTML5 only (Fix packet order)
next_frame = 0;
message_list = ds_list_create();

/// @function					createPlayer(data, is_me)
/// @description				Create new Player instance from data
/// @param {Struct} data		Player Data
/// @param {Bool} [is_me]		Am I controlling this player?
createPlayer = function(data, is_me = false) {
	var p = instance_create_depth(data.x, data.y, 0, obj_player);
	p.client_id = data.client_id;
	p.is_me = is_me;
	return p;
}
/// @function					getPlayer(player_id)
/// @description				Get player from ID
/// @param {Real} player_id		Player ID
getPlayer = function(pid) {
	if (pid < 0) return noone;
	for (var i = 0; i < instance_number(obj_player); i++) {
		var inst = instance_find(obj_player, i);
		if (inst.client_id == pid) return inst;
	}
	return createPlayer({ x: 0, y: 0, client_id: pid });
}
/// @function					gotoRoom(room)
/// @description				Go to the given room after 1 frame
/// @param room					Next Room
gotoRoom = function(rm) {
	next_room = rm
	alarm[2] = 1;
}

if (!global.is_mobile && !global.is_browser)
	window_set_size(room_width*2, room_height*2);

instance_create_depth(0, 0, 0, obj_mobile_buttons);