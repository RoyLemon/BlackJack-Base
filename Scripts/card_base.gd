extends Area2D

var data: CardData

# Components
@onready var sprite : Sprite2D = $Sprite2D

func _ready() -> void:
	sprite.texture = data.back_sprite
