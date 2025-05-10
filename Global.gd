extends Node

var pressed : bool = false;
var posPressed = Vector2(-1,-1);
var enemyValue = 0
var enemyReward = 0
var enemyType = ""
var posJugador = Vector2()
var visited_tiles: Array = []
var totalPoints = 0
#Matematicas
var nivel = 1
var reto = 1

#Cambio de nivel
var gHealth = 6
var gAttack = 1
var gSpeed = 1
var gCritical = 0.05
var gPoint = 0
var gSteps = 8
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
	0.20, 	#Step
	0.15 	#Blank
]


func resetValues():
	nivel = 1
	reto = 1
	gHealth = 6
	gAttack = 1
	gSpeed = 1
	gCritical = 0.05
	gPoint = 0
	gSteps = 9
	gTempSteps = 0
	pressed = false;
	posPressed = Vector2(-1,-1);
	enemyValue = 0
	enemyReward = 0
	enemyType = ""
	posJugador = Vector2(0,0)
	visited_tiles = []
	totalPoints = 0
	combatDone = true;
