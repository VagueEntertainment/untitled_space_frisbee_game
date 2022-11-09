extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ship
const GRAVITY = 0
const AntiGrav = 0.01
var flying = true
var vel = Vector3()
const MAX_SPEED = 280
const JUMP_SPEED = 18
const ACCEL = 4.5
var mouse_axis := Vector2()

const MOUSE_SENSITIVITY = 0.002
const MOVE_SPEED = 1.5

var dir = Vector3()
var rot = Vector3()

const DEACCEL= 5
const MAX_SLOPE_ANGLE = 40

var state = "starting"
var target = null

var player = true
#var awaiting_command = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	load_ship("res://scenes/Ships/Strikers/X1.tscn")
	$Camera.make_current()
	translate(Vector3(0,150,0))
	#rotate(Vector3(0,1,0),180)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#$SpringArm.translation = translation
#	pass

func _physics_process(delta):
	if ship and $Camera.translation.z < -5:
		$Camera.translate(Vector3(0,0,-8*delta))
		#print($Camera.translation)
	Mistro.process_movement(self,delta)
	Mistro.process_input(self,$Camera,delta)
	pass
	

# Load_ship and apply its unique abilities.

func load_ship(obj):
	var l = load(obj)
	ship = l.instance()
	ship.translation = self.translation
	self.add_child(ship)
	return 1

func _input(event):
	Mistro.mouse_input(self,event)

