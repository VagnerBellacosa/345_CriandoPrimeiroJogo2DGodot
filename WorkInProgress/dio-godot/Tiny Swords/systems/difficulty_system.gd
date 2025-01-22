extends Node

@export var mob_spawner: MobSpawner
@export var initial_spawn_rate: float = 120.0
@export var spawn_rate_per_minute: float = 30.0
@export var wave_duration: float = 60.0
@export var break_intensity: float = 0.0

var process_time: float = 0.0

func _process(delta: float) -> void:
	if GameManager.is_game_over:
		return
	
	process_time += delta
	
	# TODO process_time deve ser "corrigido" após derrotar um chefão <<<<<<<<<<<<<<<<
	@warning_ignore("integer_division")
	var spawn_rate = initial_spawn_rate + spawn_rate_per_minute * ((roundi(process_time) % 60)/ 60)
	var sin_wave = sin((process_time * TAU) / wave_duration)
	var wave_factor = remap(sin_wave, -1.0, 1.0, break_intensity, 2.0)
	#print("Time: %.2f, Wave: %.2f" % [process_time, sin_wave])
	#print("Sin Wave: ", sin_wave , " Wave Factor: ",  wave_factor)
	if wave_factor < 0.5:
		wave_factor = 0
	
	spawn_rate *= wave_factor
	mob_spawner.mobs_per_minute = spawn_rate
	#print("Sin Wave: ", sin_wave , " Wave Factor: ",  wave_factor, " Spawn Rate: ", spawn_rate)
