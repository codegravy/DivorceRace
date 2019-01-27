extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var global

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	global = get_node("/root/global");
	pass;
	
func setHand(setBag):
	var currentRightHand = get_node("VROrigin/rightHand").get_child(0);
	print(currentRightHand)
	get_node("VROrigin/rightHand").remove_child(currentRightHand);
	var newHand
	if setBag:
		newHand = global.bag
	else:
		newHand = global.hand
	get_node("VROrigin/rightHand").add_child(newHand)
#func _process(delta):
#	var positions = {}
#	positions.base = self.global_transform
#	positions.camera = get_node("VROrigin/PlayerCamera").global_transform
#	positions.left = get_node("VROrigin/leftHand").global_transform
#	positions.right = get_node("VROrigin/rightHand").global_transform
#	print(positions)
	#rpc_unreliable("updatePlayerPositions",str(global.peer.get_unique_id()),positions)
#remote func updatePlayerPositions(id,positions):
#	var player = get_node("/root/players/").get_node(id)
#	player.global_transform = positions.base
#	get_node("VROrigin/PlayerCamera").global_transform = positions.camera
#	get_node("VROrigin/leftHand").global_transform = positions.left
#	get_node("VROrigin/rightHand").global_transform = positions.right