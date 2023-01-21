/// @function									instance_event_user(inst, numb)
/// @description								Run event user in the given instance.
/// @param {Id.Instance OR Asset.GMObject} id	Instance where to run the user event.
/// @param {Real} numb							Number of the event you want to run.
function instance_event_user(_id, _numb) {
	with (_id) {
		event_user(_numb);	
	}
}