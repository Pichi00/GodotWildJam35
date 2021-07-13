extends Area2D

var revealed = false

func _ready():
	$TextureProgress.value = 100

func _on_Planet_body_entered(body):
	if !revealed:
		$AnimationPlayer.play("Reveal")
		revealed = true
