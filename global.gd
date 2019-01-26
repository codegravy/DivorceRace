extends Node

# class member variables go here, for example:
# var a = 2

# var b = "textvar"
var player = load("res://elements/player/player.tscn").instance()
var bag = load("res://elements/player/playerBag.tscn").instance()
var hand = load("res://elements/player/playerHand.tscn").instance()
var vr = false
var peer = null

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	setupNetwork()
	var id = str(peer.get_unique_id())
	player.set_name(id)
	pass
	
func setupNetwork():
	peer = NetworkedMultiplayerENet.new()
	peer.create_client("129.244.99.101",5553);
	get_tree().set_network_peer(peer)
	get_tree().set_meta("network_peer",peer)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
