extends Node

# class member variables go here, for example:
# var a = 2

# var b = "textvar"
var player = load("res://elements/player/player.tscn").instance()
var bag = load("res://elements/player/playerBag.tscn").instance()
var hand = load("res://elements/player/playerHand.tscn").instance()
var ready = false


var rooms = {
	"test":"res://testScene.tscn",
  	"room0":"res//Room0.tscn"
}
		
sync func pre_configure_game(id):
	get_tree().set_pause(true)
	var myId = get_tree().get_network_unique_id()
	var world = load(rooms[id]).instance()
	var container = get_node("/root/container/level_container")
	container.get_child(0).queue_free()
	container.add_child(world)
	rpc_id(1,"done_preconfiguring",myId)

remote func done_preconfiguring(who):
	if networking.peer.is_network_server():
		pass
sync func post_configure_game():
	get_tree().set_pause(false)
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
