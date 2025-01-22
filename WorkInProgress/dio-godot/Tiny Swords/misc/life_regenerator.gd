extends Node2D

@export var regeneration_amount: int = 7

@onready var area2d: Area2D

var stop_timer: bool = false
var time_process: float = 0.0


func _ready():
	area2d = $Area2D
	#area2d.body_entered.connect(on_body_entered)

func _process(delta) -> void:
	if time_process > 0.5:
		var bodies = area2d.get_overlapping_bodies()
		for body in bodies:
			if body.is_in_group("player"):
				var player: Player = body
				if player.health < player.max_health:
					#print("Overlapping!")
					regen_health(player)
	
	if not stop_timer:
		time_process += delta
		
		if time_process >= 55:
			stop_timer = true
			fade_out()

#func on_body_entered(body: Node2D) -> void: # Não é mais necessária após alteração no _process()
	#if time_process < 0.5:
		#return
	#if body.is_in_group("player"):
		#var player: Player = body
		
		#if player.health < player.max_health:
			#print("Body entered!") # Não está sendo chamada duas vezes
			#regen_health(player)

func fade_out():
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(self, "modulate", Color(1, 1, 1, 0), 5)
	await tween.finished
	queue_free()

func regen_health(player) -> void:
	player.heal(regeneration_amount)
	player.meat_collected.emit(regeneration_amount)
	queue_free()
