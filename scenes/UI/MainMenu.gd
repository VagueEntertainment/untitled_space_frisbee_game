extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Quit_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_Settings_pressed():
	pass # Replace with function body.


func _on_Play_pressed():
	$main.hide()
	$play.show()
	pass # Replace with function body.


#func _on_MainMenu_resized():
#	print("Panel: ",$Panel.rect_size.x)
#	print("VBox: ",$Panel/VBoxContainer.rect_size.x)
#	print("Control: ",$Panel/VBoxContainer/Control.rect_size.x)
#	pass # Replace with function body.


func _on_Back_pressed():
	$main.show()
	$play.hide()
	pass # Replace with function body.
