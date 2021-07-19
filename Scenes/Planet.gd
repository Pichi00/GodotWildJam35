extends Area2D

var revealed = false
var rng = RandomNumberGenerator.new()
var type = Global.PLANETS.DIRT
var unlocked = false
var planet_value = 5
signal reward

func _ready():
	connect("reward", get_parent(),"update_money")
	$ValueLabel.hide()
	$CanvasLayer/NewEntry.hide()
	set_type()
	$TextureProgress.value = 100
	unlocked = Global.planets_unlocked[type]

#func _process(delta):
#	if !revealed && !$AnimationPlayer.is_playing():
#		$TextureProgress.value = move_toward($TextureProgress.value,100, 5)
#	elif revealed:
#		$TextureProgress.value = 0

func _on_Planet_body_entered(body):
	if !revealed:
		$AnimationPlayer.play("Reveal"+str(type))
	

func set_type():
	rng.randomize()
	var draw = rng.randi() % 100
	if(draw >= Global.chances[Global.level-1][0] && draw <= Global.chances[Global.level-1][1]):
		type = Global.PLANETS.DIRT
		$Sprite.animation = "Dirt"
	elif(draw >= Global.chances[Global.level-1][2] && draw <= Global.chances[Global.level-1][3]):
		type = Global.PLANETS.GREEN
		$Sprite.animation = "Green"
	elif(draw >= Global.chances[Global.level-1][4] && draw <= Global.chances[Global.level-1][5]):
		type = Global.PLANETS.PINK
		$Sprite.animation = "Pink"
	elif(draw >= Global.chances[Global.level-1][6] && draw <= Global.chances[Global.level-1][7]):
		type = Global.PLANETS.ICE
		$Sprite.animation = "Ice"
	elif(draw >= Global.chances[Global.level-1][8] && draw <= Global.chances[Global.level-1][9]):
		type = Global.PLANETS.EARTH
		$Sprite.animation = "Earth"
	else:
		type = Global.PLANETS.X
		$Sprite.animation = "X"
	planet_value = 10 + type * 10

func reveal_reward():
	revealed = true
	if(type==Global.PLANETS.X):
		get_tree().change_scene("res://Scenes/WinScreen.tscn")
	$ValueLabel.text="+"+str(planet_value)
	$AnimationPlayer.play("AddMoney")
	$RevealSound.play()
	Global.money += planet_value
	if !unlocked:
		Global.planets_unlocked[type] = true
		$AnimationPlayer.play("NewEntry")
	emit_signal("reward")


func _on_Planet_body_exited(body):
	if !revealed:
		$AnimationPlayer.play("ComeBack")
