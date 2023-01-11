extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal change_ship(type,index)
signal cross_talk(type,data)
var current_index = 0
var ship = null
var classes:Dictionary = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	if Mistro.ships == []:
		Mistro.load_ships()
		_place_ships()
	else:
		_place_ships()
	$Hanger/Medium_Doors.open()
	$Hanger/Small_Doors.open()
	$Hanger/hanger_bay_door.open()
	connect("change_ship",self,"_change_ship")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	$rotationPoint.rotate_y(0.01 * delta)
	

func _change_ship(ShipClass,index):
	
	if ship:
		var current_ship = $Ships.get_child(current_index)
		current_ship.translation.x = $ship_placement.get_child(current_index).translation.x
		current_ship.translation.z = $ship_placement.get_child(current_index).translation.z
		current_ship.rotation = $ship_placement.get_child(current_index).rotation
		
	ship = $Ships.get_child(classes[ShipClass][index])
	ship.translation.x = $Selection.translation.x
	ship.translation.z = $Selection.translation.z
	ship.rotation = $Selection.rotation
	current_index = classes[ShipClass][index]
	
	emit_signal("cross_talk","selection",[ShipClass,index,ship.stats])
		

func _on_cross_talk(type,opt):
	
	match type:
		"ship_class":
			emit_signal("change_ship",opt[0],opt[1])

func _place_ships():
	if $Ships.get_child_count() == 0:
		for s in Mistro.ships:
			$Ships.add_child(s["obj"].instance())
			var idx = $Ships.get_child_count() - 1
			$Ships.get_child(idx).translation.x = get_node("ship_placement/ship"+str($Ships.get_child_count())).translation.x
			$Ships.get_child(idx).translation.z = get_node("ship_placement/ship"+str($Ships.get_child_count())).translation.z
			$Ships.get_child(idx).rotation = get_node("ship_placement/ship"+str($Ships.get_child_count())).rotation
			if !s["class"] in classes.keys():
				classes[s["class"]] = []
			classes[s["class"]].append(idx)
