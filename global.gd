extends Node

# class member variables go here, for example:
# var a = 2

# var b = "textvar"
var player = load("res://elements/player/player.tscn").instance()
var bag = load("res://elements/player/playerBag.tscn").instance()
var hand = load("res://elements/player/playerHand.tscn").instance()
var players = Node.new();
var vr = false
var peer = null

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var global = get_node("/root/global")
	var root = get_node("/root/")
	var vr = ARVRServer.find_interface("OpenVR")
	players.set_name("players")
	root.call_deferred("add_child",players)
	if vr and vr.initialize():
		get_viewport().arvr = true
		get_viewport().hdr = false
		OS.vsync_enabled = false
		Engine.target_fps = 90
		global.vr = true
		players.add_child(global.player)
	setupNetwork()
	var id = str(peer.get_unique_id())
	player.set_name(id)
	pass
	
func setupNetwork():
	peer = NetworkedMultiplayerENet.new()
	peer.create_client("129.244.99.101",5553);
	get_tree().set_network_peer(peer)
	get_tree().set_meta("network_peer",peer)

	
func ready():
	rpc_id(1, "player_ready", str(peer.get_unique_id()))
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
