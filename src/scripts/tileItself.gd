extends Node2D
@onready var button: Button = $Button
@onready var label: Label = $Button/SubViewportContainer/SubViewport/Label
@onready var audio_movement: AudioStreamPlayer2D = $AudioMovement
var ValueX;
var ValueY;
var Type;
var Amount;
var Reward;
var is_blocked: bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func setValues(x:int, y:int, tipo: String, cantidad: int, reward: float) -> void:
	ValueX = x
	ValueY = y
	Type = tipo
	Amount = cantidad
	Reward = reward
	
func changeContent(m: int) -> void:
	if(m == 0):
		label.text = ""
		label.add_theme_color_override("font_color", Color.WHITE)
	else:
		match Type:
			"Attack":
				label.add_theme_color_override("font_color", Color.RED)
			"Speed":
				label.add_theme_color_override("font_color", Color.ROYAL_BLUE)
			"Critical":
				label.add_theme_color_override("font_color", Color8(255,69,0))
			"HealthA":
				label.add_theme_color_override("font_color", Color.GREEN)
			"HealthS":
				label.add_theme_color_override("font_color", Color.RED)
			"HealthC":
				label.add_theme_color_override("font_color", Color.GREEN)
			"Used":
				label.add_theme_color_override("font_color", Color.GRAY)
			"Steps":
				label.add_theme_color_override("font_color", Color.YELLOW)
			"Blank":
				label.add_theme_color_override("font_color", Color.BLACK)
			"Boss":
				label.add_theme_color_override("font_color", Color.PURPLE)
			_:
				label.add_theme_color_override("font_color", Color.GRAY)
		label.text = "%d" %Amount

func _on_button_pressed() -> void:
	Global.pressed = true;
	Global.posPressed = Vector2(ValueX, ValueY)
	Global.enemyValue = Amount
	Global.enemyType = Type
	Global.enemyReward = Reward
	#audio_movement.play(0.65)
