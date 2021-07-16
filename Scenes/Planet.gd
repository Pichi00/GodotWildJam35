extends Area2D

var revealed = false
var rng = RandomNumberGenerator.new()
var type = Global.PLANETS.DIRT
var unlocked = false
var planet_value = 10
signal reward

func _ready():
	connect("reward", get_parent(),"update_money")
	set_type()
	$TextureProgress.value = 100
	unlocked = Global.planets_unlocked[type]

func _on_Planet_body_entered(body):
	if !revealed:
		$AnimationPlayer.play("Reveal")
		revealed = true
	if !unlocked:
		Global.planets_unlocked[type] = true

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
	Global.money += planet_value
	emit_signal("reward")
