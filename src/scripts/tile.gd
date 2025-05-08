extends Button

var original_x_rot := 0.0
var original_y_rot := 0.0
@export var angle_x_max: float = 35.0
@export var angle_y_max: float = 35.0
@onready var shader_material: ShaderMaterial = $SubViewportContainer.material as ShaderMaterial
@onready var sprite2d: AnimatedSprite2D = $SubViewportContainer/SubViewport/AnimatedSprite2D
@onready var audio: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"

var is_blocked: bool = false

func _ready() -> void:
	shader_material = shader_material.duplicate()
	$SubViewportContainer.material = shader_material

func _process(delta: float) -> void:
	pass

func _on_gui_input(event: InputEvent) -> void:
	if is_blocked:
		return

	var mouse_pos: Vector2 = get_local_mouse_position()
	var diff: Vector2 = (position + size) - mouse_pos
	
	var lerp_val_x: float = remap(mouse_pos.x, 0.0, size.x, 0, 1)
	var lerp_val_y: float = remap(mouse_pos.y, 0.0, size.y, 0, 1)
	
	var rot_x: float = rad_to_deg(lerp_angle(angle_x_max, -angle_x_max, lerp_val_x))
	var rot_y: float = rad_to_deg(lerp_angle(angle_y_max, -angle_y_max, lerp_val_y))
	
	shader_material.set_shader_parameter("x_rot", rot_y)
	shader_material.set_shader_parameter("y_rot", rot_x)

func _on_mouse_exited() -> void:
	if is_blocked:
		return

	shader_material.set_shader_parameter("x_rot", original_x_rot)
	shader_material.set_shader_parameter("y_rot", original_y_rot)

func _on_button_down() -> void:
	if is_blocked:
		return

	sprite2d.scale = Vector2(0.8, 0.8)

func _on_button_up() -> void:
	if is_blocked:
		return

	sprite2d.scale = Vector2(1, 1)

	# Agregar esta casilla a la lista global si no ha sido visitada
	var tile_id = str(global_position)
	if tile_id not in Global.visited_tiles:
		Global.visited_tiles.append(tile_id)
		#marcar_como_bloqueada()

func _on_mouse_entered() -> void:
	if is_blocked:
		return

	audio.play()

	
