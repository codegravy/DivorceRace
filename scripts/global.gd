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
	var vr = ARVRServer.find_interface("OpenVR")
	setupNetwork()
	if vr and vr.initialize():
		get_viewport().arvr = true
		get_viewport().hdr = false
		OS.vsync_enabled = false
		Engine.target_fps = 90
		global.vr = true
		global.player.set_name(str(get_tree().get_network_unique_id()))
		get_node("/root/container/players/").add_child(global.player)
	pass
	
func setupNetwork():
	peer = NetworkedMultiplayerENet.new()
	peer.create_client("129.244.99.101",5553);
	get_tree().set_network_peer(peer)
	get_tree().set_meta("network_peer",peer)
	get_tree().connect("network_peer_connected", self, "_client_connected")
	get_tree().connect("network_peer_disconnected", self, "_client_disconnected")

	
remote func ready():
	global.player.set_network_master(get_tree().get_network_unique_id())
	print(global.player.is_network_master())
func _client_connected(id):
	if id == peer.get_unique_id() || id == 1:
		return;
	print("Peer " + str(id) + " joined")
	var newPeer = load("res://elements/player/fakePlayer.tscn").instance()
	newPeer.set_name(str(id))
	get_node("/root/container/players").add_child(newPeer)
	
func _client_disconnected(id):
	print("Client " + str(id) + " disconnected")
	var newClient = get_node("/root/players/").get_node(str(id))
	get_node("/root/container/players/").remove_child(newClient)
remote func existing_players(players):
	for player in players:
		var id = player
		print("Peer " + str(id) + " joined")
		var newPeer = load("res://elements/player/fakePlayer.tscn").instance()
		newPeer.set_name(str(id))
		get_node("/root/container/players").add_child(newPeer)
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
