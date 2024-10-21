class_name Program
extends Control

const ADD_RECIPE_MENU = preload("res://Menus/add_recipe_menu.tscn")
const LOGIN = preload("res://Menus/login.tscn")
const MAIN_MENU = preload("res://Menus/main_menu.tscn")
const ADD_INGREDIENT_MENU = preload("res://Menus/add_ingredient_menu.tscn")


static var scene_map : Dictionary = {
	Helpers.Scenes.add_recipe : ADD_RECIPE_MENU.instantiate(),
	Helpers.Scenes.login : LOGIN.instantiate(),
	Helpers.Scenes.main_menu : MAIN_MENU.instantiate(),
	Helpers.Scenes.add_ingredient : ADD_INGREDIENT_MENU.instantiate(),
}

var current_scene : Control
var previous_scene : Control


func _ready() -> void:
	await(get_tree().physics_frame)
	Helpers.program = self
	current_scene = scene_map[Helpers.Scenes.main_menu]
	add_child(current_scene)


func change_scene(scene : Helpers.Scenes) -> void:
	if scene == Helpers.Scenes.back:
		remove_child(current_scene)
		current_scene = SceneBuffer.get_last_scene_in_queue()
		add_child(current_scene)
		return
	elif scene == Helpers.Scenes.quit:
		pass # And should do quit stuff
	
	var new_scene : Control = scene_map[scene]
	if new_scene == null:
		push_error("Scene not found")
		return
		
	remove_child(current_scene)
	SceneBuffer.add_scene_to_queue(current_scene)
	current_scene = new_scene
	add_child(current_scene)
