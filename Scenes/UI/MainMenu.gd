extends Control

func _ready():
	var file = File.new()
	$ContinueButton.disabled = !file.file_exists(Global.save_path)
	$VersionLabel.text = "ver " + str(ProjectSettings.get_setting("global/version"))

func _on_PlayButton_pressed():
	Global.level = 1
	Global.player_damage = 1
	Global.player_speed = 90
	Global.player_speed_lvl = 1
	Global.planets_unlocked = make_array(9, false)
	Global.planets_visited = make_array(9, 0)
	Global.money = 0
	Global.player_max_hp = 10
	Global.player_hp = 10
	get_tree().change_scene("res://Scenes/Levels/Level.tscn")

func _on_ContinueButton_pressed():
	Global.load_game()
	get_tree().change_scene("res://Scenes/Levels/Level.tscn")

func make_array(arr_size:int, arr_value) -> Array:
	var arr = Array()
	arr.resize(arr_size)
	arr.fill(arr_value)
	return arr
