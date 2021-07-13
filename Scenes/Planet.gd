extends Area2D

var revealed = false

func _ready():
	$TextureProgress.value = 100
	global_position = get_parent().planet_spawn_position
	print(global_position)

func _on_Planet_body_entered(body):
	if !revealed:
		$AnimationPlayer.play("Reveal")
		revealed = true
