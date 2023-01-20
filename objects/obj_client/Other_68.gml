switch (async_load[? "type"]) {
	// Connecting
	case network_type_non_blocking_connect:
		try {
			if (async_load[? "id"] == socket_reconnect) {
				network_destroy(socket_reconnect);
				socket_reconnect = -1;
				exit;
			}
			// If it has connected, send ping
			if (async_load[? "succeeded"]) {
				show_debug_message("Connected!");
				sendPing();
				gotoRoom(rm_main);
			} else {
				connecting_text = "Couldn't connect to server!";
				connecting = false;
			}
		} catch (ex) {
			connecting_text = ex.message;
		}
		break;
	
	// Receive message
	case network_type_data:
		var buffer = async_load[? "buffer"];
		try {
			var json = buffer_read(buffer, buffer_text);
			var data = json_parse(json);
			data.f ??= next_frame;
			if (!force_reliable || data.f == next_frame) {
				next_frame++;
				// Handle received data based on its type
				if (ds_map_exists(message_function, data.type)) {
					message_function[? data.type](data);	
				}
			}
			// This frame comes sometime after the next one, so save it in the list
			else if (data.f > next_frame) {			
				// Insert data according to frame index
				var insert_index = 0;
				for (var i = 0; i < ds_list_size(message_list); i++) {
					var dt = message_list[| i];
					if (data.f <= dt.f) {
						break;	
					} else insert_index = i;
				}
				ds_list_insert(message_list, insert_index, data);
			}
			// Process all standby data 
			if (force_reliable) {
				while (ds_list_size(message_list)) {
					var dt = message_list[| 0];
					if (dt.f == next_frame) {
						message_function[? dt.type](dt);
						ds_list_delete(message_list, 0);
						next_frame++;
					} else break;
				}
			}
		} catch (ex) {
			show_debug_message(ex.message);
		}
		break;
}