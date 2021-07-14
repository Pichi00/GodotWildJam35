extends Control

onready var PauseScreens = get_tree().get_nodes_in_group("PauseScreen") 
onready var if_paused = get_tree().paused
# Klasa zawiera wspólne metody dla obiektów, które wymagają zapauzowania gry

func toggle_pause():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	if new_pause_state == false:
		for Screen in PauseScreens:
			Screen.visible = new_pause_state
	else:
		visible = new_pause_state


func _input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()
