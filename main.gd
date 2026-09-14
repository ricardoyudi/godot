class_name Main
extends Node

@export var mob_scene: PackedScene

var score: int = 0

@onready var player: Player = $Player
@onready var hud: HUD = $HUD
@onready var music: AudioStreamPlayer = $Music
@onready var death_sound: AudioStreamPlayer = $DeathSound
@onready var mob_timer: Timer = $MobTimer
@onready var score_timer: Timer = $ScoreTimer
@onready var start_timer: Timer = $StartTimer
@onready var start_position: Marker2D = $StartPosition
@onready var spawn_location: PathFollow2D = %MobSpawnLocation

func game_over() -> void:
	score_timer.stop()
	mob_timer.stop()
	music.stop()
	death_sound.play()
	var new_record := GameState.submit_score(score)
	hud.show_game_over(new_record, GameState.high_score)


func new_game() -> void:
	score = 0
	player.start(start_position.position)
	start_timer.start()
	hud.update_score(score)
	hud.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")
	music.play()

func _on_start_timer_timeout() -> void:
	mob_timer.start()
	score_timer.start()

func _on_score_timer_timeout() -> void:
	score += 1
	hud.update_score(score)

func _on_mob_timer_timeout() -> void:
	var mob: Mob = mob_scene.instantiate()

	spawn_location.progress_ratio = randf()

	var direction: float = spawn_location.rotation + PI / 2
	mob.position = spawn_location.position

	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	var velocity := Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	add_child(mob)
