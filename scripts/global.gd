extends Node

# class member variables go here, for example:
# var a = 2

# var b = "textvar"
var player = load("res://elements/player/player.tscn").instance()
var ready = false
var networking
var players_configured = []
var players

func _ready():
	networking = get_node("/root/networking")
		
func start():
	rpc("pre_configure_game")

sync func pre_configure_game():
	get_tree().set_pause(true)
	var myId = get_tree().get_network_unique_id()
	var world = load("res://House_layout.tscn").instance()
	var container = get_node("/root/container")
	container.queue_free()
	get_node("/root/").add_child(world)
	rpc_id(1,"done_preconfiguring",myId)

sync func done_preconfiguring(who):
	if get_tree().is_network_server():
		if !(who in players_configured):
			players_configured.append(who)
			print("Player " + str(who) + " is loaded")
			if len(players_configured) > 1:
				rpc('post_configure_game')

sync func post_configure_game():
	get_tree().set_pause(false)
