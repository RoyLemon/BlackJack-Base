extends ProgressBar

@export var player: CardManager

func _ready() -> void:
	max_value = player.player_max_health

func _process(delta: float) -> void:
	value = player.player_actual_healt * 100 / player.player_max_health
