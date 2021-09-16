extends KinematicBody2D

var speed = 100
var rotation_speed = 3.5
var direction = Vector2.ZERO
var velocity = Vector2.ZERO
var MAX_HP = 10
var hp = 10
var damage = 1

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
	velocity = direction.rotated(deg2rad($Capsule.rotation_degrees))
	velocity = velocity.normalized()
	
	if Input.is_action_pressed("ui_right"):
		$Capsule.rotation_degrees+=rotation_speed
	elif Input.is_action_pressed("ui_left"):
		$Capsule.rotation_degrees-=rotation_speed
	
	$Wings.look_at(get_global_mouse_position())
	$Wings.rotation_degrees += 90
	
	if Input.is_action_pressed("zoom"):
		$Camera2D.zoom = Vector2(8,8)
	else:
		$Camera2D.zoom = Vector2(1.3,1.3)

	move_and_slide(velocity * Global.player_speed)
	

func _input(event):
	if event.is_action_pressed("attack"):
		damage = Global.player_damage
		match Global.gun_level:
			2:
				shot_two()
			3:
				shot_one()
				shot_two()
			_:
				shot_one()
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
		get_tree().change_scene("res://Scenes/UI/DeathScreen.tscn")

func add_hp():
	if hp < MAX_HP:
		hp+=2
		update_hp()

func update_money():
	$UI_Layer/UI/Money_Label.text = str(Global.money)
	$UI_Layer/UI/Pause.update_entries()

func _on_EnemiesArea_body_exited(body):
	emit_signal("destroy_enemy", body)

func _on_WorldArea_area_exited(area):
	emit_signal("destroy_planet", area)
	

func shot_one():
	var new_bullet = bullet.instance()
	add_child(new_bullet)
	new_bullet.global_position = $Wings/BulletSpawner.global_position
	new_bullet.rotation_degrees = $Wings.rotation_degrees
	new_bullet.velocity = new_bullet.direction.rotated(deg2rad(new_bullet.rotation_degrees))

func shot_two():
	var new_bullet_1 = bullet.instance()
	var new_bullet_2 = bullet.instance()
	$Wings.add_child(new_bullet_1)
	new_bullet_1.global_position = $Wings/BulletSpawner1.global_position
	$Wings.add_child(new_bullet_2)
	new_bullet_2.global_position = $Wings/BulletSpawner2.global_position
