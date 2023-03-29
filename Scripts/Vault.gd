extends Area2D

export (String, FILE, "*.tscn") var target_level = ""

func _on_Vault_body_entered(body):
	print("body entered");
	get_tree().change_scene(target_level)


func _on_Vault_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	print("body entered");
	get_tree().change_scene(target_level)
