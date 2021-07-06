extends KinematicBody2D

var speed = 20
var rotation_speed = 5
var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var player_detected = false
var rotating = false
var rot_to = 180
var angle

export var hp = 8
export var bullet_speed = 120
export (PackedScene) var bullet

onready var player = get_tree().get_nodes_in_group("Player")[0]

func _ready():
	randomize()

func _physics_process(delta):
	if hp <= 0:
		queue_free()
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

func take_dmg(var dmg_amount):
	hp -= dmg_amount

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		player_detected = true

func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):
		player_detected = false


func _on_Hitbox_body_entered(body):
	if body.is_in_group("Bullet"):
		body.queue_free()
		take_dmg(body.damage)


func _on_Timer_timeout():
	if player_detected:
		add_child(bullet.instance())
		$Timer.wait_time = randi() % 4 + 4
