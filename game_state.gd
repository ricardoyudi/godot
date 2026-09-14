extends Node

var high_score: int = 0

func submit_score(value: int) -> bool:
	if value <= high_score:
		return false
	high_score = value
	return true