extends Node2D
@onready var animation: AnimatedSprite2D = $Animation


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func become1() -> void:
	animation.play("uno")
	
func become2() -> void:
	animation.play("dos")

func become3() -> void:
	animation.play("tres")
	
func become4() -> void:
	animation.play("cuatro")
	
func become5() -> void:
	animation.play("cinco")
	
func become6() -> void:
	animation.play("seis")
	
func roll() -> void:
	animation.play("roll")
