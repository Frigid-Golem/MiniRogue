extends Node

const CELL_SIZE = 16

var logger: MessageLog = null
var game_manager = null

func log(message: String, color: Color = Color.WHITE):
	if logger == null:
		print(message)
	else:
		logger.on_message_received(message, color)
