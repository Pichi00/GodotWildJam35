extends KinematicBody2D

var velocity = Vector2.ZERO
var vel
var direction = Vector2(0,-1)
var speed = 200

var damage = 1

func _ready():
	damage = get_parent().damage
	set_as_toplevel(true)

func _physics_process(_delta):
	vel = move_and_slide(velocity * speed)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
