extends RigidBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var size = 1;
export var value = 1;
var bag_check
slave var slave_transform = Transform()
slave var slave_ready = false
var global
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	bag_check = get_node("CollisionShape/Area")
	global = get_node("/root/global")
	pass

func dropped():
	var bodies = bag_check.get_overlapping_bodies()
	print(is_network_master())
	if len(bodies) > 0:
		for body in bodies:
			if ("bag" in body):
				if body.addItem(self.size,self.value):
					rpc("remove")
					break

sync func remove():
	queue_free()
func _process(delta):
	if is_network_master():
		rset_unreliable("slave_transform",global_transform)
		rset_unreliable("slave_ready",true)
	else:
		if slave_ready:
			self.global_transform = slave_transform
			slave_ready = false
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
