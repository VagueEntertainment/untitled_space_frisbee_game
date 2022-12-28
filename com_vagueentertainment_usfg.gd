extends Node

var launchbay = preload("res://scenes/World/LaunchBay.tscn")
var hanger = preload("res://scenes/World/Hanger.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var background 
signal cross_talk(type,opt)
# Called when the node enters the scene tree for the first time.
func _ready():
	_start()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _start():
	for c in get_children():
		if c.name != "MainMenu":
			c.hide()
	background = launchbay.instance()
	add_child(background)
	$MainMenu.show()
	if !$MainMenu.is_connected("selection",self,"_on_selection"):
		$MainMenu.connect("selection",self,"_on_selection")
		connect("cross_talk",self,"_on_cross_talk")

func _on_selection(opt):
	match opt:
		"tutorial":
			to_hanger("tutorial")
			emit_signal("cross_talk","menu","tutorial")
		"play":
			to_hanger("tutorial")
			emit_signal("cross_talk","menu","tutorial")
		"settings":
			pass
		"canceled":
			_start()
	pass

func _on_ship_changed(type,index):
	pass
	
func to_hanger(mode):
	background = hanger.instance()
	for c in get_children():
		if c.name != "Hanger":
			c.hide()
	$Hanger.show()
	add_child(background)
	if !$Hanger.is_connected("selection",self,"_on_selection"):
		$Hanger.connect("selection",self,"_on_selection")
		connect("cross_talk",$Hanger,"_on_cross_talk")
		$Hanger.connect("ship_selection",self,"_on_ship_selection")
	if !background.is_connected("change_ship",self,"_on_ship_changed"):
		background.connect("change_ship",self,"_on_ship_changed")
		connect("cross_talk",background,"_on_cross_talk")
		
func _on_cross_talk(type,opt):
	pass
	
func _on_ship_selection(type,index):
	emit_signal("cross_talk",type,index)
	
	
