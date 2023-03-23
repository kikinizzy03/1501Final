extends Node2D

export (String, FILE, "*.tscn") var target_level = ""
export var curr_time = 30

func _ready():
	$Message.hide()
	$Countdown.start()
	$Time.text = str(curr_time)
	
	$Time.show()


func _on_Countdown_timeout():
	curr_time -= 1
	$Time.text = str(curr_time)
	
	if(curr_time <= 0):
		$Countdown.stop()
		$Message.show()
		$Message.text = "Game Over"
		
		$Music.stop()
		get_tree().change_scene(target_level)
