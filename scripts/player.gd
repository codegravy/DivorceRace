extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var global

var current_standing_point = null
var current_total = 0;
var bag = load("res://elements/player/playerBag.tscn").instance()
var hand = load("res://elements/player/playerHand.tscn").instance()

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
		newHand = bag
	else:
		newHand = hand
	get_node("VROrigin/rightHand").add_child(newHand)

func _process(delta):
	if global.peer.get_connection_status() == 2:
		rset_unreliable("slave_transform",self.global_transform)

func teleport_to_standing_point():
	if current_standing_point!=null:
		var newLoc = get_ndoe(current_standing_point).global_translate
		self.global_transform = newLoc
		
func reset():
	current_total = 0;
	current_standing_point = null;
