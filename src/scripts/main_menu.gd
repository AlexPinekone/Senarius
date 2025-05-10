extends Node2D

var progress = []
var sceneName
var scene_load_status = 0
@onready var transition_anim_exit: AnimationPlayer = $TransitionExit/TransitionAnimExit

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_start_pressed() -> void:
	transition_anim_exit.play("SceneExit")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://src/scenes/loadingScreen.tscn")


func _on_button_credits_pressed() -> void:
	pass # Replace with function body.


func _on_button_exit_pressed() -> void:
	get_tree().quit()
