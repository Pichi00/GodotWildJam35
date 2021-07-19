extends KinematicBody2D

var speed = 100
var rotation_speed = 3.5
var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var MAX_HP = 10
var hp = 10

onready var hp_bar = $UI_Layer/UI/TextureProgress

export (PackedScene) var bullet
export var bullet_speed = 200

signal destroy_planet(planet)
signal destroy_enemy(enemy)

func _ready():
	hp = MAX_HP
	update_hp()
	update_money()

func _physics_process(delta):
	direction.y = (int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up")))
	velocity = direction.rotated(deg2rad(rotation_degrees))
	velocity = velocity.normalized()
	
	if Input.is_action_pressed("ui_right"):
		rotation_degrees+=rotation_speed
	elif Input.is_action_pressed("ui_left"):
		rotation_degrees-=rotation_speed
	
#	if Input.is_action_pressed("zoom"):
#		$Camera2D.zoom = Vector2(8,8)
#	else:
#		$Camera2D.zoom = Vector2(1.5,1.5)

	move_and_slide(velocity * Global.player_speed)
	

func _input(event):
	if event.is_action_pressed("attack"):
		add_child(bullet.instance())
		$ShotSound.play()


func _on_Hitbox_body_entered(body):
	if body.is_in_group("EnemyBullet"):
		body.queue_free()
		hp-=1
		update_hp()

func update_hp():
	hp = clamp(hp,0,MAX_HP)
	hp_bar.value = hp * 100 / MAX_HP
	Global.player_max_hp = MAX_HP
	Global.player_hp = hp
	if hp == 0:
		get_tree().change_scene("res://Scenes/DeathScreen.tscn")

func add_hp():
	if hp < MAX_HP:
		hp+=2
		update_hp()

func update_money():
	$UI_Layer/UI/Money_Label.text = str(Global.money)

func _on_EnemiesArea_body_exited(body):
	emit_signal("destroy_enemy", body)

func _on_WorldArea_area_exited(area):
	emit_signal("destroy_planet", area)
