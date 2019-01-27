extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var next_room = NodePath()
var global

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	global = get_node("/root/global")
	next_room = get_node(next_room).get_path()
	pass

func on_click(player):
	global.player.current_standing_point = next_room
	global.player.teleport_to_standing_point()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
