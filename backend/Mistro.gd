extends Node

# Mistro is this project's "global" or game wide function set. 
# Function that go here, can be accessed by all other scripts.
# Use this sparingly as noise between scenes and nodes can make your game run slower.
#var camera = Camera.new()
var big_list:Dictionary = {}
#var ships:Dictionary = {}
var ships:Array = []

var player1:Dictionary = {}

var ship_class_base_stats:Dictionary = {
	"Striker":{
		"Hull":30,
		"Speed":270,
		"Turn":100,
		"Accel":50
		},
	"Midfield":{
		"Hull":100,
		"Speed":200,
		"Turn":50,
		"Accel":30
		},
	"Defender":{
		"Hull":200,
		"Speed":150,
		"Turn":40,
		"Accel":15
		}
}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func save_game():
	print("saving")
	
func load_game(_gamefile):
	print("loading")
	
func list_saved_games():
	print("saved games")
	
#func global_physics(object,):
#	print("applying global physics")

### We're using the documented defaults for a kinematic character from Godot's website. We edit it a bit to make sure it can be use for any object.

### The object will need these variables to function

#const GRAVITY = -24.8
#var vel = Vector3()
#const MAX_SPEED = 20
#const JUMP_SPEED = 18
#const ACCEL = 4.5

#var dir = Vector3()

#const DEACCEL= 16
#const MAX_SLOPE_ANGLE = 40


func recursive_search(path,dict):
	
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin(true,true)
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				if !dict.has(file_name):
					dict[file_name] = {}
					recursive_search(path+"/"+file_name,dict[file_name])
			else:
				if file_name.split(".")[-1] in ["mp3","ogg","MP3","OGG"]:
					if !dict.has("songs"):
						dict["songs"] = []
					var item = {"title":file_name.split(".")[0],"url":path+"/"+file_name}
					dict["songs"].append(item)
				elif file_name.split(".")[-1] in ["png","jpg","JPEG","PNG","JPG"]:
					
					if !dict.has("pictures"):
						dict["pictures"] = []
					var item = {"title":file_name.split(".")[0],"url":path+"/"+file_name}
					dict["pictures"].append(item)
			file_name = dir.get_next()
	else:
		print("Couldnt find path for", path)
	return 1

func find_target(targets_list):
	var targetIndex = randi() % len(targets_list.get_children())
	var target = targets_list.get_child(targetIndex)
	return target


func load_ships():
	if !ships:
		ships = [
			{"obj":preload("res://scenes/Ships/Strikers/LionHead.tscn"),"class":"striker"},
			{"obj":preload("res://scenes/Ships/Strikers/X1.tscn"),"class":"striker"},
			{"obj":preload("res://scenes/Ships/Strikers/S-Type.tscn"),"class":"striker"},
			{"obj":preload("res://scenes/Ships/MidField/StingRay.tscn"),"class":"midfield"},
			{"obj":preload("res://scenes/Ships/MidField/UglyDuck.tscn"),"class":"midfield"},
			{"obj":preload("res://scenes/Ships/MidField/Catamaran.tscn"),"class":"midfield"}
			]
	
	return ships
