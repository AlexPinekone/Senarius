extends Node2D

@onready var player: Node2D = $"../Player"
@onready var dice: Node2D = $"../UI/Dice"
@onready var dice_sound: AudioStreamPlayer2D = $"../DiceSound"
@onready var charge_sound: AudioStreamPlayer2D = $"../ChargeSound"
@onready var points: RichTextLabel = $"../UI/Points"

#Animaciones
@onready var anim_r: AnimationPlayer = $"../UI/Result/animR"
@onready var anim_p: AnimationPlayer = $"../UI/Points/animP"
@onready var anim_h: AnimationPlayer = $"../UI/Health/animH"
@onready var anim_a: AnimationPlayer = $"../UI/Attack/animA"
@onready var anim_s: AnimationPlayer = $"../UI/Speed/animS"
@onready var anim_c: AnimationPlayer = $"../UI/Critical/animC"


const MATX = 7
const MATY = 6
var tileMap = []

#Al inicio
func _ready() -> void:
	print("Juego iniciado")
	randomize()
	start_matrix()
	reseteaTablero()
	startPlayer()
	
func startPlayer() -> void:
	player.position = tileMap[0][0]["nodo"].position
	activeHexagons(0,0)
	
func changeColor(x: int, y: int, color: int) -> void:
	var sprite = tileMap[x][y]["nodo"].get_node("Button/SubViewportContainer/SubViewport/AnimatedSprite2D")
	if (color == 1):
		sprite.modulate = Color(0.7,0.7,0.7,1)
	if (color == 2):
		sprite.modulate = Color(1,1,1,1)

func changeText(x: int, y: int, m: int) -> void:
	var nodo = tileMap[x][y]["nodo"]
	if nodo and nodo.has_method("changeContent"):
		nodo.changeContent(m)
		
func enableHexagon(x: int, y:int) -> void:
	var nodo = tileMap[x][y]["nodo"].get_node("Button")
	nodo.disabled = false

func disableHexagon(x: int, y:int) -> void:
	var nodo = tileMap[x][y]["nodo"].get_node("Button")
	nodo.disabled = true
	
func activeHexagons(x: int, y: int) -> void:
	#Arriba
	if(tileMap[x][y]["top"] != null):
		#var nombre_nodo = "../HexagonalTiles/T" + str(tileMap[x][y]["top"].x) + str(tileMap[x][y]["top"].y)
		#var nodoT = get_node_or_null(nombre_nodo)
		changeColor(tileMap[x][y]["top"].x, tileMap[x][y]["top"].y,1)
		enableHexagon(tileMap[x][y]["top"].x, tileMap[x][y]["top"].y)
		changeText(tileMap[x][y]["top"].x, tileMap[x][y]["top"].y,1)
	#Abajo
	if(tileMap[x][y]["bottom"] != null):
		#var nombre_nodo = "../HexagonalTiles/T" + str(tileMap[x][y]["bottom"].x) + str(tileMap[x][y]["bottom"].y)
		#var nodoB = get_node_or_null(nombre_nodo)
		changeColor(tileMap[x][y]["bottom"].x, tileMap[x][y]["bottom"].y,1)
		enableHexagon(tileMap[x][y]["bottom"].x, tileMap[x][y]["bottom"].y)
		changeText(tileMap[x][y]["bottom"].x, tileMap[x][y]["bottom"].y,1)
	#ArribaDerecha
	if(tileMap[x][y]["topRight"] != null):
		#var nombre_nodo = "../HexagonalTiles/T" + str(tileMap[x][y]["topRight"].x) + str(tileMap[x][y]["topRight"].y)
		#var nodoTR = get_node_or_null(nombre_nodo)
		changeColor(tileMap[x][y]["topRight"].x, tileMap[x][y]["topRight"].y,1)
		enableHexagon(tileMap[x][y]["topRight"].x, tileMap[x][y]["topRight"].y)
		changeText(tileMap[x][y]["topRight"].x, tileMap[x][y]["topRight"].y,1)
	#ArribaIzquierda
	if(tileMap[x][y]["topLeft"] != null):
		#var nombre_nodo = "../HexagonalTiles/T" + str(tileMap[x][y]["topLeft"].x) + str(tileMap[x][y]["topLeft"].y)
		#var nodoTL = get_node_or_null(nombre_nodo)
		changeColor(tileMap[x][y]["topLeft"].x, tileMap[x][y]["topLeft"].y,1)
		enableHexagon(tileMap[x][y]["topLeft"].x, tileMap[x][y]["topLeft"].y)
		changeText(tileMap[x][y]["topLeft"].x, tileMap[x][y]["topLeft"].y,1)
	#AbajoDerecha
	if(tileMap[x][y]["bottomRight"] != null):
		#var nombre_nodo = "../HexagonalTiles/T" + str(tileMap[x][y]["bottomRight"].x) + str(tileMap[x][y]["bottomRight"].y)
		#var nodoBR = get_node_or_null(nombre_nodo)
		changeColor(tileMap[x][y]["bottomRight"].x, tileMap[x][y]["bottomRight"].y,1)
		enableHexagon(tileMap[x][y]["bottomRight"].x, tileMap[x][y]["bottomRight"].y)
		changeText(tileMap[x][y]["bottomRight"].x, tileMap[x][y]["bottomRight"].y,1)
	#AbajoIzquierda
	if(tileMap[x][y]["bottomLeft"] != null):
		#var nombre_nodo = "../HexagonalTiles/T" + str(tileMap[x][y]["bottomLeft"].x) + str(tileMap[x][y]["bottomLeft"].y)
		#var nodoBL = get_node_or_null(nombre_nodo)
		changeColor(tileMap[x][y]["bottomLeft"].x, tileMap[x][y]["bottomLeft"].y,1)
		enableHexagon(tileMap[x][y]["bottomLeft"].x, tileMap[x][y]["bottomLeft"].y)
		changeText(tileMap[x][y]["bottomLeft"].x, tileMap[x][y]["bottomLeft"].y,1)

