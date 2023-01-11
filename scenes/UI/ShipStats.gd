extends PanelContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func load_stats(stats):
	#print(stats)
	for s in Mistro.ship_class_base_stats[stats[0].capitalize()].keys():
		set_range(s,Mistro.ship_class_base_stats[stats[0].capitalize()][s])
	for s in stats[2].keys():
		if s == "Name":
			$VBoxContainer/Title.text = stats[2][s]
		else:
			$VBoxContainer.get_node(s+"/TextureProgress").value = stats[2][s]
		
	

func set_range(statName,value):
	$VBoxContainer.get_node(statName+"/TextureProgress").max_value = value*2
