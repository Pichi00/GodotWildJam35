extends KinematicBody2D

var velocity = Vector2.ZERO
var direction = Vector2(0,-1)
var speed = 200

var damage = 1

func _ready():
	damage = get_parent().damage
	set_as_toplevel(true)
	#rotation_degrees = get_parent().rotation_degrees
	speed = 200
	#velocity = direction.rotated(deg2rad(rotation_degrees))

func _physics_process(delta):
	move_and_slide(velocity * speed)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
