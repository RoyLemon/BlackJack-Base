extends Node2D

# Variables
var player_take_card: bool = false
var dealer_take_card: bool = false

# Const
const MAX_VALUE = 21
const MIN_STAY_VALUE = 16

# export
@export var all_cards: Array[CardData]

# Arrays
var player_hand: Array[CardData]
var dealer_hand: Array[CardData]
var deck: Array[CardData]

func _ready() -> void:
	create_deck()
	start_round()

# START GAME REGION - START
func create_deck() -> void:
	all_cards.shuffle()
	
	for card in all_cards:
		deck.append(card)

func start_round() -> void:
	var FIRST_TWO_CARDS_PER_GAME = 2
	
	for i in range(FIRST_TWO_CARDS_PER_GAME):
		player_hand.append(deck.pop_front())
		dealer_hand.append(deck.pop_front())
# START GAME REGIN - END

# CALCULATE GAME REGION - START
func _on_take_buttom_pressed() -> void:
	player_take_card = true
	dealer_take_card = false
	deal_cards()

func _on_stand_buttom_pressed() -> void:
	player_take_card = false
	dealer_take_card = true
	deal_cards()

func deal_cards() -> void:
	if (deck.is_empty()): return
	
	if (player_take_card):
		player_play(player_hand)
		
		if (calculate_hand_value(player_hand) >= MAX_VALUE):
			check_winner(player_hand, dealer_hand)
	
	if (dealer_take_card):
		dealer_play(dealer_hand)
		check_winner(player_hand, dealer_hand)
	

func player_play(hand: Array[CardData]) -> void:
	hand.append(deck.pop_front())
	
	if (calculate_hand_value(hand) >= MAX_VALUE):
		player_take_card = false
		return


func dealer_play(hand: Array[CardData]) -> void:
	while (calculate_hand_value(hand) < MIN_STAY_VALUE):
		hand.append(deck.pop_front())
	dealer_take_card = false


func calculate_hand_value(hand: Array[CardData]) -> int:
	var total_value: int = 0
	for value in hand:
		total_value += value.card_value
	return total_value


func check_winner(p_hand: Array[CardData], d_hand: Array[CardData]):
	var player_value: int = calculate_hand_value(p_hand)
	var dealer_value: int = calculate_hand_value(d_hand)
	
	# Bust (>21)
	if (player_value > MAX_VALUE): 
		print("Dealer Gana!")
		print("Player: " + str(player_value), " Dealer: " + str(dealer_value))
		start_new_round()
		return

	if (dealer_value > MAX_VALUE): 
		print("Player Gana!")
		print("Player: " + str(player_value), " Dealer: " + str(dealer_value))
		start_new_round()
		return
	
	# BlackJack Exacto
	if (player_value == MAX_VALUE): 
		print("Player Gana!")
		print("Player: " + str(player_value), " Dealer: " + str(dealer_value))
		start_new_round()
		return
	
	if (dealer_value == MAX_VALUE): 
		print("Dealer Gana!")
		print("Player: " + str(player_value), " Dealer: " + str(dealer_value))
		start_new_round()
		return
	
	# Comparacion Normal
	if (dealer_value > player_value): 
		print("Dealer Gana!")
		print("Player: " + str(player_value), " Dealer: " + str(dealer_value))
		start_new_round()
		return
		
	if (player_value > dealer_value): 
		print("Player Gana!")
		print("Player: " + str(player_value), " Dealer: " + str(dealer_value))
		start_new_round()
		return
	
	# Empate
	if (dealer_value == player_value): 
		print("EMPATE!")
		print("Player: " + str(player_value), " Dealer: " + str(dealer_value))
		start_new_round()
		return
	
	print("Se esta omitiendo algun caso")


# Restart Game Region - Start
func start_new_round() -> void:
	deck.clear()
	player_hand.clear()
	dealer_hand.clear()
	create_deck()
	start_round()
