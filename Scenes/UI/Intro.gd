extends Control

var page1done = false
var page2done = false

func _ready():
	$Enter.hide()
	$AnimationPlayer.play("Intro 1")

func page1done():
	page1done = true

func page2done():
	page2done = true

func play_enter():
	$AnimationPlayer.play("Enter")

func _input(event):
	if event.is_action_pressed("retry") && page2done:
		get_tree().change_scene("res://Scenes/Levels/Level.tscn")
	elif event.is_action_pressed("retry") && page1done:
		$AnimationPlayer.play("Intro 2")
