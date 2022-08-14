extends Control


func _input(event):
	if (event.is_action_pressed("retry")):
		Global.money = 0
		Global.level = 1
		var err := get_tree().change_scene("res://Scenes/Levels/Level.tscn")
		if err:
			print("Error with change_scene")
