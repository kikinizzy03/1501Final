extends Node2D

export (String, FILE, "*.tscn") var target_level = ""


func _on_StartButton_button_up():
	if target_level.empty(): return
	get_tree().change_scene(target_level)
