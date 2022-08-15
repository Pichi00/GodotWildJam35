extends Node2D


export (Vector2) var area_border_scale = Vector2.ONE
export (PackedScene) var enemy_scene
export (PackedScene) var planet_scene
export (int) var world_radious = 1200
export (int) var max_enemies = 5
export (int) var max_planets = 10
export (float) var min_enemy_distance = 250.0
export (float) var max_enemy_distance = 450.0
export (float) var first_min_planet_distance = 300.0
export (float) var min_planet_distance = 700.0
export (float) var max_planet_distance = 1200.0

var rand_dir = 1
var enemy_spawn_position 
var planet_spawn_position 
var planets_array = []

onready var rng := RandomNumberGenerator.new()

func _ready():
	$SpaceRocksAreaShape.texture_scale = area_border_scale
	$SpaceRocksAreaShape.scale = area_border_scale
	for audio in get_tree().get_nodes_in_group("SFX"):
		audio.volume_db = Global.soundLevel
	$Player.update_money()
	rng.randomize()
	for _i in range(max_enemies):
		enemy_spawn()
	for _i in range(max_planets):
		planet_spawn(first_min_planet_distance, max_planet_distance)
	
func enemy_spawn():
	var new_enemy = enemy_scene.instance()
	enemy_spawn_position = $Player.global_position + (Vector2.UP.rotated(rng.randf_range(0, PI * 2)) * rng.randf_range(min_enemy_distance, max_enemy_distance))
	call_deferred("add_child_below_node",$Player, new_enemy)
	new_enemy.position = enemy_spawn_position

func planet_spawn(min_dist, max_dist):
	var new_planet = planet_scene.instance()
	var new_pos = Vector2.ZERO
	var can_spawn = true
	while(can_spawn):
		new_pos = $Player.global_position + (Vector2.UP.rotated(rng.randf_range(0, PI * 2)) * rng.randf_range(min_dist, max_dist))
		if(planets_array.size() > 0):
			for p in planets_array:
				if abs(p.position.x-new_pos.x) < 100 && abs(p.position.y-new_pos.y) < 100:
					can_spawn = true
					break;
				else:
					can_spawn = false
		else:
			can_spawn = false
	call_deferred("add_child_below_node", $Planets, new_planet)
	new_planet.position = new_pos
	planets_array.append(new_planet)

func update_money():
	$Player.update_money()

func add_player_hp():
	$Player.add_hp()

func _on_Player_destroy_planet(planet):
	planet.queue_free()
	planets_array.erase(planet)
	if(get_tree().get_nodes_in_group("Planet").size() <= max_planets):
		planet_spawn(min_planet_distance, max_planet_distance)


func _on_Player_destroy_enemy(enemy):
	enemy.queue_free()
	if(get_tree().get_nodes_in_group("Enemy").size() <= max_enemies):
		enemy_spawn()
	

func coin_sound():
	$CoinSound.play()



