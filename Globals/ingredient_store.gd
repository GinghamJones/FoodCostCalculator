extends Node

var ingredients : Array[Ingredient]


func add_ingredient(i : Ingredient) -> bool:
	print("ingredient adding....")
	for ing in ingredients:
		if ing.ingredient_name == i.ingredient_name:
			Helpers.display_error("Ingredient already exists. Consider editing instead")
			return false
	
	ingredients.push_back(i)
	add_child(i)
	print("ingredient added")
	return true
