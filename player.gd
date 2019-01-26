extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass;
	
func setHand(setBag):
	var currentRightHand = get_node("ARVROrigin/rightHand").get_child(0);
	var global = get_node("/root/global");
	print(currentRightHand)
	get_node("ARVROrigin/rightHand").remove_child(currentRightHand);
	var newHand
	if setBag:
		newHand = global.bag
	else:
		newHand = global.hand
	get_node("ARVROrigin/rightHand").add_child(newHand)
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
