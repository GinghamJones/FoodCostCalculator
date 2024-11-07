class_name MainMenu
extends Control

func _on_ingredients_pressed() -> void:
	Helpers.program.change_scene(Helpers.Scenes.ingredients)

func _on_quit_pressed() -> void:
	Helpers.program.change_scene(Helpers.Scenes.quit)

func _on_calculate_cost_pressed() -> void:
	pass # Replace with function body.

func _on_recipes_pressed() -> void:
	Helpers.program.change_scene(Helpers.Scenes.recipes)
