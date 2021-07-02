extends KinematicBody2D

var speed = 120
var rotation_speed = 5
var direction = Vector2.ZERO
var velocity = Vector2.ZERO

func _physics_process(delta):
	direction.y = (int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up")))
	velocity = direction.rotated(deg2rad($Sprite.rotation_degrees))
	velocity.normalized()
	if Input.is_action_pressed("ui_right"):
		$Sprite.rotation_degrees+=rotation_speed
	elif Input.is_action_pressed("ui_left"):
		$Sprite.rotation_degrees-=rotation_speed
	move_and_slide(velocity * speed)
