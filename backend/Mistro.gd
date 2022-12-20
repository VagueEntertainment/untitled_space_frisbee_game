extends Node

# Mistro is this project's "global" or game wide function set. 
# Function that go here, can be accessed by all other scripts.
# Use this sparingly as noise between scenes and nodes can make your game run slower.
#var camera = Camera.new()
var big_list:Dictionary = {}
#var ships:Dictionary = {}
var ships:Array = []

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
func mouse_input(obj,event):
		# Mouse look (only if the mouse is captured).
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		# Horizontal mouse look.
		#obj.rot.y -= event.relative.x * obj.MOUSE_SENSITIVITY
		# Vertical mouse look.
		#obj.rot.x = clamp(obj.rot.x - event.relative.y * obj.MOUSE_SENSITIVITY, -1.57, 1.57)
		#obj.pitch_input = clamp(obj.rot.x - event.relative.y * obj.TURN_SPEED, -1.57, 1.57)
		#obj.turn_input -= event.relative.x * obj.MOUSE_SENSITIVITY
		#obj.transform.basis = Basis(obj.rot)
		pass

func process_movement_walk(obj,delta):
	
	obj.dir = obj.dir.normalized()
	
	
	obj.vel.y += delta * obj.GRAVITY
	

	var hvel = obj.vel
	#hvel.y = 0

	var target = obj.dir
	target *= obj.MAX_SPEED

	var accel
	if obj.dir.dot(hvel) > 0:
		accel = obj.ACCEL
	else:
		accel =obj.DEACCEL

	hvel = hvel.linear_interpolate(target, accel * delta)
	obj.vel.x = hvel.x
	obj.vel.y = hvel.y
	obj.vel.z = hvel.z
	obj.vel = obj.move_and_slide(obj.vel, Vector3(0, 1, 0), 0.05, 4, deg2rad(obj.MAX_SLOPE_ANGLE))
	

func process_movement_fly(obj,delta):
	
	obj.dir = obj.dir.normalized()
	obj.rot = obj.rot.normalized()
	
	#if obj.dir.z < 0 and obj.thrust < obj.MAX_SPEED:
	#	obj.thrust -= 1
	
	obj.vel.y += delta * obj.GRAVITY

	

	var hvel = obj.vel
	var hrot = obj.rot
	#hvel.y = 0

	obj.target = obj.dir
	obj.target *= obj.MAX_SPEED

	var accel
	if obj.dir.dot(hvel) > 0:
		accel = obj.ACCEL
	else:
		accel = obj.ACCEL
	
	#obj.transform.basis = obj.transform.basis.rotated(obj.transform.basis.x,obj.rot.x * 0.01)
	#obj.transform.basis = obj.transform.basis.rotated(obj.transform.basis.y,obj.rot.y * 0.01)
	#obj.transform.basis = obj.transform.basis.rotated(obj.transform.basis.z,obj.rot.z * 0.01)
		
	obj.transform.basis = obj.transform.basis.rotated(obj.transform.basis.x,obj.pitch_input * obj.TURN_SPEED * delta)
	obj.transform.basis = obj.transform.basis.rotated(obj.transform.basis.y,obj.turn_input * obj.TURN_SPEED * delta)
	obj.transform.basis = obj.transform.basis.rotated(obj.transform.basis.z,obj.rotation_input * obj.TURN_SPEED * delta)
	
	
	obj.ship.rotation.y = lerp(obj.ship.rotation.y,-obj.turn_input * obj.TURN_SPEED * delta ,1.5*delta)	
	
	hvel = hvel.linear_interpolate(obj.target, accel * delta)
	obj.vel.x = hvel.x
	obj.vel.y = hvel.y
	obj.vel.z = hvel.z 
	obj.vel = obj.move_and_slide(obj.vel, Vector3(0, 1, 0), 0.05, 4, deg2rad(obj.MAX_SLOPE_ANGLE))
	

#### We're using the documented defaults for a kinematic character from Godot's website. Edited for use in Mistro instead of needing to be copied and pasted every node.
	
func process_input(obj,camera,delta):

	# ----------------------------------
	# Walking
	obj.dir = Vector3()
	var cam_xform = camera.get_global_transform()

	var input_movement_vector = Vector2.ZERO
	var input_rotation_vector = Vector3.ZERO

	if Input.is_action_pressed("movement_forward"):
		input_movement_vector.y += 1
	if Input.is_action_pressed("movement_backward"):
		input_movement_vector.y -= 1
	if Input.is_action_pressed("movement_strafe_left"):
		input_movement_vector.x -= 1
	if Input.is_action_pressed("movement_strafe_right"):
		input_movement_vector.x += 1
#	if Input.is_action_pressed("movement_roll_left"):
#		input_rotation_vector.z -= 1
#	if Input.is_action_pressed("movement_roll_right"):
#		input_rotation_vector.z += 1
	
#	if Input.is_action_pressed("ui_up"):
#		input_rotation_vector.x += 1
#	if Input.is_action_pressed("ui_down"):
#		input_rotation_vector.x -= 1
#	
#	if Input.is_action_pressed("ui_left"):
#		input_rotation_vector.y += 1
#	if Input.is_action_pressed("ui_right"):
#		input_rotation_vector.y -= 1
		
	if obj.INVERSE_CONTROL:
		obj.pitch_input =  Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")
	else:
		obj.pitch_input = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		
	#obj.turn_input = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right") 
	obj.rotation_input = Input.get_action_strength("movement_roll_right") - Input.get_action_strength("movement_roll_left")
	obj.thrust_input = Input.get_action_strength("movement_forward") - Input.get_action_strength("movement_backward")
	obj.strafe_input = Input.get_action_strength("movement_strafe_right") - Input.get_action_strength("movement_strafe_left")

	input_movement_vector = input_movement_vector.normalized()
	input_rotation_vector = input_rotation_vector.normalized()

	# Basis vectors are already normalized.
	obj.dir += -cam_xform.basis.z * input_movement_vector.y
	obj.dir += cam_xform.basis.x * input_movement_vector.x
	#obj.rot.x += input_rotation_vector.x 
	#obj.rot.z += input_rotation_vector.z 
	#obj.rot.y += input_rotation_vector.y 
		
	# ----------------------------------

	# ----------------------------------
	# Jump
	if obj.is_on_floor():
		if Input.is_action_just_pressed("movement_jump"):
			obj.vel.y = obj.JUMP_SPEED
	# ----------------------------------

	# ----------------------------------
	# Capturing/Freeing the cursor
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	# ----------------------------------

	# Game Defined inputs 
	for act in obj.actions:
		if Input.is_action_just_pressed(act):
			obj.emit_signal("action",act)

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
			preload("res://scenes/Ships/Strikers/LionHead.tscn"),
			preload("res://scenes/Ships/Strikers/X1.tscn"),
			preload("res://scenes/Ships/Strikers/S-Type.tscn"),
			preload("res://scenes/Ships/MidField/StingRay.tscn"),
			preload("res://scenes/Ships/MidField/UglyDuck.tscn"),
			preload("res://scenes/Ships/MidField/Catamaran.tscn")
			]
	
	return ships
