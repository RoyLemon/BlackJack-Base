extends Node2D
class_name CardManager

# VARIABLES

# Turnos
var player_take_card: bool = false
var dealer_take_card: bool = false

# Health
var player_max_health: int = 100
var dealer_max_health: int = 100

var player_actual_health: int = 100
var dealer_actual_health: int = 100

# Const
const MAX_VALUE := 21
const MIN_STAY_VALUE := 16
const FIRST_TWO_CARDS_PER_GAME := 2

# Export
@export var all_cards: Array[CardData]
@export var card_scene: PackedScene

# Arrays (guardan nodos carta)
var player_hand: Array = []
var dealer_hand: Array = []
var deck: Array = []

# Deck Positions
@onready var deck_position: Marker2D = $"../Markers/Deck Marker"
@onready var player_deck_position: Marker2D = $"../Markers/PlayerDeck"
@onready var dealer_deck_position: Marker2D = $"../Markers/DealerDeck"


func _ready() -> void:
	create_deck()
	start_round()


# START GAME REGION

func create_deck() -> void:
	deck.clear()
	
	all_cards.shuffle()
	
	for card_data in all_cards:
		var card_instance = card_scene.instantiate()
		card_instance.data = card_data
		card_instance.position = deck_position.position
		add_child(card_instance)
		deck.append(card_instance)


func start_round() -> void:
	if deck.is_empty(): return
	var player_card = deck.pop_back()
	var p_offset = Vector2(player_hand.size() * 100, 0)
	player_card.position = player_deck_position.position + p_offset
	player_hand.append(player_card)
		
	if deck.is_empty(): return
		
	var dealer_card = deck.pop_back()
	var d_offset = Vector2(dealer_hand.size() * 100, 0)
	dealer_card.position = dealer_deck_position.position + d_offset
	dealer_hand.append(dealer_card)


# BUTTONS
func _on_take_buttom_pressed() -> void:
	player_take_card = true
	dealer_take_card = false
	deal_cards()

func _on_stand_buttom_pressed() -> void:
	player_take_card = false
	dealer_take_card = true
	deal_cards()

# GAMEPLAY
func deal_cards() -> void:
	if deck.is_empty():
		return

	# Player turn
	if player_take_card:
		player_play(player_hand)
		if calculate_hand_value(player_hand) >= MAX_VALUE:
			check_winner(player_hand, dealer_hand)

	# Dealer turn
	if dealer_take_card:
		dealer_play(dealer_hand)
		check_winner(player_hand, dealer_hand)


func player_play(hand: Array) -> void:
	if deck.is_empty():
		return

	var card = deck.pop_front()
	var tween = create_tween()
	var offset = Vector2(hand.size() * 100, 0)
	tween.tween_property(card, "position", player_deck_position.position + offset, 0.15)
	hand.append(card)
	if calculate_hand_value(hand) >= MAX_VALUE:
		player_take_card = false


func dealer_play(hand: Array) -> void:
	while calculate_hand_value(hand) < MIN_STAY_VALUE:
		var card = deck.pop_front()
		var tween = create_tween()
		var offset = Vector2(hand.size() * 100, 0)
		tween.tween_property(card, "position", dealer_deck_position.position + offset, 0.15)
		hand.append(card)
	dealer_take_card = false


func calculate_hand_value(hand: Array) -> int:
	var total_value := 0
	
	for card in hand:
		total_value += card.data.card_value
	return total_value


func check_winner(p_hand: Array, d_hand: Array) -> void:
	var player_value := calculate_hand_value(p_hand)
	var dealer_value := calculate_hand_value(d_hand)

	print("Player:", player_value)
	print("Dealer:", dealer_value)

	# BUST (>21)
	if player_value > MAX_VALUE:
		player_actual_health -= dealer_value
		if check_game_over(): return
		start_new_round()
		return

	if dealer_value > MAX_VALUE:
		dealer_actual_health -= player_value
		if check_game_over(): return
		start_new_round()
		return

	# BLACKJACK EXACTO
	if player_value == MAX_VALUE and dealer_value != MAX_VALUE:
		dealer_actual_health -= MAX_VALUE
		if check_game_over(): return
		start_new_round()
		return

	if dealer_value == MAX_VALUE and player_value != MAX_VALUE:
		player_actual_health -= MAX_VALUE
		if check_game_over(): return
		start_new_round()
		return

	# COMPARACION NORMAL
	if dealer_value > player_value:
		player_actual_health -= (dealer_value - player_value)
		if check_game_over(): return
		start_new_round()
		return

	if player_value > dealer_value:
		dealer_actual_health -= (player_value - dealer_value)
		if check_game_over(): return
		start_new_round() 
		return

	# EMPATE
	if dealer_value == player_value:
		print("EMPATE!")
		if check_game_over(): return
		start_new_round()
		return

# CASO EXTRA
	print("Se está omitiendo algún caso")


# RESTART GAME REGION
func start_new_round() -> void:
	print("Nuevo round")

	player_take_card = false
	dealer_take_card = false

	# Destruir cartas viejas
	for card in deck:
		card.queue_free()

	for card in player_hand:
		card.queue_free()

	for card in dealer_hand:
		card.queue_free()

	deck.clear()
	player_hand.clear()
	dealer_hand.clear()
	create_deck()
	start_round()


func check_game_over() -> bool:
	if player_actual_health <= 0 and dealer_actual_health <= 0:
		print("Game Over, Empate")
		return true

	if player_actual_health <= 0:
		print("Game Over, Perdiste")
		return true

	if dealer_actual_health <= 0:
		print("¡Ganaste!")
		return true

	return false
