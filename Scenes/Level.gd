extends Node2D

export (PackedScene) var enemy
export (PackedScene) var planet
export (int) var world_radious = 8000
export (int) var max_enemies = 20
export (int) var max_planets = 10

var new_enemy
var rand_dir = 1
var enemy_spawn_position = Vector2.ZERO

func _ready():
	randomize()
	for i in range(6):
		enemy_spawn()

func enemy_spawn():
	if randi()%2==0:
		rand_dir = 1
	else:
		rand_dir=-1
	enemy_spawn_position.x = $Player.global_position.x + rand_range(150.0, 300.0) * rand_dir
	enemy_spawn_position.y = $Player.global_position.y + rand_range(150.0, 300.0) * rand_dir
	
	add_child_below_node($Player, enemy.instance())
	$EnemySpawnTimer.wait_time = randi() % 4 + 6

func _on_EnemySpawnTimer_timeout():
	for i in range(4):
		if(get_tree().get_nodes_in_group("Enemy").size() <= max_enemies):
			enemy_spawn()

func update_money():
	$Player.update_money()

func add_player_hp():
	$Player.add_hp()
