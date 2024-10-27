extends Control

var ing_name : String = ""
var ing_cost : float = 0
var ingredient_scene : PackedScene = preload("res://Objects/ingredient.tscn")
@onready var name_input : LineEdit = get_node("EnterName/InputField")
@onready var cost_input : LineEdit = get_node("EnterCost/InputField")


func _on_confirm_button_pressed() -> void:
	ing_cost = cost_input.text.to_float()
	ing_name = name_input.text
	if ing_name == "" or ing_cost == 0:
		Helpers.display_error("Please enter valid info")
		return
	
	var new_ingredient : Ingredient = ingredient_scene.instantiate()
	new_ingredient.ingredient_name = ing_name
	new_ingredient.cost_per_pound = ing_cost
	IngredientStore.add_ingredient(new_ingredient)
	Helpers.program.change_scene(Helpers.Scenes.back)
	
	# Reset fields
	name_input.clear()
	cost_input.clear()
