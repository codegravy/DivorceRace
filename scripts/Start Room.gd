extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func update_preview_size():
	var new_size = OS.window_size
	$ViewportContainer/Viewport.size = new_size

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	update_preview_size()
	get_tree().get_root().connect("size_changed", self, "update_preview_size")
	pass
