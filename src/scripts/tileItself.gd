extends Node2D
@onready var button: Button = $Button
@onready var label: Label = $Button/SubViewportContainer/SubViewport/Label
var ValueX;
var ValueY;



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func setValues(x:int, y:int) -> void:
	ValueX = x
	ValueY = y
	
func changeContent(content: String, type: String, m: int) -> void:
	if(m == 0):
		label.text = ""
		label.add_theme_color_override("font_color", Color.WHITE)
	else:
		label.text = content
		label.add_theme_color_override("font_color", Color.RED)

func _on_button_pressed() -> void:
	Global.pressed = true;
	Global.posPressed = Vector2(ValueX, ValueY)
