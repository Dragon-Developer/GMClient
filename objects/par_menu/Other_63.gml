var dialog_id = async_load[? "id"];
var dialog_status = async_load[? "status"];
var dialog_result = "";
if (dialog_status)
	dialog_result = async_load[? "result"];
for (var i = 0, size = ds_list_size(menu.items); i < size; i++) {
	if (dialog_id == menu.items[| i].request_id) {
		if (dialog_status) {
			menu.items[| i].value = dialog_result;
			menu.items[| i].func(dialog_result);
		}
	}
}