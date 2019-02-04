extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var networking

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	networking = get_node('/root/networking')
	pass

func setIP():
	var ips = IP.get_local_addresses()
	var ip = ips[0]
	if ip == "127.0.0.1":
		ip = ips[1]
	$VSplitContainer/HSplitContainer/ip.text=ip
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _start_server():
	setIP()
	$VSplitContainer/HSplitContainer/ip.editable=false
	$VSplitContainer/HSplitContainer2/startClient.disabled=true
	$VSplitContainer/HSplitContainer2/startServer.visible=false
	$VSplitContainer/HSplitContainer2/stopServer.visible=true
	networking.startServer(self)
	pass # replace with function body
	
func _start_client():
	var ip = $VSplitContainer/HSplitContainer/ip.text
	$VSplitContainer/HSplitContainer2/startServer.disabled=true
	$VSplitContainer/HSplitContainer2/startClient.visible=false
	$VSplitContainer/HSplitContainer2/stopClient.visible=true
	networking.startClient(ip,self)
	pass # replace with function body

func _connected():
	pass
	
func _disconnected():
	$VSplitContainer/HSplitContainer2/startServer.disabled=false
	$VSplitContainer/HSplitContainer2/startClient.visible=true
	$VSplitContainer/HSplitContainer2/stopClient.visible=false


func _stop_server():
	networking.stopServer(self)
	$VSplitContainer/HSplitContainer/ip.editable=true
	$VSplitContainer/HSplitContainer2/startClient.disabled=false
	$VSplitContainer/HSplitContainer2/startServer.visible=true
	$VSplitContainer/HSplitContainer2/stopServer.visible=false
	pass # replace with function body


func _stop_client():
	networking.stopClient(self)
	$VSplitContainer/HSplitContainer2/startServer.disabled=false
	$VSplitContainer/HSplitContainer2/startClient.visible=true
	$VSplitContainer/HSplitContainer2/stopClient.visible=false
	pass # replace with function body
