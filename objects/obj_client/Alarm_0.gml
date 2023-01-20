/// @description Send Ping
network_send_data({
	type: "ping",
	time: current_time
});
ping_last_time = current_time;