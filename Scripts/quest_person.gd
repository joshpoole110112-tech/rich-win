extends CharacterBody2D
var in_collision: bool = false
func _process(_delta: float) -> void:
	if in_collision:
		if Input.is_action_just_pressed("Interact"):
			DialogueManager.show_example_dialogue_balloon(load("uid://rub3eqesw0ni"))
			Global.player_freeze = true
	await DialogueManager.dialogue_ended
	Global.player_freeze = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	in_collision = true

func _on_area_2d_body_exited(body: Node2D) -> void:
	in_collision = false
