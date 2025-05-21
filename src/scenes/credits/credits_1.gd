extends Node2D
@onready var transition_anim_exit: AnimationPlayer = $TransitionExit/TransitionAnimExit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_exit_pressed() -> void:
	transition_anim_exit.play("SceneExit")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://src/scenes/main_menu.tscn")
