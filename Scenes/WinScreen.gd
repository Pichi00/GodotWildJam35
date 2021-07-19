extends Control



func _on_Twitter_pressed():
	OS.shell_open("https://twitter.com/pichiDev")


func _on_Itch_pressed():
	OS.shell_open("https://pichidev.itch.io/")


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
