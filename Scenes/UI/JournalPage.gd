extends CanvasLayer

var type

func _ready():
	type = get_parent().type
	
	if Global.planets_unlocked[type]:
		$Page/Planet.texture = get_parent().Icon
		$Page/PlanetName.text = get_parent().PlanetName
		$Page/Description.text = get_parent().PlanetDescription

	else:
		$Page/Planet.texture = load(get_parent().LockedIcon)
	
	if Global.planets_visited[type] > 9:
		$Page/Creature.texture = get_parent().Creature
		$Page/CreatureName.text = get_parent().CreatureName
	else:
		$Page/Creature.texture = load(get_parent().LockedCreature)
	
	if Global.planets_visited[type] > 19:
		$Page/Landscape.texture = get_parent().Landscape
	else:
		$Page/Landscape.texture = load(get_parent().LockedLandscape)
	
	

func _on_ExitButton_pressed():
	get_parent().get_parent().pageOpen = false
	queue_free()
