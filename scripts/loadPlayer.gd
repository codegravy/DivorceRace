extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var global

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	global = get_node('/root/global')
	var vr = ARVRServer.find_interface("OpenVR")
	if vr and vr.initialize():
		get_viewport().arvr = true
		get_viewport().hdr = false
		OS.vsync_enabled = false
		Engine.target_fps = 90
		global.players.add_child(global.player)
		global.vr = true
	else:
		global.player = load("res://elements/player/spectator.tscn").instance()
		global.players.add_child(global.player)

func createMultiPlayer(id):
	pass
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
