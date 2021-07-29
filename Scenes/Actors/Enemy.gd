extends KinematicBody2D

var speed = 20
var rotation_speed = 5
var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var player_detected = false
var rotating = false
var rot_to = 180
var angle
var rand_dir = 1
var MAX_HP = 9
var hp

export var bullet_speed = 120
export (PackedScene) var bullet
export (PackedScene) var collectible

signal destroy_enemy(enemy)

onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready():
	connect("destroy_enemy",get_parent(),"_on_Player_destroy_enemy")
	hp = MAX_HP
	#global_position = get_parent().enemy_spawn_position
	randomize()
	if randi()%2==0:
		rand_dir = 1
	else:
		rand_dir=-1
	rotation_degrees = randi()%180 * rand_dir

func _physics_process(delta):
	if player_detected:
		velocity =  player.global_position - global_position
		velocity = velocity.normalized()
	else:
		direction.y = -1
		velocity = direction.rotated(deg2rad(rotation_degrees))
		velocity = velocity.normalized()
	angle = -rad2deg(velocity.angle_to(Vector2(0,-1)))
	if abs(rotation_degrees - angle) >= 180:
		rotation_degrees = angle 
	rotation_degrees = move_toward(rotation_degrees, angle, rotation_speed)
	move_and_slide(velocity * speed)

func take_dmg():
	hp -= Global.player_damage
	if hp <= 0:
		destroy()

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		player_detected = true
		$Timer.start()

func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):
		player_detected = false
		$Timer.stop()

func _on_Hitbox_body_entered(body):
	if body.is_in_group("Bullet"):
		body.queue_free()
		take_dmg()
		$HP_Bar.value = (hp * 100) / MAX_HP

func _on_Timer_timeout():
	if player_detected:
		var new_bullet = bullet.instance()
		add_child(new_bullet)
		new_bullet.global_position = $BulletSpawner.global_position
		$ShotSound.play()
		$Timer.wait_time = randi() % 2 + 1

func destroy():
	emit_signal("destroy_enemy", self)
	var new_collectible = collectible.instance()
	get_parent().call_deferred("add_child",new_collectible)
	new_collectible.global_position = self.global_position
	self.queue_free()
