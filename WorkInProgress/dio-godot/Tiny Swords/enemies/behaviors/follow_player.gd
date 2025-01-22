extends Node
#extends CharacterBody2D

@export var speed: float = 1.5
#@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
var sprite: AnimatedSprite2D

var enemy: Enemy

func _ready() -> void:
	enemy = get_parent()
	sprite = enemy.get_node("AnimatedSprite2D")

func _physics_process(_delta: float) -> void:
	if GameManager.is_game_over:
		return
	if enemy.is_in_group("boss"):
		if (roundi(GameManager.time_process) % 5) >= 3.5:
			speed = 5
		else: speed = 2
	
	var player_position = GameManager.player_position
	var difference = player_position - enemy.position
	var input_vector = difference.normalized()
	
	enemy.velocity = input_vector * speed * 100
	enemy.move_and_slide()
	
	if input_vector.x > 0 :
		sprite.flip_h = false
	elif input_vector.x < 0:
		sprite.flip_h = true
