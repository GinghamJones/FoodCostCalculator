extends Node

enum Scenes{
	main_menu,
	ingredients,
	recipes,
	add_user,
	add_recipe,
	add_ingredient,
	change_ingredient,
	change_recipe,
	back,
	quit,
}

var program : Program


func display_error(message : String) -> void:
	var error_window : AcceptDialog = AcceptDialog.new()
	error_window.show()
	error_window.position += Vector2i(50, 50)
	error_window.dialog_text = message
	add_child(error_window)
	await(error_window.confirmed)
	error_window.queue_free()
