extends Node2D

export (String, FILE, "*.tscn") var target_level = ""


func _ready():
	$GameOver.play()


func _on_Replay_button_up():
	get_tree().change_scene(target_level)
