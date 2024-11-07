extends Control

var ings : Array[Ingredient]
@onready var ingredient_buttons: GridContainer = $IngredientButtons
var ings_for_recipe : Array[IngredientForRecipe]
var current_selected_ing : Ingredient
var current_selected_ing_amount : float
var unit_edit_menu : MenuButton


func load_scene() -> void:
	# Setup when initially visiting page
	for ing in IngredientStore.get_children():
		if ing is Ingredient:
			ings.push_back(ing)
	
	for i : Ingredient in ings:
		# Button for choosing ingredient to add
		var button : Button = Button.new()
		button.text = i.ingredient_name
		ingredient_buttons.add_child(button)
		button.connect("pressed", Callable(self, "add_ingredient"))
		
		var amount_edit : LineEdit = LineEdit.new()
		ingredient_buttons.add_child(amount_edit)
		amount_edit.placeholder_text = "Amount for recipe"
		amount_edit.connect("text_changed", Callable(self, "edit_amount"))
		
		var unit_edit : MenuButton = MenuButton.new()
		unit_edit_menu = unit_edit
		ingredient_buttons.add_child(unit_edit)
		unit_edit.text = "Select unit"
		unit_edit.get_popup().add_item("Cups", 0)
		unit_edit.get_popup().add_item("Tbsp", 1)
		unit_edit.get_popup().add_item("Tsp", 2)
		unit_edit.get_popup().connect("index_pressed", Callable(self, "change_unit_edit_text"))


func select_ingredient(ing_name : String) -> void:
	for i in ings:
		if i.ingredient_name == ing_name:
			current_selected_ing = i
			return
	
	Helpers.display_error("Couldn't find ingredient??? What the hell...")


func edit_amount(amount : String) -> void:
	current_selected_ing_amount = amount.to_float()


func add_ingredient_to_recipe() -> void:
	var new_recipe_ing : IngredientForRecipe = IngredientForRecipe.new()
	# Not finished!!!


func _on_back_button_pressed() -> void:
	Helpers.program.change_scene(Helpers.Scenes.back)


func _on_confirm_button_pressed() -> void:
	var unit_index : int = unit_edit_menu.get_popup().get_focused_item()
	var unit : IngredientForRecipe.Units
	match unit_index:
		0: unit = IngredientForRecipe.Units.cups
		1: unit = IngredientForRecipe.Units.tbsp
		2: unit = IngredientForRecipe.Units.tsp
	
	var recipe : Recipe = Recipe.new()
	#Not finished!!!!


func change_unit_edit_text(index : int) -> void:
	unit_edit_menu.text = unit_edit_menu.get_popup().get_item_text(index)


func clear_scene() -> void:
	for child in ingredient_buttons.get_children():
		child.queue_free()
	for i in ings_for_recipe:
		ings_for_recipe.erase(i)
	current_selected_ing = null
