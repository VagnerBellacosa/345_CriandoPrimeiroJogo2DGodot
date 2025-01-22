class_name GameOverUI
extends CanvasLayer

@onready var time_label: Label = %TimeLabelValue
@onready var monsters_label: Label = %MonsterLabelValue
@onready var player_level_label: Label = %LevelLabelValue
@onready var game_over_label: Label = %GameOverMessage

@export var restart_delay: float = 5.0

var gold_counter: int

var restart_cooldown:float
#var time_survived: String
#var monsters_defeated: int

func _ready() -> void:
	time_label.text = GameManager.time_process_string
	monsters_label.text = str(GameManager.monsters_defeated_counter)
	player_level_label.text = str(GameManager.player_level)
	gold_counter = GameManager.gold_counter
	if gold_counter == 0:
		game_over_label.text = "You failed. Let's try again!"
		game_over_label.add_theme_color_override("font_color", Color(0.54, 0, 0))
	else:
		game_over_label.text = "Congratulations! You got the treasure!"
		game_over_label.add_theme_color_override("font_color", Color(0, 0.4, 0))
	#meat_label.text = str(GameManager.meat_counter)
	
	#time_label.text = time_survived
	#monsters_label.text = str(monsters_defeated)
	restart_cooldown = restart_delay

func _process(delta) -> void:
	restart_cooldown -= delta
	
	if restart_cooldown <= 0 and gold_counter == 0:
		restart_game()

func restart_game() -> void:
	GameManager.reset()
	get_tree().reload_current_scene()