func start_matrix() -> void:
	var rowSize: int
	for y in range(MATX):
		var row = []
		if (y % 2 == 0):
			rowSize = MATY - 1
		else:
			rowSize = MATY
		for x in range(rowSize):
			var cell
			if (y % 2 == 0 && x <= 4):
				cell = generate_array(x,y,0)
			elif (y % 2 == 1):
				cell = generate_array(x,y,-1)
			row.append(cell)
		tileMap.append(row)
	#Imprimelo todo
	#for a in range(tileMap.size()):
	#	for b in range(tileMap[a].size()):
	#		var cell = tileMap[a][b]
			#print("Celda [", a, "][", b, "]: topRight =", cell["topLeft"])
		
func reseteaTablero() -> void:
		for a in range(tileMap.size()):
			for b in range(tileMap[a].size()):
				changeColor(a,b,2)
				disableHexagon(a,b)
				changeText(a,b,0)
			
func get_weighted_random() -> String:
	var rand = randf()
	var total = 0.0
	for i in Global.types.size():
		total += Global.weights[i]
		if rand < total:
			return Global.types[i]
	return Global.types[-1]  # fallback (por si hay redondeo)
	
func get_challenge(x:int, y:int) -> float:
	#para el boss
	#if(x != 6 && x !=4):
	#nivel * ((x+1)*0.2) * ((y+1)*0.2) * aleatorio
	return 1
	
func get_reward(evento: String) -> float:
	return 0.2
	
func generate_array(x: int, y: int, v: int) -> Dictionary:
	var nombre_nodo = "../HexagonalTiles/T" + str(y) + str(x)
	var nodo = get_node_or_null(nombre_nodo)
	#Para el Boss
	var evento
	if(y == 6 && x ==4):
		evento = "Boss"
	else:
		evento = get_weighted_random()
	var cantidad = get_challenge(x,y)
	var reward = get_reward(evento)
	#Inicia la Tile
	if nodo and nodo.has_method("setValues"):
		nodo.setValues(y,x,evento,cantidad,reward)
	#Inicia el diccionario
	var cell = {
			"nodo": nodo,
			"top": Vector2(y,x-1),
			"bottom": Vector2(y,x+1),
			"topRight": Vector2(y+1,x+v),
			"bottomRight": Vector2(y+1,x+1+v),
			"topLeft": Vector2(y-1,x+v),
			"bottomLeft": Vector2(y-1,x+1+v),
			"type": evento,
			"amount": cantidad
		}
		
	if (y == 0):
		cell["topLeft"] =  null
		cell["bottomLeft"] =  null
	if (y == 6):
		cell["topRight"] =  null
		cell["bottomRight"] =  null
	if (v == 0 && x == 0):
		cell["top"] =  null
	if (v == -1 && x == 0):
		cell["top"] =  null
		cell["topRight"] =  null
		cell["topLeft"] =  null
	if (v == 0 && x == 4):
		cell["bottom"] =  null
	if (v == -1 && x == 5):
		cell["bottom"] =  null
		cell["bottomRight"] =  null
		cell["bottomLeft"] =  null
	return cell

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Global.pressed && Global.combatDone):
		Global.pressed = false
		Global.combatDone = false
		#Espera a que se hagan los cálculos
		fight()
		Global.combatDone = true
		
func fight() -> void:
	var num = randi_range(1,6)
	points.setNumCero()
	dice.roll()
	dice_sound.play(0.5)
	await get_tree().create_timer(0.5).timeout
	dice_sound.stop()
	dice.rollstop()
	match num:
		1:
			dice.become1()
		2: 
			dice.become2()
		3:
			dice.become3()
		4:
			dice.become4()
		5:
			dice.become5()
		6:
			dice.become6()
	
	anim_r.play("shake_and_scale")
	points.setDice(num)
	points.setNum(num)
	charge_sound.play(0.18)
	await get_tree().create_timer(0.5).timeout	
	anim_a.play("shake_and_scale")
	points.setNum(player.getAttack())
	charge_sound.play(0.18)
	await get_tree().create_timer(0.5).timeout	
	anim_s.play("shake_and_scale")
	points.multNum(player.getSpeed())
	charge_sound.play(0.18)
	await get_tree().create_timer(0.5).timeout	
	anim_p.play("shake_and_scale")
	charge_sound.play(0.18)
	await get_tree().create_timer(0.5).timeout	
	await get_tree().create_timer(0.3).timeout	
	var result = (num + player.getAttack()) * player.getSpeed()
	
	if(result >= Global.enemyValue):
		match tileMap[Global.posPressed.x][Global.posPressed.y]["type"]:
			"Attack":
				player.setAttack(Global.enemyReward)
			"Speed":
				player.setSpeed(Global.enemyReward)
			"Critical":
				player.setCritical(Global.enemyReward)
			"HealthA":
				player.setHealth(Global.enemyReward)
			"HealthS":
				player.setHealth(Global.enemyReward)
			"HealthC":
				player.setHealth(Global.enemyReward)
	else:
		player.setHealth(-1)
	#Movimiento
	player.position = tileMap[Global.posPressed.x][Global.posPressed.y]["nodo"].position
	reseteaTablero()
	activeHexagons(Global.posPressed.x, Global.posPressed.y)
