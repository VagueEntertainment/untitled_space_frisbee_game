extends Node

var background = preload("res://scenes/World/LaunchBay.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	_start()
	add_child(background.instance())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _start():
	for c in get_children():
		if c.name != "MainMenu":
			c.hide()
