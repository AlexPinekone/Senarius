extends Node2D

@onready var points: RichTextLabel = $Points
@onready var transition_anim_exit: AnimationPlayer = $TransitionExit/TransitionAnimExit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	points.bbcode_text = "[wave amp=50.0 freq=5.0 connected=1][color=#ffffff]" +str(Global.totalPoints)+ "[/color][/wave]"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_start_pressed() -> void:
	Global.resetValues()
	transition_anim_exit.play("SceneExit")
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://src/scenes/baseMap.tscn")


func _on_button_exit_pressed() -> void:
	get_tree().quit()
