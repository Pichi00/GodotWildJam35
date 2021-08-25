extends Control

export (Texture) var Icon
export (String) var PlanetName
export (String, MULTILINE) var PlanetDescription
export (Global.PLANETS) var type
var pageOpened = false

func _ready():
	$TextureButton.texture_normal = Icon
#	$RightPanel/ScrollContainer/Labels/Name. text = "Name: "+PlanetName
#	$RightPanel/ScrollContainer/Labels/Description. text = PlanetDescription

func _input(event):
	visible = Global.planets_unlocked[type]


func _on_TextureButton_pressed():
	if !get_parent().pageOpen:
		$JournalPage.visible = true
		get_parent().pageOpen = true
