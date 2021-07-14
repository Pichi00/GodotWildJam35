extends Node

var money = 0
var player_max_hp = 10
var player_hp = 10
var first_bullet = true
var game_state

enum PLANETS {DIRT,GREEN, PINK, ICE, EARTH, X}
enum STATES {MAIN_MENU, GAMEPLAY, PAUSE}
