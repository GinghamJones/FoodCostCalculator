extends Control

@onready var ingredient_list: GridContainer = $ScrollContainer/IngredientList
var ingredient_map : Dictionary

# Vars for adding new ingredient
var line_edit_new_name : LineEdit
var line_edit_new_cost : CostLineEdit
var confirm_button : Button
var adding_ingredient : bool = false
var new_ing_name : String
var new_ing_cost : float


func load_scene() -> void:
	for child in ingredient_list.get_children():
		child.queue_free()
	
	for ing : Ingredient in IngredientStore.get_children():
		print("loading %s" % ing.ingredient_name)
		var line_edit_name : LineEdit = LineEdit.new()
		line_edit_name.name = ing.ingredient_name + "Name"
		line_edit_name.editable = false
		ingredient_list.add_child(line_edit_name)
		line_edit_name.text = ing.ingredient_name
		line_edit_name.size_flags_horizontal = SizeFlags.SIZE_FILL # Why doesn't this work???
		
		var line_edit_cost : CostLineEdit = CostLineEdit.new()
		line_edit_cost.text_changed.connect(Callable(line_edit_cost, "cost_changed"))
		print(line_edit_cost.get_class())
		line_edit_cost.editable = false
		line_edit_cost.name = ing.ingredient_name + "Cost"
		ingredient_list.add_child(line_edit_cost)
		line_edit_cost.text = str(ing.cost_per_pound)
		ingredient_map[ing] = [line_edit_name, line_edit_cost]
		
		var edit_button : Button = Button.new()
		edit_button.text = "Edit"
		ingredient_list.add_child(edit_button)
		# Create edit button here that's named after each ingredient that will contact lineedits on ing
		# to allow renaming/repricing


func _on_add_button_pressed() -> void:
	if adding_ingredient:
		return
	
	line_edit_new_name = LineEdit.new()
	ingredient_list.add_child(line_edit_new_name)
	line_edit_new_name.text_changed.connect(Callable(self, "name_changed"))
	
	line_edit_new_cost = CostLineEdit.new()
	line_edit_new_cost.text_changed.connect(Callable(line_edit_new_cost, "cost_changed"))
	line_edit_new_cost.text_changed.connect(Callable(self, "cost_changed"))
	ingredient_list.add_child(line_edit_new_cost)
	
	confirm_button = Button.new()
	ingredient_list.add_child(confirm_button)
	confirm_button.text = "Confirm"
	confirm_button.pressed.connect(Callable(self, "add_ingredient"))
	adding_ingredient = true


func cost_changed(text : String) -> void:
	new_ing_cost = text.to_float()


func name_changed(text : String) -> void:
	new_ing_name = text


func add_ingredient() -> void:
	var new_ing : Ingredient = Ingredient.new()
	new_ing.ingredient_name = new_ing_name
	new_ing.cost_per_pound = new_ing_cost
	var is_success : bool = IngredientStore.add_ingredient(new_ing)
	if not is_success:
		new_ing.queue_free()
	
	confirm_button.queue_free()
	confirm_button = null
	line_edit_new_cost.queue_free()
	line_edit_new_cost = null
	line_edit_new_name.queue_free()
	line_edit_new_name = null
	load_scene()


func _on_back_pressed() -> void:
	Helpers.program.change_scene(Helpers.Scenes.back)
