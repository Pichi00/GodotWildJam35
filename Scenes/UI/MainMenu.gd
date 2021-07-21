extends Control


func _on_PlayButton_pressed():
	Global.level = 1
	Global.player_damage = 1
	Global.player_speed = 90
	Global.player_speed_lvl = 1
	Global.planets_unlocked = [false,false,false,false,false,false]
	Global.money = 0
	Global.player_max_hp = 10
	Global.player_hp = 10
	get_tree().change_scene("res://Scenes/UI/Intro.tscn")
