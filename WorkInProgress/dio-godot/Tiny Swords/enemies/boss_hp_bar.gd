extends ProgressBar

@onready var boss_canvas_layer: CanvasLayer = %BossHPCanvas
@onready var boss_hp_bar: ProgressBar = %BossHPBar
@onready var boss_hp_label: Label = %BossHPLabel
@onready var boss_sheep: Enemy = get_parent().get_parent()

func _ready() -> void:
	position = Vector2(21, 605)
	boss_hp_bar.max_value = boss_sheep.health
	boss_hp_bar.min_value = 0
	boss_hp_bar.value = boss_sheep.health
	boss_canvas_layer.visible = true

func _process(_delta) -> void:
	boss_hp_bar.value = boss_sheep.health
	boss_hp_label.text = str(boss_sheep.health) + "/" + str(boss_sheep.max_health)

