extends Node2D

export (PackedScene) var enemy
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
	enemy_spawn_position.x = $Player.global_position.x + 200 * rand_dir
	enemy_spawn_position.y = $Player.global_position.y + 200 * rand_dir
	add_child_below_node($Player, enemy.instance())
	$EnemySpawnTimer.wait_time = randi() % 4 + 6

func _on_EnemySpawnTimer_timeout():
	for i in range(2):
		enemy_spawn()
