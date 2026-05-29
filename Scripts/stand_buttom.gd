extends Button

@export var buttom: Texture2D
@export var buttom_pressed: Texture2D

func _ready() -> void:
	icon = buttom

func _on_button_up() -> void:
	icon = buttom

func _on_button_down() -> void:
	icon = buttom_pressed
