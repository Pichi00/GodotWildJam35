extends Node2D

export (PackedScene) var enemy
export (PackedScene) var planet
export (int) var world_radious = 3000
export (int) var max_enemies = 20
export (int) var max_planets = 30
export (float) var min_enemy_distance = 200
export (float) var max_enemy_distance = 500
export (float) var min_planet_distance = 250
export (float) var max_planet_distance = 1500

var new_enemy
var rand_dir = 1
var enemy_spawn_position 
var planet_spawn_position 

onready var rng := RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	for i in range(max_enemies/2):
		enemy_spawn()
	for i in range(max_planets):
		planet_spawn()

func enemy_spawn():
	enemy_spawn_position = $Player.global_position + (Vector2.UP.rotated(rng.randf_range(0, PI * 2)) * rng.randf_range(min_enemy_distance, max_enemy_distance))
	add_child_below_node($Player, enemy.instance())
	$EnemySpawnTimer.wait_time = randi() % 4 + 6

func planet_spawn():
	planet_spawn_position =$Player.global_position + (Vector2.UP.rotated(rng.randf_range(0, PI * 2)) * rng.randf_range(min_planet_distance, world_radious))
	add_child_below_node($Player, planet.instance())
func _on_EnemySpawnTimer_timeout():
	for i in range(4):
		if(get_tree().get_nodes_in_group("Enemy").size() <= max_enemies):
			enemy_spawn()

func update_money():
	$Player.update_money()

func add_player_hp():
	$Player.add_hp()
