extends Node

@export var object_templates:Array[PackedScene]

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			print(event)
			spawn_object(event.position)

func spawn_object(box_position: Vector2) -> void:
	randomize()
	var index:int = randi_range(0, object_templates.size() - 1)
	var box_rotation:int = randi_range(0, 180)
	var object_template = object_templates[index]
	var object:RigidBody2D = object_template.instantiate()
	object.position = box_position
	object.rotation = box_rotation
	add_child(object)
