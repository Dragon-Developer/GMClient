/// @function					network_send_data(data, [socket])
/// @description				Send data to server.
/// @param {Struct}	data		Struct that contains the data to be sent.
/// @param {Id.Socket} socket	Socket where the message will be sent.
function network_send_data(data, socket = obj_client.socket) {
	var buffer = buffer_create(1, buffer_grow, 1);
	buffer_write(buffer, buffer_text, json_stringify(data));
	network_send_raw(socket, buffer, buffer_tell(buffer), network_send_binary);
	buffer_delete(buffer);
}