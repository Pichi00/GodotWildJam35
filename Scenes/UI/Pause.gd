extends Control

onready var PauseScreens = get_tree().get_nodes_in_group("PauseScreen") 
onready var if_paused = get_tree().paused
signal toggle_sound
export (Texture) var soundOnIcon
export (Texture) var soundOffIcon
# Klasa zawiera wspólne metody dla obiektów, które wymagają zapauzowania gry

func _ready():
	#connect("toggle_sound", get_tree().get_nodes_in_group("Level")[0],)
	if Global.soundOn:
		$TextureButton.texture_normal = soundOnIcon
	else:
		$TextureButton.texture_normal = soundOffIcon

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


func _on_TextureButton_pressed():
	Global.soundOn = !Global.soundOn
	var Audios = get_tree().get_nodes_in_group("SFX")
	if Global.soundOn:
		$TextureButton.texture_normal = soundOnIcon
		for audio in Audios:
			audio.volume_db = Global.soundLevel
	else:
		$TextureButton.texture_normal = soundOffIcon
		for audio in Audios:
			audio.volume_db = -80


func update_entries():
	for entry in $TabContainer/Journal/ScrollContainer/JournalEntries.get_children():
		entry.update_icon()
