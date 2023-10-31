class_name Score extends Node2D

var score: Vector2

func _init(score_):
	score = score_	
	
func add_point_left():
	score.x = score.x + 1

func add_point_right():
	score.y = score.y + 1

func won_set():
	if score.x == 25 or score.y == 25:
		return true
	return false
