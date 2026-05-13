extends Sprite2D
@onready var respawn: Timer = $respawn
var poss: Vector2
func _ready():
	poss = global_position

func _on_area_2d_area_entered(_area: Area2D) -> void:
	respawn.start()
	self.position = Vector2(0, 1000000000)
func _on_respawn_timeout() -> void:
	self.global_position = poss
