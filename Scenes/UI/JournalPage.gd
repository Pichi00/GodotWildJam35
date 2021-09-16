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
	
	if Global.planets_visited[type] > 4:
		$Page/Creature.texture = get_parent().Creature
		$Page/CreatureName.text = get_parent().CreatureName
		$Page/CreatureCounter.hide()
	else:
		$Page/Creature.texture = load(get_parent().LockedCreature)
		$Page/CreatureCounter.text = str(Global.planets_visited[type])+" / 5"
		$Page/CreatureCounter.show()
	
	if Global.planets_visited[type] > 9:
		$Page/Landscape.texture = get_parent().Landscape
		$Page/LandscapeCounter.hide()
	else:
		$Page/Landscape.texture = load(get_parent().LockedLandscape)
		$Page/LandscapeCounter.text = str(Global.planets_visited[type])+" / 10"
		$Page/LandscapeCounter.show()

func _input(event):
	if event.is_action_pressed("pause"):
		_on_ExitButton_pressed()

func _on_ExitButton_pressed():
	get_parent().get_parent().pageOpen = false
	queue_free()
