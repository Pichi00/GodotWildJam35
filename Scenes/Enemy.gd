extends KinematicBody2D

var speed = 20
var rotation_speed = 5
var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var player_detected = false
var rotating = false
var rot_to = 180
var angle
onready var player = get_tree().get_nodes_in_group("Player")[0]

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

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		player_detected = true

func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):
		player_detected = false
