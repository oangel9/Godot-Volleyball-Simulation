class_name Board extends Node2D

var team1: Dictionary
var team2: Dictionary
var score_board: Score
var board_positions: Array


func _init(first_team, second_team, score):
	team1 = first_team
	team2 = second_team
	score_board = score
	board_positions = [1,2,3,4,5,6]
	
func initiate_game():
	return board_positions.size()
	
	
# This method will determine the pass "quality", a value between 1 to 3
func pass_level(team1, team2) -> int:
	#if defender is great, give a 3 pass
	if team1.get("OH1").attack > team2.get("OH1").defense:
		return 1
	return 2
	#if defender is average, give a 2 pass
	
	#if defender is bad, return 1 pass


# This method will account for that passing level and then proceed with the next action
func pass_result(pass_level_val):
	if pass_level_val == 3:
		pass
		#print("Aguaaaaa")
	elif pass_level_val == 2:
		pass
		#print("We can work with it..")
	else:
		pass
		#print("... Better luck next time!")
		
		
#  This function takes percertanges and returns a boolean regarding its excecution		
func determine_probability(team_player_stat) -> bool:
	if team_player_stat > randf():
		return true
	return false
	
func get_serving_stat(dict_players) -> float: # Takes in a dictionary of players, for loops and finds the one in pos 1
	var player_in_one
	for player in dict_players:
		if dict_players[player] == 1: 
			player_in_one = player
	return player_in_one.serve
	
#func get_serve_state(dict_player):
#	print(dict_player.get(1).serve)
#	return dict_player.get(1).serve
#

func randomly_serve_at_player(dict_players) -> float:
	var players_serve_receiving = []
	for player in dict_players:
		#print(player.player_position)
		if player.name_position == "OH1" or player.name_position == "OH2" or player.name_position == "Lib":
			players_serve_receiving.append(player)
	#var index_in_list = helper_random_list_pick(players_serve_receiving)
	#print(players_serve_receiving)
	players_serve_receiving.shuffle()
	return players_serve_receiving[0].defense


func is_received(serve_stat, defensive_stat) -> bool:
	var prob_of_receiving = serve_stat * defensive_stat
	print(prob_of_receiving)
	return determine_probability(prob_of_receiving)
	
func randomly_set_a_player(dict_players) -> Object:
	var players_that_can_hit = []
	for player in dict_players:
		#print(player.player_position)
		if player.name_position == "OH1" or player.name_position == "OH2" or player.name_position == "RS":
			players_that_can_hit.append(player)
	
	#print(players_serve_receiving)
	players_that_can_hit.shuffle()
	return players_that_can_hit[0]
	
# Returns percentage that determines the chances of a succesful attack.
func check_hitting_difficulty(player_hitting_in_dict, player_hitting, dict_players_blocking) -> float:

	'''
		4       3       2
		5		6		1
	'''

	var cur_pos_in_board = player_hitting_in_dict.get(player_hitting)
	var list_of_blockers = []
	
	if cur_pos_in_board == 4: 
		for player in dict_players_blocking:
			if dict_players_blocking.get(player) == 2:
				list_of_blockers.append(player)
			if dict_players_blocking.get(player) == 3:
				if player.can_it_get_there():
					list_of_blockers.append(player)

	elif cur_pos_in_board == 3: 
		for player in dict_players_blocking:
			if dict_players_blocking.get(player) == 3:
				list_of_blockers.append(player)
			if dict_players_blocking.get(player) == 4 or dict_players_blocking.get(player) == 2:
				if player.can_it_get_there():
					list_of_blockers.append(player)
	
	elif cur_pos_in_board == 2:
		for player in dict_players_blocking:
			if dict_players_blocking.get(player) == 4:
				list_of_blockers.append(player)
			if dict_players_blocking.get(player) == 3:
				if player.can_it_get_there():
					list_of_blockers.append(player)	
		#Blockers from 
	#var player_hitting_position = player_hitting_in_dict[]
	
	var hitting_percent = player_hitting.attack
	for player in list_of_blockers:
		hitting_percent = hitting_percent * player.block
	print("Hitting Percentage is: " , hitting_percent)
	return hitting_percent
		

func randomly_choose_defender(dict_enemies_defending) -> Object:
	var players_defending = []
	for player in dict_enemies_defending:
		var cur_player = dict_enemies_defending[player]
		if cur_player == 1 or cur_player == 5 or cur_player == 6:
			players_defending.append(player)
	players_defending.shuffle()
	print("Player randomly chose to defend is: " , players_defending[0].name_position)
	return players_defending[0]
	
		
#Can do quick update so that it follows what i have been doing for stat check
func is_defended(attack_stat, defensive_stat) -> bool:
	var prob_of_receiving = attack_stat * defensive_stat
	return determine_probability(prob_of_receiving)
	
func update_rotation(team_that_scored):
	for player in team_that_scored:
		if team_that_scored[player] == 6:
			team_that_scored[player] = 1
		else:
			team_that_scored[player] +=1
		#print(team_that_scored.get(player))

	
	
	
