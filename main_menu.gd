extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	print("MainMenu ready!")
	$FlowContainer/Button.grab_focus()
	
	if !OS.has_feature("pc"):
		#$Options/FullscreenButton.hide()
		$FlowContainer/Button2.hide()
	
func _on_start_button_pressed():

	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	elif DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func _on_quit_button_pressed():
	get_tree().quit()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/main_menu.tscn")


func _on_button_2_pressed() -> void:
	pass # Replace with function body.
