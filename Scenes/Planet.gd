extends Area2D

var revealed = false
var rng = RandomNumberGenerator.new()
var type = Global.PLANETS.DIRT
var unlocked = false

func _ready():
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
	var draw = rng.randi() % 100 + 1
	if(draw >= 0 && draw <= 39):
		type = Global.PLANETS.DIRT
		$Sprite.animation = "Dirt"
	elif(draw >= 40 && draw <= 69):
		type = Global.PLANETS.GREEN
		$Sprite.animation = "Green"
	elif(draw >= 70 && draw <= 89):
		type = Global.PLANETS.PINK
		$Sprite.animation = "Pink"
	else:
		type = Global.PLANETS.ICE
		$Sprite.animation = "Ice"
