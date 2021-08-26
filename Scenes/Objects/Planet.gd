extends Area2D

var revealed = false
var rng = RandomNumberGenerator.new()
var type = Global.PLANETS.BROWN
var unlocked = false
var planet_value = 5
signal reward

func _ready():
	connect("reward", get_parent(),"update_money")
	$ValueLabel.hide()
	$CanvasLayer/NewEntry.hide()
	set_type()
	$DiscoverProgress.value = 0
	unlocked = Global.planets_unlocked[type]

func _on_Planet_body_entered(body):
		if !revealed:
			$AnimationPlayer.playback_speed =(1.0 - float(type/10.0))
			$AnimationPlayer.play("Reveal")

func set_type():
	rng.randomize()
	var draw = rng.randi() % 100
	if(draw >= Global.chances[Global.level-1][0] && draw <= Global.chances[Global.level-1][1]):
		type = Global.PLANETS.BROWN
		$Sprite.animation = "Brown"
	elif(draw >= Global.chances[Global.level-1][2] && draw <= Global.chances[Global.level-1][3]):
		type = Global.PLANETS.GREEN
		$Sprite.animation = "Yellow"
	elif(draw >= Global.chances[Global.level-1][4] && draw <= Global.chances[Global.level-1][5]):
		type = Global.PLANETS.PINK
		$Sprite.animation = "Green"
	elif(draw >= Global.chances[Global.level-1][6] && draw <= Global.chances[Global.level-1][7]):
		type = Global.PLANETS.ICE
		$Sprite.animation = "Pink"
	elif(draw >= Global.chances[Global.level-1][8] && draw <= Global.chances[Global.level-1][9]):
		type = Global.PLANETS.EARTH
		$Sprite.animation = "Ice"
	else:
		type = Global.PLANETS.X
		$Sprite.animation = "Red"
	planet_value = 10 + type * 10

func reveal_reward():
	$ValueLabel.text="+"+str(planet_value)
	$AnimationPlayer.playback_speed = 1
	$AnimationPlayer.play("AddMoney")
	$RevealSound.play()
	Global.money += planet_value
	Global.planets_visited[type] += 1
	if !unlocked:
		Global.planets_unlocked[type] = true
		$AnimationPlayer.play("NewEntry")
	emit_signal("reward")

func play_new_reveal():
	revealed = true
	$AnimationPlayer.playback_speed = 1.0
	$AnimationPlayer.play("NewReveal")

func _on_Planet_body_exited(body):
	if !revealed:
		$AnimationPlayer.play("ComeBack")
