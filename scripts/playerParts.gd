extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

slave var slave_transform = Transform()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if global.peer.get_connection_status() == 2:
		rset_unreliable("slave_transform",self.global_transform)
