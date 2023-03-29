extends StaticBody2D

export (String, FILE, "*.tscn") var target_level = ""

func _on_Vault_body_entered(body):
	get_tree().change_scene(target_level)
