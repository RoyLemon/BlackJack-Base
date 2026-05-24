extends CardEffect
class_name DealerGetDamage

func apply(card_manager: CardManager) -> void:
	card_manager.dealer_actual_health -= 25
