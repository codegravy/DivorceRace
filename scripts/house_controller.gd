extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var point1 = NodePath()
export var point2 = NodePath()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

sync func start_players():
	var standing = point1
	if get_tree().is_network_master():
		standing = point1
	else:
		standing = point2
	global.player.current_standing_point = standing
	global.player.teleport_to_standing_point()
		
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
