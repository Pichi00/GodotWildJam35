extends Node2D

export (PackedScene) var enemy
export (PackedScene) var planet
export (int) var world_radious = 1200
export (int) var max_enemies = 8
export (int) var max_planets = 16
export (float) var min_enemy_distance = 250
export (float) var max_enemy_distance = 450
export (float) var first_min_planet_distance = 300
export (float) var min_planet_distance = 700
export (float) var max_planet_distance = 1200

var new_enemy
var rand_dir = 1
var enemy_spawn_position 
var planet_spawn_position 
var planets_array = []

onready var rng := RandomNumberGenerator.new()

func _ready():
	$Player.update_money()
	rng.randomize()
	for i in range(max_enemies):
		enemy_spawn()
	for i in range(max_planets):
		planet_spawn(first_min_planet_distance, max_planet_distance)

func enemy_spawn():
	var new_enemy = enemy.instance()
	enemy_spawn_position = $Player.global_position + (Vector2.UP.rotated(rng.randf_range(0, PI * 2)) * rng.randf_range(min_enemy_distance, max_enemy_distance))
#	add_child_below_node($Player, enemy.instance())
	call_deferred("add_child_below_node",$Player, new_enemy)
	new_enemy.position = enemy_spawn_position
#	$EnemySpawnTimer.wait_time = randi() % 4 + 6

func planet_spawn(min_dist, max_dist):
	var new_planet = planet.instance()
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

#func _on_EnemySpawnTimer_timeout():
#	for i in range(4):
#		if(get_tree().get_nodes_in_group("Enemy").size() <= max_enemies):
#			enemy_spawn()

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
