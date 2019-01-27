extends RigidBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var size = 1;
export var value = 1;
var bag_check
slave var slave_transform = Transform()
sync var picked_up = false
var global
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	bag_check = get_node("CollisionShape/Area")
	global = get_node("/root/global")
	pass

func dropped():
	print(get_network_master())
	if is_network_master():
		rset('picked_up',false)
		var bodies = bag_check.get_overlapping_bodies()
		if len(bodies) > 0:
			for body in bodies:
				if ("bag" in body):
					if body.addItem(self.size,self.value):
						rpc("remove")
						break

sync func remove():
	queue_free()

func pickup():
	if picked_up:
		return false
	rpc('change_owner',get_tree().get_network_unique_id())
	return true
		
sync func change_owner(id):
	set_network_master(id)
	picked_up = true

func _process(delta):
	if is_network_master():
		print("updating")
		rset_unreliable("slave_transform",global_transform)
	else:
		self.global_transform = slave_transform
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
