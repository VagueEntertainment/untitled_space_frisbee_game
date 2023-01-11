extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal selection(opt)
signal ship_selection(type,index)
var step = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Back_pressed():
	match step:
		0:
			emit_signal("selection","canceled")
		2:
			$Menu.show()
			$ShipSelect.hide()
			step = 1
	pass # Replace with function body.


func _on_Class_pressed():
	$Menu/Main.hide()
	$Menu/Class_Select.show()
	step = 1
	pass # Replace with function body.


func _on_Confirm_pressed():
	if step == 1:
		$Menu/Main.show()
		$Menu/Class_Select.hide()
		step = 0
	pass # Replace with function body.


func _on_Cancel_pressed():
	if step == 1:
		$Menu/Main.show()
		$Menu/Class_Select.hide()
		step = 0
	pass # Replace with function body.


func _on_Striker_focus_entered():
	
	pass # Replace with function body.


func _on_Midfield_focus_entered():
	pass # Replace with function body.


func _on_Defender_focus_entered():
	pass # Replace with function body.

func _on_ship_type_input(event,obj):
	if event.is_pressed():
		match obj.name:
			"Striker":
				Mistro.player1["ship_class"] = "striker"
				emit_signal("ship_selection","ship_class",["striker",0])
			"Midfield":
				Mistro.player1["ship_class"] = "midfield"
				emit_signal("ship_selection","ship_class",["midfield",0])
			"Defender":
				#Mistro.player1["ship_class"] = "defender"
				#emit_signal("ship_selection","ship_class",["defender",0])
				pass
			
		$Menu.hide()
		$ShipSelect.show()
		step=2
		
	

func _on_SelectionPip_input(event,obj):
	if event.is_pressed():
		emit_signal("ship_selection","ship_class",[Mistro.player1["ship_class"],int(obj.name[-1])-1])
		
		for c in $ShipSelect/Control/SelectionIndicator.get_children():
			if c.pressed and ! c.name == obj.name:
				c.pressed = false
		
	pass # Replace with function body.


func _on_ShipSelect_visibility_changed():
	if $ShipSelect.visible:
		$PlayerStatus.visible = false
		for c in $ShipSelect/Control/SelectionIndicator.get_children():
			c.pressed = false
			if !c.is_connected("gui_input",self,"_on_SelectionPip_input"):
				c.connect("gui_input",self,"_on_SelectionPip_input",[c])
		$ShipSelect/Control/SelectionIndicator.get_child(0).pressed = true
	pass # Replace with function body.

func _on_cross_talk(type,opt):
	match type:
		"ship_data":
			$ShipSelect/Control/ShipStats.load_stats(opt)
	pass

func _on_Class_Select_visibility_changed():
	if $Menu/Class_Select.visible:
		for c in $Menu/Class_Select/VBoxContainer.get_children():
			if !c.is_connected("gui_input",self,"_on_ship_type_input"):
				c.connect("gui_input",self,"_on_ship_type_input",[c])
	pass # Replace with function body.

func _unhandled_key_input(event):
	if $ShipSelect.visible:
		print(event.as_text())
