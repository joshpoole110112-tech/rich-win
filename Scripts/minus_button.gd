extends Control

func _on_texture_button_pressed() -> void:
	Global.bank_text -= 1
	if Global.bank_text < 0:
		Global.bank_text = 0
