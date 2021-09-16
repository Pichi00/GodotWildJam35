extends Node

var money = 0
var player_max_hp = 10
var player_hp = 10
var player_speed = 90
var player_speed_lvl = 1
var player_damage = 1
var level = 1
var soundOn = true
var soundLevel = -40
var gun_level = 1

const MAX_LEVEL = 4
const MAX_DMG = 2.5
const MAX_SPEED_LVL = 3



enum PLANETS {BROWN,YELLOW,GREEN,PINK,ICE,PURPLE,RED,DARK,LIGHT}
var planets_unlocked = [false,false,false,false,false,false,false,false,false]
var planets_visited = [0,0,0,0,0,0,0,0,0]

#chances to spawn planets
var chances_lvl1 = [0, 49, 50, 79, 80, 99, 100, 101, 102, 103]
var chances_lvl2 = [0, 24, 25, 49, 50, 74, 75, 99, 100, 101]
var chances_lvl3 = [0, 24, 25, 49, 50, 74, 75, 99, 100, 101]
var chances_lvl4 = [0, 24, 25, 49, 50, 74, 75, 99, 100, 101]
var chances = [chances_lvl1, chances_lvl2, chances_lvl3, chances_lvl4]

#chances to spawn enemies
var e_chances_lvl1 = [0, 99, 100, 101, 102, 103]
var e_chances_lvl2 = [0, 69, 70, 99, 100, 101]
var e_chances_lvl3 = [0, 29, 30, 69, 70, 99]
var e_chances_lvl4 = [0, 9, 10, 59, 60, 99]
var e_chances = [e_chances_lvl1, e_chances_lvl2, e_chances_lvl3, e_chances_lvl4]



