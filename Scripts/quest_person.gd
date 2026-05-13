extends CharacterBody2D

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Interact"):
		DialogueManager.show_example_dialogue_balloon(load("uid://rub3eqesw0ni"))
		Global.player_freeze = true
	await DialogueManager.dialogue_ended
	Global.player_freeze = false
