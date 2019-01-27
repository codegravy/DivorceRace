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
var ready = false

signal make_master

var rooms = {
	"test":"res://testScene.tscn"
}

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var vr = ARVRServer.find_interface("OpenVR")
	setupNetwork()
	if vr and vr.initialize():
		get_viewport().arvr = true
		get_viewport().hdr = false
		OS.vsync_enabled = false
		Engine.target_fps = 90
		vr = true
		player.set_name(str(get_tree().get_network_unique_id()))
		get_node("/root/container/players/").add_child(player)
	pass
	
func setupNetwork():
	peer = NetworkedMultiplayerENet.new()
	peer.create_client("129.244.99.101",5553);
	get_tree().set_network_peer(peer)
	get_tree().set_meta("network_peer",peer)
	get_tree().connect("network_peer_connected", self, "_client_connected")
	get_tree().connect("network_peer_disconnected", self, "_client_disconnected")
	
func player_ready():
	rpc_id(1,"player_ready",get_tree().get_network_unique_id())
	
remote func ready():
	player.set_network_master(get_tree().get_network_unique_id())
	ready = true
	print(player.is_network_master())
func _client_connected(id):
	if id == peer.get_unique_id() || id == 1:
		return;
	print("Peer " + str(id) + " joined")
	var newPeer = load("res://elements/player/fakePlayer.tscn").instance()
	newPeer.set_name(str(id))
	get_node("/root/container/players").add_child(newPeer)
	
func _client_disconnected(id):
	print("Client " + str(id) + " disconnected")
	var newClient = get_node("/root/container/players/").get_node(str(id))
	get_node("/root/container/players/").remove_child(newClient)
remote func existing_players(players):
	for player in players:
		var id = player
		print("Peer " + str(id) + " joined")
		var newPeer = load("res://elements/player/fakePlayer.tscn").instance()
		newPeer.set_name(str(id))
		get_node("/root/container/players").add_child(newPeer)
		
remote func pre_configure_game(id):
	get_tree().set_pause(true)
	var myId = get_tree().get_network_unique_id()
	var world = load(rooms[id]).instance()
	var container = get_node("/root/container/level_container")
	container.get_child(0).queue_free()
	container.add_child(world)
	rpc_id(1,"done_preconfiguring",myId)
	
remote func make_master():
	emit_signal("make_master")
	
remote func post_configure_game():
	get_tree().set_pause(false)
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
