extends Node2D


@onready var area2d: Area2D

var gold_amount: int = 1
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
				#var player: Player = body
				#print("Overlapping!")
				GameManager.gold_counter += 1
				queue_free()
	
	time_process += delta
		
	if time_process >= 20 and GameManager.gold_counter < 3:
		stop_timer = true
		GameManager.gold_counter += 1
		queue_free()

#func on_body_entered(body: Node2D) -> void: # Não é mais necessária após alteração no _process()
	#if time_process < 0.5:
		#return
	#if body.is_in_group("player"):
		#var player: Player = body

#func fade_out():
	#var tween = create_tween()
	#tween.set_ease(Tween.EASE_OUT)
	#tween.set_trans(Tween.TRANS_BOUNCE)
	#tween.tween_property(self, "modulate", Color(1, 1, 1, 0), 5)
	#await tween.finished
	#queue_free()

#func collect_gold(player) -> void:
	#player.SOMEFUNCTION(gold_amount)
	#player.gold_collected.emit(gold_amount)
	#queue_free()
