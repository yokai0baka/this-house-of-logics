extends Node3D

@export var door_destination = ""

var in_range = false


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area is PlayerInteractionZone:
		in_range = true

func _on_area_3d_area_exited(area: Area3D) -> void:
	if area is PlayerInteractionZone:
		in_range = false


func _ready() -> void:
	pass # Replace with function body.

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") && in_range:
		if door_destination in Global.keys_obtained:
			get_tree().change_scene_to_file("res://scenes/" + door_destination + ".tscn")
		else:
			print("You have'nt a key")
