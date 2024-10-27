class_name MainMenu
extends Control

func _on_add_ingredient_pressed() -> void:
	Helpers.program.change_scene(Helpers.Scenes.add_ingredient)

func _on_add_recipe_pressed() -> void:
	Helpers.program.change_scene(Helpers.Scenes.add_recipe)

func _on_change_ingredient_pressed() -> void:
	Helpers.program.change_scene(Helpers.Scenes.change_ingredient)

func _on_change_recipe_pressed() -> void:
	Helpers.program.change_scene(Helpers.Scenes.change_recipe)

func _on_quit_pressed() -> void:
	Helpers.program.change_scene(Helpers.Scenes.quit)

func _on_calculate_cost_pressed() -> void:
	pass # Replace with function body.
