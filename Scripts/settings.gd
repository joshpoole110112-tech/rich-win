extends Control

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var vol_value: Label = $vol_value

func _on_volume_value_changed(value: float) -> void:
	vol_value.text = str(value)
	AudioServer.set_bus_volume_db(0,value)
	if not audio_stream_player.playing:
		audio_stream_player.play()

func _on_mute_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0,toggled_on)


func _on_resolution_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920, 1080))
		1:
			DisplayServer.window_set_size(Vector2i(1600, 900))
		2:
			DisplayServer.window_set_size(Vector2i(1280, 720))


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("uid://d0q8tfdwn5xs7")
