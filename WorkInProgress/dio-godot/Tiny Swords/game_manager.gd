extends Node

signal game_over

var player: Player
var player_position: Vector2
var boss_active: bool = false
var is_game_over: bool = false

var time_process: float = 0.0
var time_process_string: String
var meat_counter: int = 0
var gold_counter: int = 0
var monsters_defeated_counter: int = 0
var player_level: int = 0
var player_max_hp: float = 0
var player_health: float = 0
var player_damage: int = 0
var player_ritual: int = 0
var tab_pressed: bool = false

func _process(delta:float) -> void:
	if tab_pressed:
		#count_process += 1
		time_process += delta
		if gold_counter > 0:
			await get_tree().create_timer(3).timeout
			end_game()
		#print("Time_process: ", time_process)
		#print("Count_process: ", count_process)
		var time_elapsed_in_seconds: int = floori(time_process)
		#if time_elapsed_in_seconds % 60 < 10:
			#timer_label.text = str(floori(time_elapsed_in_seconds/60), ":0", time_elapsed_in_seconds % 60)
		#else:
			#timer_label.text = str(floori(time_elapsed_in_seconds/60), ":", time_elapsed_in_seconds % 60)
		var seconds: int = time_elapsed_in_seconds % 60
		@warning_ignore("integer_division")
		var minutes: int = time_elapsed_in_seconds / 60
		time_process_string = "%02d:%02d" % [minutes, seconds]

func end_game():
	if is_game_over:
		return
	
	is_game_over = true
	game_over.emit()
	tab_pressed = false

func reset():
	player = null
	player_position = Vector2.ZERO
	is_game_over = false
	time_process = 0
	time_process_string = "00:00"
	meat_counter = 0
	gold_counter = 0
	monsters_defeated_counter = 0
	
	for connection in game_over.get_connections():
		game_over.disconnect(connection.callable)
