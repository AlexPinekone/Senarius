extends RichTextLabel
var Num
var DiceValue
@onready var points: RichTextLabel = $"."
@onready var result: RichTextLabel = $"../Result"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Num = 0
	DiceValue = 0

func setDice(val : int) -> void:
	DiceValue = val

func setNum(val : float) -> void:
	Num += val
	
func multNum(val : float) -> void:
	Num *= val
	
func setNumCero() -> void:
	Num = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#var vT = "%.3f" % Num
	#var hS : Array = vT.split("")  # Esto da un array de letras
	points.bbcode_text = "[wave amp=20.0 freq=8.0 connected=1][color=#ffffff88]" + str(Num) +"[/color][/wave]"
	result.bbcode_text = "[wave amp=20.0 freq=8.0 connected=1][color=#ffffff88]" + str(DiceValue) +"[/color][/wave]"
