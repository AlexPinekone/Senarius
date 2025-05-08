extends Node2D

@onready var player: Node2D = $"../Player"
@onready var dice: Node2D = $"../UI/Dice"
@onready var dice_sound: AudioStreamPlayer2D = $"../DiceSound"
@onready var charge_sound: AudioStreamPlayer2D = $"../ChargeSound"
@onready var oof: AudioStreamPlayer2D = $"../Oof"
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
	player.setHealth(Global.gHealth)
	player.setAttack(Global.gAttack)
	player.setSpeed(Global.gSpeed)
	player.setCritical(Global.gCritical)
	activeHexagons(0,0)
	
func changeColor(x: int, y: int, color: int) -> void:
	var sprite = tileMap[x][y]["nodo"].get_node("Button/SubViewportContainer/SubViewport/AnimatedSprite2D")
	if (color == 1):
		sprite.modulate = Color(0.7,0.7,0.7,1)
	if (color == 2):
		sprite.modulate = Color(1,1,1,1)
	if (color == 3):
		sprite.modulate = Color(0,0,1,1)

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
		if Global.visited_tiles.has(Vector2i(tileMap[x][y]["top"].x, tileMap[x][y]["top"].y)):
			changeColor(tileMap[x][y]["top"].x,tileMap[x][y]["top"].y,3)
		else:
			changeColor(tileMap[x][y]["top"].x, tileMap[x][y]["top"].y,1)
			enableHexagon(tileMap[x][y]["top"].x, tileMap[x][y]["top"].y)
			changeText(tileMap[x][y]["top"].x, tileMap[x][y]["top"].y,1)
	#Abajo
	if(tileMap[x][y]["bottom"] != null):
		#var nombre_nodo = "../HexagonalTiles/T" + str(tileMap[x][y]["bottom"].x) + str(tileMap[x][y]["bottom"].y)
		#var nodoB = get_node_or_null(nombre_nodo)
		if Global.visited_tiles.has(Vector2i(tileMap[x][y]["bottom"].x, tileMap[x][y]["bottom"].y)):
			changeColor(tileMap[x][y]["bottom"].x,tileMap[x][y]["bottom"].y,3)
		else:
			changeColor(tileMap[x][y]["bottom"].x, tileMap[x][y]["bottom"].y,1)
			enableHexagon(tileMap[x][y]["bottom"].x, tileMap[x][y]["bottom"].y)
			changeText(tileMap[x][y]["bottom"].x, tileMap[x][y]["bottom"].y,1)
	#ArribaDerecha
	if(tileMap[x][y]["topRight"] != null):
		#var nombre_nodo = "../HexagonalTiles/T" + str(tileMap[x][y]["topRight"].x) + str(tileMap[x][y]["topRight"].y)
		#var nodoTR = get_node_or_null(nombre_nodo)
		if Global.visited_tiles.has(Vector2i(tileMap[x][y]["topRight"].x, tileMap[x][y]["topRight"].y)):
			changeColor(tileMap[x][y]["topRight"].x,tileMap[x][y]["topRight"].y,3)
		else:
			changeColor(tileMap[x][y]["topRight"].x, tileMap[x][y]["topRight"].y,1)
			enableHexagon(tileMap[x][y]["topRight"].x, tileMap[x][y]["topRight"].y)
			changeText(tileMap[x][y]["topRight"].x, tileMap[x][y]["topRight"].y,1)
	#ArribaIzquierda
	if(tileMap[x][y]["topLeft"] != null):
		#var nombre_nodo = "../HexagonalTiles/T" + str(tileMap[x][y]["topLeft"].x) + str(tileMap[x][y]["topLeft"].y)
		#var nodoTL = get_node_or_null(nombre_nodo)
		if Global.visited_tiles.has(Vector2i(tileMap[x][y]["topLeft"].x, tileMap[x][y]["topLeft"].y)):
			changeColor(tileMap[x][y]["topLeft"].x,tileMap[x][y]["topLeft"].y,3)
		else:
			changeColor(tileMap[x][y]["topLeft"].x, tileMap[x][y]["topLeft"].y,1)
			enableHexagon(tileMap[x][y]["topLeft"].x, tileMap[x][y]["topLeft"].y)
			changeText(tileMap[x][y]["topLeft"].x, tileMap[x][y]["topLeft"].y,1)
	#AbajoDerecha
	if(tileMap[x][y]["bottomRight"] != null):
		#var nombre_nodo = "../HexagonalTiles/T" + str(tileMap[x][y]["bottomRight"].x) + str(tileMap[x][y]["bottomRight"].y)
		#var nodoBR = get_node_or_null(nombre_nodo)
		if Global.visited_tiles.has(Vector2i(tileMap[x][y]["bottomRight"].x, tileMap[x][y]["bottomRight"].y)):
			changeColor(tileMap[x][y]["bottomRight"].x,tileMap[x][y]["bottomRight"].y,3)
		else:
			changeColor(tileMap[x][y]["bottomRight"].x, tileMap[x][y]["bottomRight"].y,1)
			enableHexagon(tileMap[x][y]["bottomRight"].x, tileMap[x][y]["bottomRight"].y)
			changeText(tileMap[x][y]["bottomRight"].x, tileMap[x][y]["bottomRight"].y,1)
	#AbajoIzquierda
	if(tileMap[x][y]["bottomLeft"] != null):
		#var nombre_nodo = "../HexagonalTiles/T" + str(tileMap[x][y]["bottomLeft"].x) + str(tileMap[x][y]["bottomLeft"].y)
		#var nodoBL = get_node_or_null(nombre_nodo)
		if Global.visited_tiles.has(Vector2i(tileMap[x][y]["bottomLeft"].x, tileMap[x][y]["bottomLeft"].y)):
			changeColor(tileMap[x][y]["bottomLeft"].x,tileMap[x][y]["bottomLeft"].y,3)
		else:
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
				if Global.visited_tiles.has(Vector2i(a, b)):
						changeColor(a,b,3)
			
