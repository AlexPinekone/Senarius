extends Node2D
@onready var points: RichTextLabel = $"../UI/Points"
@onready var health: RichTextLabel = $"../UI/Health"
@onready var attack: RichTextLabel = $"../UI/Attack"
@onready var speed: RichTextLabel = $"../UI/Speed"
@onready var critical: RichTextLabel = $"../UI/Critical"

var Health = 0
var Attack = 0
var Speed = 0
var Critical = 0
var Point = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var vT = "%.3f" % Health
	var hS : Array = vT.split("")  # Esto da un array de letras
	health.bbcode_text = "[wave amp=20.0 freq=8.0 connected=1][color=#ffffff88]" + hS[0] + hS[1] + hS[2]+ " " + hS[3]+"[/color][/wave]"
	vT = "%.3f" % Speed
	hS = vT.split("")  # Esto da un array de letras
	speed.bbcode_text = "[wave amp=20.0 freq=8.0 connected=1][color=#87CEEB88]" + hS[0] + hS[1] + hS[2]+ " " + hS[3]+"[/color][/wave]"
	vT = "%.3f" % Critical
	hS = vT.split("")  # Esto da un array de letras
	critical.bbcode_text = "[wave amp=20.0 freq=8.0 connected=1][color=#ffa50088]" + hS[0] + " " + hS[1] + hS[2]+ " " + hS[3]+"[/color][/wave]"
	vT = "%.3f" % Attack
	hS = vT.split("")  # Esto da un array de letras
	attack.bbcode_text = "[wave amp=20.0 freq=8.0 connected=1][color=#ff000088]" + hS[0] + hS[1] + hS[2]+ " " + hS[3]+"[/color][/wave]"
	
func getHealth() -> float:
	return Health

func getAttack() -> float:
	return Attack
	
func getSpeed() -> float:
	return Speed

func getCritical() -> float:
	return Critical
	
func setHealth(val : float) -> void:
	Health += val
	
func setAttack(val : float) -> void:
	Attack += val
	
func setSpeed(val : float) -> void:
	Speed += val
	
func setCritical(val : float) -> void:
	Critical += val
	
	
