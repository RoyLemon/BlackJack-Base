extends Resource
class_name CardData

enum CardID {
	A, TWO, THREE,
	FOUR, FIVE, SIX, 
	SEVEN, EIGHT, NINE, 
	TEN, JOKER, QUEEN, KING
}

enum CardType {
	CLUBS,
	DIAMONDS,
	HEARTS,
	SPADES
}

@export var card_id: CardID
@export var card_type: CardType
@export var card_value: int
@export var back_sprite: Texture2D
@export var front_sprite: Texture2D
