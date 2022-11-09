extends Spatial

var ships:Array = []
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var i = 0
var movement = Vector3(0,0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	ships = Mistro.load_ships()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	$rotunda.rotate_y(0.1 * delta)
	
func _on_Timer_timeout():
	var door = int(rand_range(0.0,5.0))
	i += 1
	#$rotunda.get_child(door).clear_ship()
	if $rotunda.get_child(door).closed:
		$rotunda.get_child(door).load_ship(ships[int(rand_range(0,6))])
	else:
		$rotunda.get_child(door).close()
	
	if i % 10 == 0:
		if $Bay/Large_Doors.closed:
			$Bay/Large_Doors.open()
		else:
			$Bay/Large_Doors.close()
		
	if i % 6 == 0:
		if $Bay/Medium_Doors.closed:
			$Bay/Medium_Doors.open()
		else:
			$Bay/Medium_Doors.close()
		
	pass # Replace with function body.
