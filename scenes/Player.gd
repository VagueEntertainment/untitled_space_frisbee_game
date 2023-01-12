extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ship
const GRAVITY = 0
const AntiGrav = 0.01
var flying = true

var thrust = 1
const MAX_SPEED = 280
const JUMP_SPEED = 18
const INVERSE_CONTROL = true
const ACCEL = 0.5
const TURN_SPEED = 1.5
var mouse_axis := Vector2()

const MOUSE_SENSITIVITY = 0.002
const MOVE_SPEED = 1.5

var dir = Vector3()
var pre_dir = Vector3()
var rot = Vector3.ZERO
var vel = Vector3()

var turn_input = 0
var pitch_input = 0
var rotation_input = 0
var strafe_input = 0
var thrust_input = 0

const DEACCEL= 5
const MAX_SLOPE_ANGLE = 40

var state = "starting"
var target = null

var player = true

signal action(act)

var actions:Array = ["target_1","target_2","target_3","target_4","grab","launch","special"]
#var awaiting_command = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	load_ship("res://scenes/Ships/Strikers/S-Type.tscn")
	$Camera.make_current()
	#rot = rotation
	pre_dir = Vector3.ZERO
	connect("action",self,"_on_action")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#$SpringArm.translation = translation
#	pass

func _physics_process(delta):
	if ship and $Camera.translation.z < -5:
		$Camera.translate(Vector3(0,0,-7*delta))
	FlightSimple.process_movement_fly(self,delta)
	General.process_input(self,$Camera,delta)
	$Control/Speed.text = str(vel.x)
	pass
	

# Load_ship and apply its unique abilities.

func load_ship(obj):
	var l = load(obj)
	ship = l.instance()
	self.add_child(ship)
	return 1

func _input(event):
	General.mouse_input(self,event)

func _on_action(act):
	print(act)
