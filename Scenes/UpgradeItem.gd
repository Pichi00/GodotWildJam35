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
