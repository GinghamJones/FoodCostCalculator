class_name Ingredient
extends Node

var ingredient_name : String
var cost_per_pound : float

func _ready() -> void:
	print("%s has been created" % ingredient_name)


func save() -> Dictionary:
	var save_dict : Dictionary = {
		"Filename" : get_scene_file_path(),
		"Parent" : get_parent().get_path(),
		"Name" : ingredient_name,
		"Cost" : cost_per_pound
	}
	return save_dict
