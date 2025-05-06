extends Node2D

var Health = 6
var Attack = 1.0
var Speed = 1.0
var Critical = 0.01

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
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
	
	
