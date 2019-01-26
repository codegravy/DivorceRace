extends Node

# class member variables go here, for example:
# var a = 2

# var b = "textvar"
var player = load("res://elements/player/player.tscn").instance()
var bag = load("res://elements/player/playerBag.tscn").instance()
var hand = load("res://elements/player/playerHand.tscn").instance()
var vr = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func setupNetwork():
	var peer = NetworkedMultiplayerEnet.new()
	peer.create_client("129.244.99.101",5556);
	get_tree().set_network_peer(peer)
	get_tree().set_meta("network_peer",peer)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
