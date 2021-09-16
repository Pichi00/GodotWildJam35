extends Control

export (Texture) var Icon
export (Texture) var Creature
export (Texture) var Landscape
export (String) var PlanetName
export (String, MULTILINE) var PlanetDescription
export (String) var CreatureName
export (Global.PLANETS) var type
export (PackedScene) var JournalPage

var pageOpened = false
var LockedIcon = "res://Graphics/Environment/Planets/MysteriousPlanet.png"
var LockedCreature = "res://Graphics/Environment/Creatures/LockedCreature.png"
var LockedLandscape = "res://Graphics/Environment/Landscapes/LockedLandscape.png"

func update_icon():
	if Global.planets_unlocked[type]:
		$TextureButton.texture_normal = Icon
	else:
		$TextureButton.texture_normal = load(LockedIcon)


func _on_TextureButton_pressed():
	if !get_parent().pageOpen:
		add_child(JournalPage.instance())
