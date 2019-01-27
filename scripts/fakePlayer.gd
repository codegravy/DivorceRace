extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

remote func updatePlayerPositions(id,positions):
	var player = get_node("/root/players/").get_node(id)
	player.global_transform = positions.base
	get_node("VROrigin/PlayerCamera").global_transform = positions.camera
	get_node("VROrigin/leftHand").global_transform = positions.left
	get_node("VROrigin/rightHand").global_transform = positions.right
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
