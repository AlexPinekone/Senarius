extends Node

var pressed : bool = false;
var posPressed = Vector2(-1,-1);

var types = [
	"Attack",
	"Speed",
	"Critical",
	"HealthA",
	"HealthS",
	"HealthC"
	]
	
var weights = [
	0.40,  # Attack
	0.28,   # Speed
	0.2,   # Critical
	0.04,   # Health Attack
	0.04,   # Health Speed
	0.04    # Health Critical
]
