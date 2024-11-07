class_name Program
extends Control

const ADD_RECIPE_MENU = preload("res://Menus/add_recipe_menu.tscn")
const MAIN_MENU = preload("res://Menus/main_menu.tscn")
const ADD_INGREDIENT_MENU = preload("res://Menus/add_ingredient_menu.tscn")
const INGREDIENTS_MENU = preload("res://Menus/ingredients_menu.tscn")
const RECIPES_MENU = preload("res://Menus/recipes_menu.tscn")

static var scene_map : Dictionary = {
	Helpers.Scenes.ingredients : INGREDIENTS_MENU.instantiate(),
	Helpers.Scenes.recipes : RECIPES_MENU.instantiate(),
	Helpers.Scenes.add_recipe : ADD_RECIPE_MENU.instantiate(),
	Helpers.Scenes.main_menu : MAIN_MENU.instantiate(),
	Helpers.Scenes.add_ingredient : ADD_INGREDIENT_MENU.instantiate(),
}

var current_scene : Control
var previous_scene : Control


func _ready() -> void:
	await(get_tree().physics_frame)
	load_data()
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
		quit_program()
		return
	
	var new_scene : Control = scene_map[scene]
	if new_scene == null:
		push_error("Scene not found")
		return
	
	if current_scene.has_method("clear_scene"):
		current_scene.clear_screen()
	remove_child(current_scene)
	SceneBuffer.add_scene_to_queue(current_scene)
	current_scene = new_scene
	add_child(current_scene)
	if current_scene.has_method("load_scene"):
		current_scene.load_scene()


func quit_program() -> void:
	#var save_file = FileAccess.open("user://savegame.food", FileAccess.WRITE)
	# Needs a solid look. Somehow save data is being overwritten
	var save_file = FileAccess.open("save.food", FileAccess.WRITE)
	
	for node in get_tree().get_nodes_in_group("Save"):
		var node_data : Dictionary = node.save()
		var json_string = JSON.stringify(node_data)
		save_file.store_line(json_string)
		print("%s saved" % node.name)
	
	get_tree().quit()
	
func load_data() -> void:
	# Needs work. Might be overwriting somehow
	if not FileAccess.file_exists("save.food"):
		print("Save file not found")
		return
	var save_file = FileAccess.open("save.food", FileAccess.READ)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		var node_data = json.data

		# Firstly, we need to create the object and add it to the tree and set its position.
		var new_object = load(node_data["Filename"]).instantiate()
		get_node(node_data["Parent"]).add_child(new_object)

		# Now we set the remaining variables.
		for i in node_data.keys():
			if i == "Filename" or i == "Parent":
				continue
			new_object.set(i, node_data[i])
		if new_object is Ingredient:
			new_object.name = new_object.ingredient_name
