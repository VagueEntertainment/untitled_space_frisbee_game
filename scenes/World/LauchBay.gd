extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var i = 0
var movement = Vector3(0,0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	$rotunda.rotate_y(0.1 * delta)
	
func _on_Timer_timeout():
	var door = int(rand_range(0.0,5.0))
	i += 1
	$rotunda.get_child(door).get_node("AnimationPlayer").play("Open")
	if i % 10 == 0:
		$Bay/Large_Doors/AnimationPlayer.play("Open")
	if i % 6 == 0:
		$Bay/Medium_Doors/AnimationPlayer.play("Open")
	pass # Replace with function body.
