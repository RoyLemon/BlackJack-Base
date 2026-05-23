extends ProgressBar

@export var dealer : CardManager

func _ready() -> void:
	max_value = dealer.dealer_max_health

func _process(delta: float) -> void:
	value = dealer.dealer_actual_health * 100 / dealer.dealer_max_health
