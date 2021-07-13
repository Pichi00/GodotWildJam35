extends Area2D

signal update_money
signal add_player_hp
enum Types {COIN, HEART}
var type = Types.COIN

func _ready():
	connect("update_money", get_parent(),"update_money")
	connect("add_player_hp", get_parent(),"add_player_hp")
	type = randi() % (1 + int(Global.player_hp < Global.player_max_hp))
	print(type)
	match type:
		Types.COIN:
			$AnimatedSprite.animation = "coin"
		Types.HEART:
			$AnimatedSprite.animation = "heart"



func _on_Collectible_body_entered(body):
	match type:
		Types.COIN:
			Global.money += 10
			emit_signal("update_money")
		Types.HEART:
			emit_signal("add_player_hp")
	queue_free()
