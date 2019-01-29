extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var peer
var players_ready = []
const PORT = 5553
const MAX_PLAYERS = 3
var global

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	global = get_node('/root/global')
	global.players = Node.new()
	global.players.set_name('players')
	get_tree().get_root().call_deferred("add_child",global.players)
	peer = NetworkedMultiplayerENet.new()
	var ips = IP.get_local_addresses()
	print(ips)
	global.player.set_name(str(peer.get_unique_id()))
	pass

func startServer(ui):
	print("Starting Server")
	peer.create_server(PORT, MAX_PLAYERS)
	get_tree().set_network_peer(peer)
	get_tree().connect("network_peer_connected", self, "_client_connected")
	get_tree().connect("network_peer_disconnected", self, "_client_disconnected")
	pass

func stopServer(ui):
	get_tree().set_network_peer(null)
	
func startClient(ip,ui):
	print("Starting Client")
	peer.create_client(ip,5553);
	get_tree().set_network_peer(peer)
	get_tree().set_meta("network_peer",peer)
	get_tree().connect("network_peer_connected", self, "_client_connected")
	get_tree().connect("network_peer_disconnected", self, "_client_disconnected")
	get_tree().connect("connected_to_server",ui,"_connected")
	get_tree().connect("connection_failed",ui,"_disconnected")
	get_tree().connect("server_disconnected",ui,"_disconnected")

func stopClient(ui):
	get_tree().set_network_peer(null)

func _client_connected(id):
	print("Peer " + str(id) + " joined")
	var newPeer = load("res://elements/player/fakePlayer.tscn").instance()
	newPeer.set_name(str(id))
	get_node("/root/players").add_child(newPeer)
	
func _client_disconnected(id):
	print("Client " + str(id) + " disconnected")
	var newClient = get_node("/root/players/").get_node(str(id))
	get_node("/root/players/").remove_child(newClient)
	
func player_ready():
	rpc('_player_ready',peer.get_unique_id())

sync func _player_ready(id):
	if get_tree().is_network_server():
		if !(id in players_ready):
			players_ready.append(id)
			print("Player " + str(id) + " readied up")
			if len(players_ready) > 1:
				global.start()
