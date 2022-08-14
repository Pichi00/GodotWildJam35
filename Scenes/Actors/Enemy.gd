extends KinematicBody2D

var rotation_speed = 5
var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var player_detected = false
var rotating = false
var rot_to = 180
var angle
var rand_dir = 1
var hp
var rng = RandomNumberGenerator.new()
var enemy_level = 1

export var damage = 1
export var MAX_HP = 20
export var speed = 45
export var bullet_speed = 160
export (PackedScene) var bullet
export (PackedScene) var collectible

signal destroy_enemy(enemy)

onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready():
	rng.randomize()
	var draw = rng.randi()%100
	if draw >= Global.e_chances[Global.level-1][0] && draw <= Global.e_chances[Global.level-1][1]:
		enemy_level = 1
	elif draw >= Global.e_chances[Global.level-1][2] && draw <= Global.e_chances[Global.level-1][3]:
		enemy_level = 2
	else:
		enemy_level = 3
	match enemy_level:
		1:
			$Sprite.modulate = Color(0.556863, 0.956863, 0.160784)
		2:
			$Sprite.modulate = Color(1, 0.913725, 0)
		3:
			$Sprite.modulate = Color(1, 0.031373, 0.031373)
	damage = enemy_level
	MAX_HP = 10 + (10 * enemy_level)
	speed = 40 + (5 * enemy_level)
	bullet_speed = 155 + (5 * enemy_level)
	Global.handle_signal_connection(self, "destroy_enemy", get_parent(),"_on_Player_destroy_enemy")
	hp = MAX_HP
	
	rng.randomize()
	if rng.randi()%2==0:
		rand_dir = 1
	else:
		rand_dir=-1
	rotation_degrees = randi()%180 * rand_dir

func _physics_process(_delta):
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
	velocity = move_and_slide(velocity * speed)

func take_dmg(var dmg):
	hp -= dmg
	print(hp)
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
		take_dmg(body.damage)
		body.queue_free()
		$HP_Bar.value = (hp * 100) / MAX_HP

func _on_Timer_timeout():
	if player_detected:
		var new_bullet = bullet.instance()
		add_child(new_bullet)
		new_bullet.global_position = $BulletSpawner.global_position
		new_bullet.rotation_degrees = self.rotation_degrees
		new_bullet.velocity = new_bullet.direction.rotated(deg2rad(new_bullet.rotation_degrees))
		$ShotSound.play()
		$Timer.wait_time = randi() % 2 + 1

func destroy():
	emit_signal("destroy_enemy", self)
	var new_collectible = collectible.instance()
	get_parent().call_deferred("add_child",new_collectible)
	new_collectible.global_position = self.global_position
	self.queue_free()
