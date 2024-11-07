class_name CostLineEdit
extends LineEdit

func cost_changed(value : String) -> void:
	for i in text.length():
		if text[i] != "." and not text[i].is_valid_float():
			delete_char_at_caret()
