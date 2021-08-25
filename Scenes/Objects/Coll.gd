extends Area2D

signal update_money
signal add_player_hp
signal play_coin_sound
enum Types {COIN, HEART}
var type = Types.COIN

func _ready():
	connect("update_money", get_parent(),"update_money")
	connect("add_player_hp", get_parent(),"add_player_hp")
	connect("play_coin_sound", get_parent(),"coin_sound")
	type = randi() % (1 + int(Global.player_hp < Global.player_max_hp))
	match type:
		Types.COIN:
			if randi()%5==0:
				$AnimatedSprite.animation = "gold_coin"
			else:
				$AnimatedSprite.animation = "coin"
		Types.HEART:
			$AnimatedSprite.animation = "heart"



func _on_Collectible_body_entered(body):
	emit_signal("play_coin_sound")
	match type:
		Types.COIN:
			Global.money += 20
			emit_signal("update_money")
		Types.HEART:
			emit_signal("add_player_hp")
	queue_free()
