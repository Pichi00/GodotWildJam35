extends Control


func _input(event):
	if (event.is_action_pressed("retry")):
		Global.money = 0
		Global.level = 1
		get_tree().change_scene("res://Scenes/Level.tscn")
