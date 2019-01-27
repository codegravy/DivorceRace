extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var peer
var players_ready = []

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var players = Node.new()
	players.set_name('players')
	get_tree().get_root().add_child(players)
	pass

func startServer():
	pass
	
func startClient(ip):
	peer = NetworkedMultiplayerENet.new()
	peer.create_client("129.244.99.101",5553);
	get_tree().set_network_peer(peer)
	get_tree().set_meta("network_peer",peer)
	get_tree().connect("network_peer_connected", self, "_client_connected")
	get_tree().connect("network_peer_disconnected", self, "_client_disconnected")

func _client_connected(id):
	if id == peer.get_unique_id() || id == 1:
		return;
	print("Peer " + str(id) + " joined")
	var newPeer = load("res://elements/player/fakePlayer.tscn").instance()
	newPeer.set_name(str(id))
	get_node("/root/players").add_child(newPeer)
	
func _client_disconnected(id):
	print("Client " + str(id) + " disconnected")
	var newClient = get_node("/root/players/").get_node(str(id))
	get_node("/root/players/").remove_child(newClient)
	
remote func _player_ready(id):
	if peer.is_network_server():
		if !(id in players_ready):
			players_ready.append(id)
			print("Player " + str(id) + " readied up")
			if len(players_ready) > 1:
				rpc("start_game")
				
sync func start_game():
	global.start_game(players_ready)
