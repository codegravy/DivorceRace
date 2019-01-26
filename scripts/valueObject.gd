extends RigidBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var size = 1;
export var value = 1;
var bag_check
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	bag_check = get_node("CollisionShape/Area")
	pass

func dropped():
	var bodies = bag_check.get_overlapping_bodies()
	if len(bodies) > 0:
		for body in bodies:
			if ("bag" in body):
				if body.addItem(self.size,self.value):
					queue_free()
					break
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
