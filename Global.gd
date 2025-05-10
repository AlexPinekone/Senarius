extends Node

var pressed : bool = false;
var posPressed = Vector2(-1,-1);
var enemyValue = 0
var enemyReward = 0
var enemyType = ""
var posJugador = Vector2()
var visited_tiles: Array = []
#Matematicas
var nivel = 1
var reto = 1

#Cambio de nivel
var gHealth = 6
var gAttack = 1
var gSpeed = 1
var gCritical = 0.05
var gPoint = 0
var gSteps = 9
var gTempSteps = 0

var combatDone : bool = true;

var types = [
	"Attack",
	"Speed",
	"Critical",
	"HealthA",
	"HealthS",
	"HealthC",
	"Steps",
	"Blank"
	]
	
var weights = [
	0.23,  # Attack
	0.16,   # Speed
	0.16,   # Critical
	0.04,   # Health Attack
	0.04,   # Health Speed
	0.02,    # Health Critical
	0.25, 	#Step
	0.10 	#Blank
]
