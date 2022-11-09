extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var ships:Array = []
var player_positions = []
var positions:Dictionary = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	ships = Mistro.load_ships()
	if load_positions():
		print(positions)
	#get_player_positions()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$SpringArm.rotate_y(0.1*delta)
	pass

func get_player_positions():
		
	## Team loading, better method will come after I figure out what I'm doing
	#for num in range(0,3):
	#	$Team1/Strikers.get_node("Striker"+str(num+1)).add_child(ships[num].instance())
	#	$Team2/Strikers.get_node("Striker"+str(num+1)).add_child(ships[num].instance())
	#for num in range(0,3):
	#	$Team1/Midfield.get_node("Midfield"+str(num+1)).add_child(ships[num+3].instance())
	#	$Team2/Midfield.get_node("Midfield"+str(num+1)).add_child(ships[num+3].instance())
	pass

func load_positions():
	
	for team in [$Team1,$Team2]:
		positions[team.name] = {}
		for cat in team.get_children():
			if !cat.name in positions.keys():
				positions[team.name][cat.name] = []
			for p in cat.get_children():
				positions[team.name][cat.name].append(p)
	
	return 1
