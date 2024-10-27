extends Node

var scenes : Array

func add_scene_to_queue(scene) -> void:
	scenes.push_back(scene)

func get_last_scene_in_queue() -> Control:
	var scene_to_pass = scenes[0]
	scenes.pop_front()
	return scene_to_pass
