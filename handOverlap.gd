extends ARVRController

var controller_velocity = Vector3(0,0,0)
var prior_controller_position = Vector3(0,0,0)
var prior_controller_velocities = []

var held_object = null
var held_object_old_mode
var grab_area
var hand_mesh
var grab_pos_node

func _ready():
	grab_area = get_node("Spatial/Area")
	hand_mesh = get_node("Spatial/HandMesh")
	grab_pos_node = get_node("Spatial")

func _button_down(button):
	print(button)
	if button == 15:
		if held_object == null:
			var rigid_body = null;
			var bodies = grab_area.get_overlapping_bodies()
			if len(bodies) > 0:
				for body in bodies:
					if body is RigidBody:
						if !("NO_PICKUP" in body):
							rigid_body = body
							break
			if rigid_body != null:
				held_object = rigid_body
				held_object_old_mode = held_object.mode
				held_object.mode = RigidBody.MODE_STATIC
				hand_mesh.visible = false
				if ("controller" in held_object):
					held_object.controller = self

func _button_up(button):
	if held_object != null:
		if held_object.has_method("dropped"):
			held_object.dropped()
		held_object.mode = RigidBody.MODE_RIGID
		held_object.apply_impulse(Vector3(0, 0, 0), controller_velocity)
		held_object = null
		hand_mesh.visible = true

func _physics_process(delta):
	if get_is_active() == true:
		controller_velocity = Vector3(0,0,0)
		if prior_controller_velocities.size() > 0:
			for vel in prior_controller_velocities:
				controller_velocity += vel
			controller_velocity = controller_velocity / prior_controller_velocities.size()
		prior_controller_velocities.append((global_transform.origin - prior_controller_position) /delta)
		controller_velocity += (global_transform.origin - prior_controller_position) /delta
		prior_controller_position = global_transform.origin
		
		if prior_controller_velocities.size() > 30:
			prior_controller_velocities.remove(0)
	if held_object != null:
		var held_scale = held_object.scale
		held_object.global_transform = grab_pos_node.global_transform
		held_object.scale = held_scale