class_name HUD
extends CanvasLayer

signal start_game

@onready var message: Label = $Message
@onready var score_label: Label = $ScoreLabel
@onready var start_button: Button = $StartButton
@onready var message_timer: Timer = $MessageTimer

func show_message(text: String) -> void:
	message.text = text
	message.show()
	message_timer.start()

func show_game_over(new_record: bool, high_score: int) -> void:
	if new_record:
		show_message("New Record!\n%d" % high_score)
	else:
		show_message("Game Over\nRecord: %d" % high_score)

	await message_timer.timeout

	message.text = "Dodge the\nCreeps!"
	message.show()

	await get_tree().create_timer(1.0).timeout
	start_button.show()

func update_score(value: int) -> void:
	score_label.text = str(value)

func _on_start_button_pressed() -> void:
	start_button.hide()
	start_game.emit()

func _on_message_timer_timeout() -> void:
	message.hide()
