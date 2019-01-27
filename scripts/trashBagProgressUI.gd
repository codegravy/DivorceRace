extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var global

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	global = get_node('/root/global')
	get_node("ProgressBar").max_value = global.player.bag.total

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	get_node("ProgressBar").value = global.player.bag.current
