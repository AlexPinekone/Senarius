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
	health.bbcode_text = "[wave amp=20.0 freq=8.0 connected=1][color=#ffffff88]" + str(Health) +"[/color][/wave]"
	speed.bbcode_text = "[wave amp=20.0 freq=8.0 connected=1][color=#87CEEB88]" + str(Speed) +"[/color][/wave]"
	critical.bbcode_text = "[wave amp=20.0 freq=8.0 connected=1][color=#ffa50088]" + str(Critical)+"[/color][/wave]"
	attack.bbcode_text = "[wave amp=20.0 freq=8.0 connected=1][color=#ff000088]" + str(Attack) +"[/color][/wave]"
	
func getHealth() -> int:
	return Health

func getAttack() -> int:
	return Attack
	
func getSpeed() -> float:
	return Speed

func getCritical() -> float:
	return Critical
	
func setHealth(val : int) -> void:
	Health += val
	
func setAttack(val : int) -> void:
	Attack += val
	
func setSpeed(val : float) -> void:
	Speed += val
	
func setCritical(val : float) -> void:
	Critical += val
	
	
