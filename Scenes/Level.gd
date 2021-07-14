extends Node2D

export (PackedScene) var enemy
export (PackedScene) var planet
export (int) var world_radious = 3000
export (int) var max_enemies = 20
export (int) var max_planets = 50
export (float) var min_enemy_distance = 200
export (float) var max_enemy_distance = 500
export (float) var min_planet_distance = 1000
export (float) var max_planet_distance = 2800

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
	var new_planet = planet.instance()
	#planet_spawn_position =$Player.global_position + (Vector2.UP.rotated(rng.randf_range(0, PI * 2)) * rng.randf_range(min_planet_distance, world_radious))
	#add_child_below_node($Planets, planet.instance())
	call_deferred("add_child_below_node", $Planets, new_planet)
	new_planet.position = $Player.global_position + (Vector2.UP.rotated(rng.randf_range(0, PI * 2)) * rng.randf_range(min_planet_distance, world_radious))

func _on_EnemySpawnTimer_timeout():
	for i in range(4):
		if(get_tree().get_nodes_in_group("Enemy").size() <= max_enemies):
			enemy_spawn()

func update_money():
	$Player.update_money()

func add_player_hp():
	$Player.add_hp()


func _on_Player_destroy_planet(planet):
	planet.queue_free()
	if(get_tree().get_nodes_in_group("Planet").size() <= max_planets):
		planet_spawn()
