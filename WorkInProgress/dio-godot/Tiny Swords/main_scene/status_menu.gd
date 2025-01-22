extends CanvasLayer

@onready var level_label: RichTextLabel = %LevelLabel
@onready var hp_label: RichTextLabel = %HPLabel
@onready var defeated_label: RichTextLabel = %DefeatedLabel
@onready var sword_label: RichTextLabel = %SwordLabel
@onready var ritual_label: RichTextLabel = %RitualLabel
@onready var objective_label: Label = %ObjectiveLabel

@export var player: Player

func _ready():
	visible = false
	player = get_parent().find_child("Player") # Não utilizado

func _process(_delta):
	if Input.is_action_pressed("show_menu") and GameManager.is_game_over == false:
		visible = true
	else:
		visible = false
	var health_proportion: float = (GameManager.player_health / GameManager.player_max_hp)
	var health_color: String
	
	if health_proportion >= 0.8:
		health_color = "[color=green]"
	elif health_proportion >= 0.3:
		health_color = "[color=yellow]"
	else:
		health_color = "[color=red]"
	hp_label.text = ("Health Points:  " + health_color + str(GameManager.player_health) + "/" 
	+ str(GameManager.player_max_hp) + "[/color]")
	defeated_label.text = "Enemies Defeated:  [color=#949494]" + str(GameManager.monsters_defeated_counter) + "[/color]"
	level_label.text = "Player Level:  [color=#FFA500]" + str(GameManager.player_level) + "[/color]  (max: 25)"
	sword_label.text = "Sword Damage:  [color=#FF5A5C]" + str(GameManager.player_damage) + "[/color]"
	ritual_label.text = "Magic Damage:  [color=#4E5AC5]" + str(GameManager.player_ritual) + "[/color]"
	#objective_label.text = ("[center] Find the 4 shadow areas, defeat the monters those areas spawn and collect their treasure [/center]")
