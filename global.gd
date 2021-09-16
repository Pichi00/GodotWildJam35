extends Node

const SAVE_DIR = "user://saves/"
var save_path = SAVE_DIR + "save.dat"

var money = 0
var player_max_hp = 10
var player_hp = 10
var player_speed = 90
var player_speed_lvl = 1
var player_damage = 1
var level = 1
var soundOn = true
var soundLevel = -40

const MAX_LEVEL = 4
const MAX_DMG = 2.5
const MAX_SPEED_LVL = 3



enum PLANETS {BROWN,YELLOW,GREEN,PINK,ICE,PURPLE,RED,DARK,LIGHT}
var planets_unlocked = [false,false,false,false,false,false,false,false,false]
var planets_visited = [0,0,0,0,0,0,0,0,0]

#chances to spawn planets
var chances_lvl1 = [0, 49, 50, 79, 80, 99, 100, 101, 102, 103]
var chances_lvl2 = [0, 24, 25, 49, 50, 74, 75, 99, 100, 101]
var chances_lvl3 = [0, 24, 25, 49, 50, 74, 75, 99, 100, 101]
var chances_lvl4 = [0, 24, 25, 49, 50, 74, 75, 99, 100, 101]
var chances = [chances_lvl1, chances_lvl2, chances_lvl3, chances_lvl4]

#chances to spawn enemies
var e_chances_lvl1 = [0, 99, 100, 101, 102, 103]
var e_chances_lvl2 = [0, 69, 70, 99, 100, 101]
var e_chances_lvl3 = [0, 29, 30, 69, 70, 99]
var e_chances_lvl4 = [0, 9, 10, 59, 60, 99]
var e_chances = [e_chances_lvl1, e_chances_lvl2, e_chances_lvl3, e_chances_lvl4]


func save_game():
	var data_to_save = {
		"money": money,
		"player_hp": player_hp,
		"player_speed": player_speed,
		"player_speed_lvl": player_speed_lvl,
		"player_damage": player_damage,
		"level": level,
		"soundOn": soundOn,
		"soundLevel": soundLevel,
		"planets_unlocked": planets_unlocked,
		"planets_visited": planets_visited
	}
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
	
	var file = File.new()
	var error = file.open(save_path, File.WRITE)
	if error == OK:
		file.store_var(data_to_save)
	else:
		print("Error with saving the data")
	file.close()

func load_game():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			var loaded_data = file.get_var()
			money = loaded_data.money
			player_hp = loaded_data.player_hp
			player_speed = loaded_data.player_speed
			player_damage = loaded_data.player_damage
			player_speed_lvl = loaded_data.player_speed_lvl
			level = loaded_data.level
			soundOn = loaded_data.soundOn
			soundLevel = loaded_data.soundLevel
			planets_unlocked = loaded_data.planets_unlocked
			planets_visited = loaded_data.planets_visited
