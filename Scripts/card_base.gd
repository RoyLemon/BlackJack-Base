extends Area2D

var data: CardData

# Components
@onready var sprite : Sprite2D = $Sprite2D

var value = data.card_value
var id = data.card_id
var front_sprite = data.front_sprite
