extends KinematicBody2D

var velocity = Vector2.ZERO
var direction = Vector2(0,-1)
var speed = 200

func _ready():
	global_position = get_tree().get_nodes_in_group("BulletSpawn")[0].global_position
	rotation_degrees = get_tree().get_nodes_in_group("Player")[0].rotation_degrees
	velocity = direction.rotated(deg2rad(rotation_degrees))

func _physics_process(delta):
	move_and_slide(velocity * speed)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
