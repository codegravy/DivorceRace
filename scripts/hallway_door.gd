extends MeshInstance

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export var hallway = NodePath()
export var room = NodePath()


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func interact(player):
	if player.current_standing_point == hallway:
		player.current_standing_point = room
	else:
		player.current_standing_point = hallway
	player.teleport_to_standing_point()
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
