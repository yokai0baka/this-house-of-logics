extends Node3D

func next_room():
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://scenes/" + Global.next_room + ".tscn")
