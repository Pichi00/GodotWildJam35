extends KinematicBody2D

var velocity = Vector2.ZERO
var direction = Vector2(0,-1)
var speed = 200

export var damage = 1

func _ready():
	global_position = get_parent().global_position
	rotation_degrees = get_parent().rotation_degrees
	velocity = direction.rotated(deg2rad(rotation_degrees))
	set_as_toplevel(true)

func _physics_process(delta):
	move_and_slide(velocity * speed)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