func get_weighted_random() -> String:
	var rand = randf()
	var total = 0.0
	for i in Global.types.size():
		total += Global.weights[i]
		if rand < total:
			return Global.types[i]
	return Global.types[-1]  # fallback (por si hay redondeo)
	
func get_challenge(x:int, y:int) -> float:
	var rand = randf() + 1
	var challenge
	#para el boss
	if(x != 6 && x !=4):
		challenge = Global.nivel * ((x+1)*0.2) * ((y+1)*0.2) * Global.reto * 2 * rand
	else:
		challenge = Global.nivel * ((x+1)*0.2) * ((y+1)*0.2) * Global.reto * rand
	return challenge
	
func get_reward(evento: String) -> float:
	return 0.2*Global.nivel
	
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
	if (evento == "Critical"):
		reward = reward/4
		
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
	
func get_random_critical() -> bool:
	var res = false
	var rand = randf()
	var prob_crit = player.getCritical()
	if rand <= prob_crit:
		res = true
	return res

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Global.pressed && Global.combatDone):
		Global.pressed = false
		Global.combatDone = false
		
		#Espera a que se hagan los cálculos
		fight()
		
func fight() -> void:
	var pos = Global.posPressed
	var tile_node = tileMap[pos.x][pos.y]["nodo"]

	# Verifica si la casilla a la que se quiere mover está bloqueada
	if tile_node.is_blocked:
		print("Casilla bloqueada. No se puede mover.")
		Global.combatDone = true
		return

	var num = randi_range(1, 6)
	points.setNumCero()
	dice.roll()
	dice_sound.play(0.5)
	await get_tree().create_timer(0.5).timeout
	dice_sound.stop()
	dice.rollstop()

	match num:
		1: dice.become1()
		2: dice.become2()
		3: dice.become3()
		4: dice.become4()
		5: dice.become5()
		6: dice.become6()

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

	var crit = get_random_critical()
	if crit:
		anim_c.play("shake_and_scale")
		points.multNum(3)
		charge_sound.play(0.18)
		await get_tree().create_timer(0.5).timeout

	await get_tree().create_timer(0.5).timeout

	var result = (num + player.getAttack()) * player.getSpeed()
	if crit:
		result *= 3

	if result >= Global.enemyValue:
		match tileMap[pos.x][pos.y]["type"]:
			"Attack": player.setAttack(Global.enemyReward)
			"Speed": player.setSpeed(Global.enemyReward)
			"Critical": player.setCritical(Global.enemyReward)
			"HealthA", "HealthS", "HealthC": player.setHealth(Global.enemyReward)
	else:
		player.setHealth(-1)
		anim_h.play("shake_and_scale")
		oof.play()
		await get_tree().create_timer(0.5).timeout

	if tileMap[pos.x][pos.y]["type"] == "Boss":
		Global.nivel = 2
		Global.reto *= 1.6
		Global.gHealth = player.getHealth()
		Global.gAttack = player.getAttack()
		Global.gSpeed = player.getSpeed()
		Global.gCritical = player.getCritical()
		get_tree().change_scene_to_file("res://src/scenes/baseMap.tscn")
		return  # No continuar tras cambiar escena

	# Movimiento válido: Mover al jugador y marcar casilla como visitada
	var prev_tile = Global.posJugador
	player.position = tile_node.position

	var prev_tile_vec = Vector2i(prev_tile.x, prev_tile.y)
	if not Global.visited_tiles.has(prev_tile_vec):
		Global.visited_tiles.append(prev_tile_vec)

	# Se marca como bloqueada para que no se pueda regresar
	tile_node.is_blocked = true

	reseteaTablero()
	activeHexagons(pos.x, pos.y)
	Global.combatDone = true
	Global.posJugador = pos
