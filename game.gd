extends Control

var board: Array
var player: String
var gameWinner: bool = false
var gameDraw: bool = false 
var gameOver: bool = false

var unpress = preload("res://cirno.png")
var p1 = preload("res://reimu.png")
var p2 = preload("res://marisa.png")

func init_board() -> void:
	board = [
		"0", "0", "0",
		"0", "0", "0",
		"0", "0", "0"
	]
	$Board/Row0/Btn0.texture_normal = unpress
	$Board/Row0/Btn1.texture_normal = unpress
	$Board/Row0/Btn2.texture_normal = unpress
	$Board/Row1/Btn3.texture_normal = unpress
	$Board/Row1/Btn4.texture_normal = unpress
	$Board/Row1/Btn5.texture_normal = unpress
	$Board/Row2/Btn6.texture_normal = unpress
	$Board/Row2/Btn7.texture_normal = unpress
	$Board/Row2/Btn8.texture_normal = unpress
	gameDraw = false
	gameWinner = false
	gameOver = false
	
func init_player() -> void:
	player = "reimu"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GameOverScreen.hide()
	init_board()
	init_player()
	
func update_player() -> void:
	if player == "reimu":
		player = "marisa"
	else:
		player = "reimu"

func is_row_matched() -> bool:
	var offset = 0
	for row in range(3):
		for i in range(0 + offset, 3 + offset):
			if board[i] == player:
				gameWinner = true
			else:
				gameWinner = false
				break
		if gameWinner == true:
			return true
		offset += 3
	return false
	
func is_col_matched() -> bool:
	var offset = 0
	for columm in range(3):
		for i in range(0 + offset, 7 + offset, 3):
			if board[i] == player:
				gameWinner = true
			else:
				gameWinner = false
				break
		if gameWinner:
			return true
		offset += 1
	return false
	
func is_diag_matched() -> bool:
	for i in range(0, 9, 4):
		if board[i] == player:
			gameWinner = true
		else:
			gameWinner = false
			break
	if gameWinner:
		return true
	for i in range(2, 7, 2):
		if board[i] == player:
			gameWinner = true
		else:
			gameWinner = false
			break
	if gameWinner:
		return true
	return false
	
func is_board_full() -> bool:
	if board.has("0"):
		return false
	return true

func check_gameOver() -> void:
	if is_col_matched() || is_row_matched() || is_diag_matched():
		gameOver = true
		show_gameOver()
	elif is_board_full():
		gameDraw = true
		gameOver = true
		show_gameOver()
		
func show_gameOver() -> void:
	if gameDraw:
		$GameOverScreen/Container/Label.text = "Game draw!!"
	else:
		$GameOverScreen/Container/Label.text = player + " wins!!"
	$GameOverScreen.show()

func make_move(index: int) -> void:
	board[index] = player
	check_gameOver()
	
func is_square_free(index: int) -> bool:
	if board[index] == "0":
		return true
	return false
	
func update_board(row: int, index: int) -> void:
	var path = "Board/Row" + str(row) + "/Btn" + str(index)
	if player == "reimu":
		get_node(path).texture_normal = p1
	elif player == "marisa":
		get_node(path).texture_normal = p2
	update_player()


# SIGNALS
# Signal for button 0
func _on_btn_0_button_up() -> void:
	if is_square_free(0) && !gameOver:
		make_move(0)
		update_board(0, 0)

# Signal for button 1
func _on_btn_1_button_up() -> void:
	if is_square_free(1) && !gameOver:
		make_move(1)
		update_board(0, 1)

# Signal for button 2
func _on_btn_2_button_up() -> void:
	if is_square_free(2) && !gameOver:
		make_move(2)
		update_board(0, 2)

# Signal for button 3
func _on_btn_3_button_up() -> void:
	if is_square_free(3) && !gameOver:
		make_move(3)
		update_board(1, 3)

# Signal for button 4
func _on_btn_4_button_up() -> void:
	if is_square_free(4) && !gameOver:
		make_move(4)
		update_board(1, 4)

# Signal for button 5
func _on_btn_5_button_up() -> void:
	if is_square_free(5) && !gameOver:
		make_move(5)
		update_board(1, 5)

# Signal for button 6
func _on_btn_6_button_up() -> void:
	if is_square_free(6) && !gameOver:
		make_move(6)
		update_board(2, 6)

# Signal for button 7
func _on_btn_7_button_up() -> void:
	if is_square_free(7) && !gameOver:
		make_move(7)
		update_board(2, 7)

# Signal for button 8
func _on_btn_8_button_up() -> void:
	if is_square_free(8) && !gameOver:
		make_move(8)
		update_board(2, 8)

func _on_button_button_up():
	$GameOverScreen.hide()
	init_board()
	init_board()
