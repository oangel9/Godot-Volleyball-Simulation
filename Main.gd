extends Node2D

var score = Score.new(Vector2(0,0))

var practice_team1 = generate_random_team()
var practice_team2 = generate_random_team()


var board = Board.new(practice_team1, practice_team2, score)
var is_already_served = false
#This function will simulate a single point of a set


var game_is_not_over = true
#Team1 will be left score
#Team2 will be right score

func play_a_point(team_serving, team_receiving):
	var serving_stat = board.get_serving_stat(team_serving)
	if is_already_served == false:	
		if board.determine_probability(serving_stat):
			print("Serve: ", serving_stat)
			##if is_already_served == false:
			is_already_served = true
			var defensive_stat = board.randomly_serve_at_player(team_receiving)
			
			if board.is_received(serving_stat, defensive_stat):
				print("Good dig! ", defensive_stat, "%")
				var player_hitting = board.randomly_set_a_player(team_receiving)
				var check_difficulty = board.check_hitting_difficulty(team_receiving,player_hitting,team_serving)
				if board.determine_probability(check_difficulty):
					print("Attack goes through: ", check_difficulty )
					var player_digging = board.randomly_choose_defender(team_serving)
					if board.is_defended(player_hitting.attack, player_digging.defense):
						print("Oh man, good Defense")
						play_a_point(team_serving, team_receiving)
					else:
						print("The ball was killed ")
						score.add_point_left()
						is_already_served = false
						board.update_rotation(team_receiving)
				else:
					print("Attack is missed: ")
					score.add_point_right()
					is_already_served = false
					board.update_rotation(team_receiving)
			else:
				print("Unable to be digged: ")
				score.add_point_left()
				is_already_served = false
				board.update_rotation(team_receiving)
			
	
	
	#Here's where you want to play_rally() function
	else:
		var defensive_stat = board.randomly_serve_at_player(team_receiving)
		if board.is_received(serving_stat, defensive_stat):
			print("Good dig yo")
			#Reference of the game object that is currently hitting (player_hitting)
			var player_hitting = board.randomly_set_a_player(team_receiving)
			if board.determine_probability(board.check_hitting_difficulty(team_receiving,player_hitting,team_serving)):
				print("There's a hit!")
				var player_digging = board.randomly_choose_defender(team_serving)
					
				if board.is_defended(player_hitting.attack, player_digging.defense):
					play_a_point(team_serving, team_receiving)
				else: 
					score.add_point_right()
					is_already_served = false
					print("Crazy")
					board.update_rotation(team_receiving)
			else:
				score.add_point_right()
				is_already_served = false
				print("Crap")
				board.update_rotation(team_receiving)
		else:
			print("It's okay, that was a good hit")
			score.add_point_left()
			is_already_served = false	
			board.update_rotation(team_receiving)	
	
	

#func randomly_create_player() -> Object:
#	var rand_stat =  randf_range(.5,.9)
#	var list_of_names = ["OH1", "OH2", "MB1", "Lib", "RS", "S"]
#	list_of_names.shuffle()
#	var player = Player.new(list_of_names[0], rand_stat,rand_stat,rand_stat,rand_stat)
#	#print(player.name_position,player.attack,player.defense,player.serve, player.block)
#	return player	
	
func generate_random_team() -> Dictionary:
	var team = {}
	var list_of_names = ["OH1", "OH2", "MB1", "Lib", "RS", "S"]
	for i in range(1,7):
		var atk_stat =  randf_range(.85,.9)
		var def_stat =  randf_range(.85,.9)
		var serve_stat =  randf_range(.85,.9)
		var block_stat =  randf_range(.85,.9)
		list_of_names.shuffle()
		#print(list_of_names)
		var index = list_of_names.size()- 1
		var player = Player.new(list_of_names[index], atk_stat, def_stat, serve_stat, block_stat)
		team[player] = i
		list_of_names.pop_back()
	return team

	
#func random_position() -> String:
#	var list_of_names = ["OH1", "OH2", "MB1", "Lib", "RS", "S"]
#	
#	var name = list_of_names[0]
#	print(name)
#	return name
	
func play_rally():
	# This going to be general function to repeat the defended, set, and attacked cyclying of playing a point
	pass	
	
	
func _process(delta):
#	if(game_is_not_over):
#
	if Input.is_action_just_pressed("ui_accept"):
#			#play_a_point(team1, team2)
		print("-----------------------------------")
#
#
#			if board.scored(practice_team1):
#				play_a_point(practice_team1,practice_team2)
#
#			elif board.scored(practice_team2):
#				play_a_point(practice_team2,practice_team2)

		play_a_point(practice_team2,practice_team2)				
			#print(random_position())
			#var player = randomly_create_player()
	
