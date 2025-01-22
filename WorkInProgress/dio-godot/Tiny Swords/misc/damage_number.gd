extends Node2D

@onready var Damage_Label = %Label

var value: float = 0
var damage_type: String = ""

func _ready() -> void:
	#var number = Label.new()
	#Damage_Label.label_settings = LabelSettings.new()
	#Damage_Label.label_settings.font_size = 24
	#Damage_Label.label_settings.font = SystemFont <<<<<<<< font_names ???
	Damage_Label.add_theme_font_size_override("font_size", 24)
	Damage_Label.text = str(value)
	match damage_type:
		"physical_type":
			#Damage_Label.label_settings.font_color = Color(1, 0.353, 0.361)
			Damage_Label.add_theme_color_override("font_color", Color(1, 0.353, 0.361))
			#Damage_Label.add_theme_color_override("font_outline_color", Color(0, 0, 0)) # Não fumciona
			#print(damage_type)
		"ritual_type":
			#Damage_Label.label_settings.font_color = Color(0.306, 0.353, 0.773)
			Damage_Label.add_theme_color_override("font_color", Color(0.306, 0.353, 0.773))
			#print(damage_type)

#func _process(_delta: float) -> void:
	#var enemies = get_tree().get_nodes_in_group("enemies")
	#for enemy in enemies:
		#if not enemy.is_connected("attack_popup", on_popup):
			#enemy.connect("attack_popup", on_popup)

#func on_popup(damage_type):
	#match damage_type:
		#"physical_type":
			##damage_number.get_child(0).get_child(0).label_settings.font_color = Color(1, 0.353, 0.361)
			#%Label.label_settings.font_color = Color(1, 0.353, 0.361)
			#print(damage_type)
		#"ritual_type":
			##damage_number.get_child(0).get_child(0).label_settings.font_color = Color(0.306, 0.353, 0.773)
			#%Label.label_settings.font_color = Color(0.306, 0.353, 0.773)
			#print(damage_type)
