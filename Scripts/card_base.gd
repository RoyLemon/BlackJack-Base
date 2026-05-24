extends Area2D

var data: CardData

# Components
@onready var sprite : Sprite2D = $Sprite2D
@onready var anim : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	sprite.texture = data.back_sprite

func flip_card() -> void:
	anim.play("flip")
	sprite.texture = data.front_sprite
