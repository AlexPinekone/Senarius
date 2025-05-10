extends Node2D

@onready var tile_spin: AnimationPlayer = $Tile/TileSpin
var progress = []
var sceneName
var scene_load_status = 0
@onready var tile: Node2D = $Tile

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sceneName = "res://src/scenes/baseMap.tscn"
	tile.get_node("Button").disabled = true
	await get_tree().create_timer(1.5).timeout
	#tile.get_node("Button").disabled = true
	ResourceLoader.load_threaded_request(sceneName)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scene_load_status = ResourceLoader.load_threaded_get_status(sceneName,progress)
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var newScene = ResourceLoader.load_threaded_get(sceneName)
		get_tree().change_scene_to_packed(newScene)
