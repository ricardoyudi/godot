extends Node

const SAVE_PATH := "user://savegame.cfg"

var high_score: int = 0

func _ready() -> void:
	_load()

func submit_score(value: int) -> bool:
	if value <= high_score:
		return false
	high_score = value
	_save()
	return true

func _save() -> void:
	var config := ConfigFile.new()
	config.set_value("progress", "high_score", high_score)
	config.save(SAVE_PATH)

func _load() -> void:
	var config := ConfigFile.new()
	if config.load(SAVE_PATH) != OK:
		return
	high_score = config.get_value("progress", "high_score", 0)
