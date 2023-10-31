class_name Player extends Node2D

var name_position: String
var attack: float # Considers this to be setting skill as well for simplicity
var defense: float  #Digs
var serve: float
var serv_recieve: float
var block: float 


func _init(p_s, atk, def, servePower,blocking):
	name_position = p_s
	attack = atk
	defense = def
	serve = servePower
	block = blocking
	
	
func can_it_get_there() -> bool:
	if randf() > .5:
		return true
	return false
