extends RigidBody

func _ready():
	pass;

func _on_RigidBody_body_entered(body):
	if ("FLOOR" in body):
		var player = get_node("../Spatial2")
		player.setHand(true)
		print('player ready');
	pass # replace with function body
