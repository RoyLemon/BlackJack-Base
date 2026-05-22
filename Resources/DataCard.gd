extends Resource
class_name CardData

var card_value: int = 0

enum CardID {
	A,
	TWO,
	THREE,
	FOUR,
	FIVE,
	SIX,
	SEVEN,
	EIGHT,
	NINE,
	TEN,
	JOKER,
	QUEEN,
	KING
}

enum CardType {
	CLUBS,
	DIAMONDS,
	HEARTS,
	SPADES
}

func update_value():
	match card_id:
		CardID.A:
			card_value = 11
		CardID.TWO:
			card_value = 2
		CardID.THREE:
			card_value = 3
		CardID.FOUR:
			card_value = 4
		CardID.FIVE:
			card_value = 5
		CardID.SIX:
			card_value = 6
		CardID.SEVEN:
			card_value = 7
		CardID.EIGHT:
			card_value = 8
		CardID.NINE:
			card_value = 9
		_:
			card_value = 10


@export var card_type: CardType
@export var card_id: CardID:
	set(value):
		card_id = value
		update_value()
@export var back_sprite: Texture2D
@export var front_sprite: Texture2D
