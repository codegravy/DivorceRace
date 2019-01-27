extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

slave var slave_transform = Transform()

func _process(delta):
	if networking.peer.get_connection_status() == 2:
		rset_unreliable("slave_transform",self.global_transform)
