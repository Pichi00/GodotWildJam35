extends Control

export (Texture) var Icon
export (String) var Title
export (String) var Description
export (int) var Price

func _ready():
	$LeftPanel/Icon.texture = Icon
	$LeftPanel/Title.text = Title
	$LeftPanel/Price.text = str(Price)
	$RightPanel/Description.text = Description
	rect_size = Vector2(100, 60)
	match Title:
		"Level":
			Price = Global.level * 30
			$LeftPanel/Price.text = str(Price)

func _input(event):
	$LeftPanel/BuyButton.disabled = bool(Global.money < Price)



func _on_BuyButton_pressed():
	match Title:
		"Level":
			Global.level += 1
			Price = Global.level * 30
			$RightPanel/Value.text = str(Global.level)
			$LeftPanel/Price.text = str(Price)
