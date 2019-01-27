extends RigidBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var size = 1;
export var value = 1;
var bag_check
slave var slave_transform = Transform()
slave var slave_ready = false
sync var picked_up = false
var global
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	bag_check = get_node("CollisionShape/Area")
	global = get_node("/root/global")
	global.connect("make_master",self,'make_master')
	pass

func dropped():
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
	set_network_master(get_tree().get_network_unique_id())
	rset('picked_up',true)
	return true

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
