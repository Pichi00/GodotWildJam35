extends Control

export (Texture) var Icon
export (String) var PlanetName
export (String) var PlanetDescription
export (Global.PLANETS) var type

func _ready():
	$Icon/Planet.texture = Icon
	$RightPanel/ScrollContainer/Labels/Name. text = "Name: "+PlanetName
	$RightPanel/ScrollContainer/Labels/Description. text = PlanetDescription

func _input(event):
	visible = Global.planets_unlocked[type]
