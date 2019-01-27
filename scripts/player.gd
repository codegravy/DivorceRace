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
func _process(delta):
	if global.peer.get_connection_status() == 2:
		rset_unreliable("global_transform",global_tranform)