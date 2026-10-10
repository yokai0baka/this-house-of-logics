extends Node3D

@export var key_type = String("")

var in_range = false


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area is PlayerInteractionZone:
		$MeshInstance3D2.visible = true
		in_range = true

func _on_area_3d_area_exited(area: Area3D) -> void:
	if area is PlayerInteractionZone:
		$MeshInstance3D2.visible = false
		in_range = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") && in_range:
		Global.keys_obtained.append(key_type)
		self.queue_free()
