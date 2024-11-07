class_name Ingredient
extends Node

var ingredient_name : String
var brand : String
var cost_per_pound : float


func _ready() -> void:
	print("%s has been created" % ingredient_name)


func save() -> Dictionary:
	var save_dict : Dictionary = {
		"Filename" : get_scene_file_path(),
		"Parent" : get_parent().get_path(),
		"ingredient_name" : ingredient_name,
		"cost_per_pound" : cost_per_pound,
		"brand" : brand
	}
	return save_dict
