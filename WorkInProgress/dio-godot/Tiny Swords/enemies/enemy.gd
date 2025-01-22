class_name Enemy
extends Node2D

signal earn_exp
#signal attack_popup

@export_category("Damage")
@export var enemy_damage: int = 1

@export_category("Life")
var max_health: int
@export var health: int = 5
@export var death_prefab: PackedScene
var damage_digit_prefab: PackedScene

@onready var damage_number_marker = $DamageMarker
@onready var enemy_collision = $CollisionShape2D

@export_category("Drops")
@export var drop_chance: float = 0.1
@export var drop_items: Array[PackedScene]
@export var drop_chances: Array[float]

var distance_to_player: float

var enemy_exp: int = 3
var group_exp: Dictionary = {
	"sheep": 1,
	"pawns": 5,
	"goblin1": 20,
	"archers": 40,
	"goblin2": 50,
	"boss": 100
}

func _ready() -> void:
	max_health = health
	self.motion_mode = 1
	damage_digit_prefab = preload("res://misc/damage_number.tscn")
	
	for group in group_exp:
		if self.is_in_group(group):
			enemy_exp = group_exp[group]

func _process(_delta) -> void:
	check_distance_to_player()

func damage(amount: int, damage_type: String) -> void:
	health -= amount
	#print(health)

	modulate = Color(0.8,0,0.1)
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, "modulate", Color.WHITE, 0.5)
	
	var damage_number = damage_digit_prefab.instantiate()
	damage_number.value = amount
	damage_number.damage_type = damage_type
	damage_number.z_index += 2
	
	#print(damage_number.get_path())
	#emit_signal("attack_popup", damage_type)
	#var damage_number_label = damage_number.get_node("Node2D/Label")
	#match damage_type:
		#"physical_type":
			#damage_number.get_child(0).get_child(0).label_settings.font_color = Color(1, 0.353, 0.361)
			#damage_number_label.label_settings.font_color = Color(1, 0.353, 0.361)
		#"ritual_type":
			#damage_number.get_child(0).get_child(0).label_settings.font_color = Color(0.306, 0.353, 0.773)
			#damage_number_label.label_settings.font_color = Color(0.306, 0.353, 0.773)
			#print(damage_type)
	if health > 0:
		if damage_number_marker:
			damage_number.global_position = damage_number_marker.position
			damage_number_marker.get_parent().add_child(damage_number)
		else:
			damage_number.global_position = global_position - Vector2(0, 40)
			get_parent().get_parent().add_child(damage_number)
	if health <= 0:
		if damage_number_marker:
			damage_number.global_position = damage_number_marker.global_position
		else:
			damage_number.global_position = global_position - Vector2(0, 40)
		get_parent().get_parent().add_child(damage_number)
		die()

func die() -> void:
	#print("Exp: ", enemy_exp)
	emit_signal("earn_exp", enemy_exp)
	#earn_exp.emit(enemy_exp)
	#print("Enemy died and signal emitted!")
	
	var random_number = randf()
	if random_number <= drop_chance:
		#if self.is_in_group("sheep"):
			#print("Matou ovelha! Drop chance: ", drop_chance, " Random Number: ", random_number)
		drop_item()
	
	GameManager.monsters_defeated_counter += 1
		
	if death_prefab:
		var death_object = death_prefab.instantiate()
		death_object.position = self.position
		get_parent().add_child(death_object)
	
	queue_free()

func drop_item() -> void:
	var drop = get_random_drop_item().instantiate()
	drop.position = self.position
	get_parent().add_child(drop)

func get_random_drop_item() -> PackedScene:
	if drop_items.size() == 1:
		return drop_items[0]
	var max_chance: float = 0.0
	for dc in drop_chances:
		max_chance += dc
		
	var random_value = randf() * max_chance
	
	var needle: float = 0.0
	for i in drop_items.size():
		var di = drop_items[i]
		var dc = drop_chances[i] if i < drop_chances.size() else drop_chances[0]
		if random_value <= dc + needle:
			return di
		needle += dc
	return drop_items[0]

func check_distance_to_player() -> void:
	distance_to_player = position.distance_to(GameManager.player_position)
	#print(distance_to_player)
	if (distance_to_player >= 2000) and (not self.is_in_group("boss")):
		free_distant_enemy()

func free_distant_enemy():
	queue_free()
