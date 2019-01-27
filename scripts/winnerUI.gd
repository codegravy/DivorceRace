extends Node

var global

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	global = get_node("/root/global")
	
	# Called when the node is added to the scene for the first time.
	# Initialization here

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	
	get_node("RichTextLabel").text = "Player One: " + str(global.player1Score)
	get_node("RichTextLabel2").text = "Player Two: " + str(global.player2Score)
