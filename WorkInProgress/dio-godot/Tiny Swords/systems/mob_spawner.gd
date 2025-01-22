class_name MobSpawner
extends Node2D

@export_category("Spawn")
@export var creatures: Array[PackedScene]
@export var spawn_chances: Array[float]

var creature_array: Array[float] = [1,0,0,0,0]
#var second_creature_array: Array[float] = [0,1,0]
#var creature_spawn_dict: Dictionary = {0:creature_array, 1:second_creature_array, 2:[0.0,0.0,1.0]} # Erro no 2
var mobs_per_minute: float # = 60.0 # Não mais exportada, agora é feito no DifficultySystem
var spawn_correction_level: int = 0
var mobs_pm_corrected: float
var counting_of_spawned_creatures: int = 0

@onready var path_follow_2d = %PathFollow2D

var cooldown: float = 0.0

var count_enemies: int

func _process(delta: float):
	if not GameManager.tab_pressed:
		return
	#print(GameManager.time_process)
	if GameManager.is_game_over:
		return
	
	count_enemies = len(get_tree().get_nodes_in_group("enemies"))
	#print(count_enemies)
	
	if count_enemies >= 100:
		return
	
	if GameManager.boss_active:
		creature_array = [0.25,0.35,0.24,0.08,0.08]
	elif GameManager.player_level < 6: #GameManager.time_process < 60:
		creature_array = [1,0,0,0,0]
		spawn_chances = creature_array
	elif (GameManager.player_level >= 6) and (GameManager.player_level < 12): #(GameManager.time_process >= 60) and (GameManager.time_process < 120):
		creature_array = [0.4,0.6,0,0,0]
		spawn_chances = creature_array
	elif (GameManager.player_level >= 12) and (GameManager.player_level < 16): #(GameManager.time_process >= 120) and (GameManager.time_process < 180):
		creature_array = [0.08,0.77,0.15,0,0]
		spawn_chances = creature_array
	elif (GameManager.player_level >= 16) and (GameManager.player_level < 20): #(GameManager.time_process >= 180) and (GameManager.time_process < 240):
		creature_array = [0.11,0.4,0.4,0.15,0.4]
		spawn_chances = creature_array
	elif (GameManager.player_level >= 20) and (GameManager.player_level < 24): #(GameManager.time_process >= 240) and (GameManager.time_process < 300):
		creature_array = [0.05,0.25,0.45,0.15,0.1]
	else:
		creature_array = [0.01,0.14,0.50,0.2,0.15]
		spawn_chances = creature_array
	cooldown -= delta
	#print("Spawn_cooldown: ", cooldown)
	#print("spawn_correction_level: ", 0spawn_correction_level, " mobs_per_minute_corrected: ", mobs_pm_corrected)
	if cooldown > 0:
		return
	
	mobs_pm_corrected = mobs_per_minute + 60 * spawn_correction_level
	var interval = 60.0/mobs_pm_corrected
	if interval > 10:
		interval = 10
	cooldown = interval
	#print("interval: ", interval)
	#var index = randi_range(0, creatures.size() - 1)
	#var creature_scene = creatures[index]
	
	spawn_creature()
	#var creature = creature_scene.instantiate()
	#creature.global_position = point
	#get_parent().add_child(creature)
	#print("interval: ", interval)
	#print("spawn_correction_level: ", spawn_correction_level)
	#print("mobs_pm_corrected: ", mobs_pm_corrected)

func get_point() -> Vector2:
	randomize()
	path_follow_2d.progress_ratio = randf()
	return(path_follow_2d.global_position)

func spawn_creature():
	#print("Spawn funcion")
	var spawned_creature = spawn_random_creature().instantiate()
	#print(type_string(typeof(spawned_creature)))
	var point = get_point()
	var world_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = point
	parameters.collision_mask = 0b1001 # Collision Mask nos layers 4 e 1 (->)
	var result: Array = world_state.intersect_point(parameters, 1)
	if not result.is_empty():
		if spawn_correction_level < 5:
			spawn_correction_level += 1
		return
	if spawn_correction_level > 0:
		spawn_correction_level -= 1
	#print("add_child")
	spawned_creature.global_position = point
	get_parent().add_child(spawned_creature)
	#return spawned_creature

func spawn_random_creature() -> PackedScene:
	#print("Spawn random funcion")
	var max_chance: float = 0.0
	for each_spawn_chance in spawn_chances:
		max_chance += each_spawn_chance
		
	var random_value = randf() * max_chance
	
	var needle: float = 0.0
	for i in creatures.size():
		var current_creature = creatures[i]
		var each_spawn_chance = spawn_chances[i] if i < spawn_chances.size() else spawn_chances[0]
		#print("Needle")
		if random_value <= each_spawn_chance + needle:
			return current_creature
		needle += each_spawn_chance
	return creatures[0]


