extends Node2D

@export var game_ui: CanvasLayer
@export var game_over_ui_template: PackedScene
@export var boss_list: PackedScene

@onready var player: Player = $Player
@onready var boss_marker_1: Marker2D = $Boss1Area/Marker2D
@onready var boss_marker_2: Marker2D = $Boss2Area/Marker2D
@onready var boss_marker_3: Marker2D = $Boss3Area/Marker2D
@onready var boss_marker_4: Marker2D = $Boss4Area/Marker2D
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer


var boss_spawned = false

func _ready() -> void:
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	audio_player.play()
	GameManager.game_over.connect(trigger_game_over)
	# position == global_position porque o node Main é o "global"
	#player.global_position = Vector2(576, 324)
	#player.global_position = Vector2(1700, 1250)
	#player.global_position = Vector2(16000, 9000)
	player.global_position = Vector2(0, 0)
	#var boss_enemy = boss_list.instantiate()
	#print($Boss1Area/Marker2D.global_position)
	#boss_enemy.set_scale(Vector2(2,2)) ## Necessário reduzir scale do damage_number pela metade
	#boss_enemy.position = $Boss1Area/Marker2D.global_position
	#add_child(boss_enemy)

func trigger_game_over():
	if game_ui:
		game_ui.queue_free()
		game_ui = null # "Zerar" variável
	
	#preload("res://ui/game_over_ui.tscn") 
	
	var game_over_ui: GameOverUI = game_over_ui_template.instantiate()
	#game_over_ui.monsters_defeated = 0
	#game_over_ui.time_survived = "00:00"
	add_child(game_over_ui)

func _on_boss_1_area_body_entered(body):
	spawn_boss(body, boss_marker_1)

func _on_boss_2_area_body_entered(body):
	spawn_boss(body, boss_marker_2)

func _on_boss_3_area_body_entered(body):
	spawn_boss(body, boss_marker_3)

func _on_boss_4_area_body_entered(body):
	spawn_boss(body, boss_marker_4)

func spawn_boss(body, marker):
	if body is Player and boss_spawned == false:
			var boss_enemy = boss_list.instantiate()
			boss_enemy.position = marker.global_position
			call_deferred("add_child", boss_enemy)
			boss_spawned = true
