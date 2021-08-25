extends Control


func _on_ExitButton_pressed():
	get_parent().get_parent().pageOpen = false
	visible = false
