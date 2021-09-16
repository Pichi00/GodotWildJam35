extends Control

export (Texture) var Icon
export (String) var Title
export (String, MULTILINE) var Description
export (int) var Price

func _ready():
	$LeftPanel/Icon.texture = Icon
	$LeftPanel/Title.text = Title
	$LeftPanel/Price.text = str(Price)
	$RightPanel/Description.text = Description
	
	rect_size = Vector2(100, 60)
	update_price()

func _input(event):
	match Title:
		"Level":
			if(Global.level < Global.MAX_LEVEL ):
				$LeftPanel/BuyButton.disabled = bool(Global.money < Price)
			else:
				$LeftPanel/BuyButton.disabled =true
		"Damage":
			if(Global.player_damage < Global.MAX_DMG ):
				$LeftPanel/BuyButton.disabled = bool(Global.money < Price)
			else:
				$LeftPanel/BuyButton.disabled =true
		"Speed":
			if(Global.player_speed_lvl < Global.MAX_SPEED_LVL ):
				$LeftPanel/BuyButton.disabled = bool(Global.money < Price)
			else:
				$LeftPanel/BuyButton.disabled =true



func _on_BuyButton_pressed():
	Global.money -= Price
	get_tree().get_nodes_in_group("Level")[0].update_money()
	match Title:
		"Level":
			Global.level += 1
			Price = Global.level * 60
			$LeftPanel/Price.text = str(Price)
			if Global.level >= Global.MAX_LEVEL:
				$LeftPanel/BuyButton.disabled = true
				$LeftPanel/Price.text = "MAX"
			$RightPanel/Value.text = str(Global.level)
		"Damage":
			Global.player_damage += 0.5
			Price = Global.player_damage * 100
			$LeftPanel/Price.text = str(Price)
			if Global.player_damage >= Global.MAX_DMG:
				$LeftPanel/BuyButton.disabled = true
				$LeftPanel/Price.text = "MAX"
			$RightPanel/Value.text = str(Global.player_damage)
		"Speed":
			Global.player_speed += 20
			Global.player_speed_lvl += 1
			Price = Global.player_speed_lvl * 50
			$LeftPanel/Price.text = str(Price)
			if Global.player_speed_lvl >= Global.MAX_SPEED_LVL:
				$LeftPanel/BuyButton.disabled = true
				$LeftPanel/Price.text = "MAX"
			$RightPanel/Value.text = str(Global.player_speed_lvl)
	Global.save_game()

func update_price():
	match Title:
		"Level":
			Price = Global.level * 60
			$RightPanel/Value.text = str(Global.level)
			if Global.level >= Global.MAX_LEVEL:
				$LeftPanel/Price.text = "MAX"
			else:
				$LeftPanel/Price.text = str(Price)
		"Damage":
			Price = Global.player_damage * 50
			$RightPanel/Value.text = str(Global.player_damage)
			if Global.player_damage >= Global.MAX_DMG:
				$LeftPanel/Price.text = "MAX"
			else:
				$LeftPanel/Price.text = str(Price)
		"Speed":
			Price = Global.player_speed_lvl * 50
			$RightPanel/Value.text = str(Global.player_speed_lvl)
			if Global.player_speed_lvl >= Global.MAX_SPEED_LVL:
				$LeftPanel/Price.text = "MAX"
			else:
				$LeftPanel/Price.text = str(Price)
