extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var peer
var players_ready = []
const server_ip = "129.244.99.153"
const PORT = 5553
const MAX_PLAYERS = 3
var global

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var players = Node.new()
	global = get_node('/root/global')
	players.set_name('players')
	get_tree().get_root().call_deferred("add_child",players)
	peer = NetworkedMultiplayerENet.new()
	var ips = IP.get_local_addresses()
	print(ips)
	if (server_ip in ips):
		startServer()
	else:
		startClient()
	players.add_child(global.player)
	global.player.set_name(str(peer.get_unique_id()))
	pass

func startServer():
	print("Starting Server")
	peer.create_server(PORT, MAX_PLAYERS)
	get_tree().set_network_peer(peer)
	get_tree().connect("network_peer_connected", self, "_client_connected")
	get_tree().connect("network_peer_disconnected", self, "_client_disconnected")
	pass
	
func startClient():
	print("Starting Client")
	peer.create_client(server_ip,5553);
	get_tree().set_network_peer(peer)
	get_tree().set_meta("network_peer",peer)
	get_tree().connect("network_peer_connected", self, "_client_connected")
	get_tree().connect("network_peer_disconnected", self, "_client_disconnected")

func _client_connected(id):
	print("Peer " + str(id) + " joined")
	var newPeer = load("res://elements/player/fakePlayer.tscn").instance()
	newPeer.set_name(str(id))
	get_node("/root/players").add_child(newPeer)
	
func _client_disconnected(id):
	print("Client " + str(id) + " disconnected")
	var newClient = get_node("/root/players/").get_node(str(id))
	get_node("/root/players/").remove_child(newClient)
	
sync func _player_ready(id):
	if peer.is_network_server():
		if !(id in players_ready):
			players_ready.append(id)
			print("Player " + str(id) + " readied up")
			if len(players_ready) > 1:
				global.start()
