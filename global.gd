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

const MAX_LEVEL = 4
const MAX_DMG = 3
const MAX_SPEED_LVL = 3



enum PLANETS {DIRT,GREEN, PINK, ICE, EARTH, X}
var planets_unlocked = [false,false,false,false,false,false]
var chances_lvl1 = [0, 49, 50, 79, 80, 99, 100, 101, 102, 103]
var chances_lvl2 = [0, 34, 35, 64, 65, 84, 85, 99, 100, 101]
var chances_lvl3 = [0, 14, 15, 34, 35, 54, 55, 84, 85, 99]
var chances_lvl4 = [0, 9, 10, 19, 20, 29, 30, 39, 40, 49]
var chances = [chances_lvl1, chances_lvl2, chances_lvl3, chances_lvl4]



