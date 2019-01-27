extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	var vr = ARVRServer.find_interface("OpenVR")
	if vr and vr.initialize():
		get_viewport().arvr = true
		get_viewport().hdr = false
		OS.vsync_enabled = false
		Engine.target_fps = 90
		
	pass

func createMultiPlayer(id):
	pass
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
