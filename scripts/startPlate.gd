extends RigidBody

func _ready():
	pass;

func _on_RigidBody_body_entered(body):
	if ("FLOOR" in body):
		var player = get_node("/root/global").player
		player.setHand(true)
		print('player ready');
		get_node('root/global').player_ready()
	pass # replace with function body
