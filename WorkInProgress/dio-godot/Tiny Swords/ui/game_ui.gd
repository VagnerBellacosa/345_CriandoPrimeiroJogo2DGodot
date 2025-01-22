extends CanvasLayer

@onready var timer_label = %TimerLabel
@onready var gold_label = %GoldLabel
@onready var meat_label = %MeatLabel


#var count_process: int = 0
var time_physics_process: float = 0.0
#var count_physics_process: int = 0

#func _ready() -> void:
	#GameManager.player.meat_collected.connect(on_meat_collected) # Lógica foi para "player"

func _process(_delta:float) -> void:
	timer_label.text = GameManager.time_process_string
	#monsters_label.text = str(GameManager.monsters_defeated_counter)
	meat_label.text = str(GameManager.meat_counter)
	gold_label.text = str(GameManager.gold_counter)

#func _physics_process(_delta:float) -> void:
	#count_physics_process += 1
	#time_physics_process += _delta
	#print("Time_physics_process: ", time_physics_process)
	#print("Count_physics_process: ", count_process)
	#pass

#func on_meat_collected(_regeneration_value:int) -> void:
	#meat_counter += 1
	#meat_label.text = str(meat_counter)
