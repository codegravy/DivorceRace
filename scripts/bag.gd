extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var totalValue = 0;
var totalSize = 10;
var currentSize = 0;
export var bag = true
func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
func addItem(value,size):
	if currentSize + size <= totalSize:
		currentSize += size
		totalValue += value
		return true
	else:
		return false
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass