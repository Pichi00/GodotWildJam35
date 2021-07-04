extends KinematicBody2D

var speed = 100
var rotation_speed = 4.5
var direction = Vector2.ZERO
var velocity = Vector2.ZERO
export (PackedScene) var bullet

func _physics_process(delta):
	direction.y = (int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up")))
	velocity = direction.rotated(deg2rad(rotation_degrees))
	velocity = velocity.normalized()
	
	if Input.is_action_pressed("ui_right"):
		rotation_degrees+=rotation_speed
	elif Input.is_action_pressed("ui_left"):
		rotation_degrees-=rotation_speed
	move_and_slide(velocity * speed)
	

func _input(event):
	if event.is_action_pressed("attack"):
		bullet.instance().set_position($Position2D.position)
		get_tree().root.add_child(bullet.instance())
