extends Control

# Referencias
@onready var rect_array : Array[TextureRect] = [$TextureRect, $TextureRect2, $TextureRect3]


func _on_button_button_up() -> void:
	# Primero detener todos los rodillos
	for i in range(rect_array.size()):
		await get_tree().create_timer(1.25).timeout
		rect_array[i].material.set_shader_parameter("scroll_speed", 0)
		rect_array[i].material.set_shader_parameter("offset", randf())
		 
	# Luego leer resultados
	var results = []
	for rect in rect_array:
		var offset = rect.material.get_shader_parameter("offset")
		results.append(get_symbol(offset))
		
	if results[0] == results[1] and results[1] == results[2]:
		print("JACKPOT!")
	else:
		print("Sin premio")
	
	
func get_symbol(offset: float) -> int:
		return int(offset * 4) # 0, 1, 2 o 3
