extends ProgressBar

@export var player: CardManager
@onready var ghost_bar: ProgressBar = $ProgressBar

func _ready() -> void:
	max_value = player.player_max_health
	value = max_value

func _process(delta: float) -> void:
	value = player.player_actual_health * 100 / player.player_max_health

func take_damage() -> void:
	var actual_value = self.value
	if actual_value == self.value: return
	
	await get_tree().create_timer(0.5).timeout
	var tween = create_tween()
	tween.tween_property(ghost_bar, "value", self.value, 1.25)
