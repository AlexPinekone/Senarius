extends Node2D

@onready var player: Node2D = $"../Player"
@onready var dice: Node2D = $"../UI/Dice"
@onready var dice_sound: AudioStreamPlayer2D = $"../DiceSound"
@onready var charge_sound: AudioStreamPlayer2D = $"../ChargeSound"
@onready var oof: AudioStreamPlayer2D = $"../Oof"
@onready var points: RichTextLabel = $"../UI/Points"
@onready var transition_anim_exit: AnimationPlayer = $"../TransitionExit/TransitionAnimExit"


#Animaciones
@onready var anim_r: AnimationPlayer = $"../UI/Result/animR"
@onready var anim_p: AnimationPlayer = $"../UI/Points/animP"
@onready var anim_h: AnimationPlayer = $"../UI/Health/animH"
@onready var anim_a: AnimationPlayer = $"../UI/Attack/animA"
@onready var anim_s: AnimationPlayer = $"../UI/Speed/animS"
@onready var anim_c: AnimationPlayer = $"../UI/Critical/animC"
@onready var anim_st: AnimationPlayer = $"../UI/Steps/animSt"

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
	if(Global.gTempSteps > Global.gSteps):
		player.setSteps(Global.gTempSteps)
	else:
		player.setSteps(Global.gSteps)
	activeHexagons(0,0)
	
func changeBlocked() ->void:
	var tile_node
	for a in range(tileMap.size()):
			for b in range(tileMap[a].size()):
				tile_node = tileMap[a][b]["nodo"]
				tile_node.is_blocked = false
				enableHexagon(a,b)

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
	
func controlTheHexagon(x: int,y: int,nam: String)-> void:
	if Global.visited_tiles.has(Vector2i(tileMap[x][y][nam].x, tileMap[x][y][nam].y)):
		changeColor(tileMap[x][y][nam].x,tileMap[x][y][nam].y,3)
	else:
		changeColor(tileMap[x][y][nam].x, tileMap[x][y][nam].y,1)
		enableHexagon(tileMap[x][y][nam].x, tileMap[x][y][nam].y)
		changeText(tileMap[x][y][nam].x, tileMap[x][y][nam].y,1)

func activeHexagons(x: int, y: int) -> void:
	#Arriba
	if(tileMap[x][y]["top"] != null):
		controlTheHexagon(x,y,"top")
	#Abajo
	if(tileMap[x][y]["bottom"] != null):
		controlTheHexagon(x,y,"bottom")
	#ArribaDerecha
	if(tileMap[x][y]["topRight"] != null):
		controlTheHexagon(x,y,"topRight")
	#ArribaIzquierda
	if(tileMap[x][y]["topLeft"] != null):
		controlTheHexagon(x,y,"topLeft")
	#AbajoDerecha
	if(tileMap[x][y]["bottomRight"] != null):
		controlTheHexagon(x,y,"bottomRight")
	#AbajoIzquierda
	if(tileMap[x][y]["bottomLeft"] != null):
		controlTheHexagon(x,y,"bottomLeft")

	

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
	
func get_challenge(x:int, y:int) -> int:
	var rand = randf() + 1
	var challenge
	#para el boss
	if(x != 6 && x !=4):
		challenge = round(Global.nivel * ((x+1)*0.2) * ((y+1)*0.2) * Global.reto * rand + 1)
	else:
		challenge = round(Global.nivel * ((x+1)*0.2) * ((y+1)*0.2) * Global.reto * rand * 2)
	return challenge
	
func get_reward(evento: String) -> float:
	match evento:
		"HealthA":
			return 1*Global.nivel
		"HealthS":
			return 1*Global.nivel
		"HealthC":
			return 1*Global.nivel
		"Attack":
			return 1*Global.nivel
		"Speed":
			return 0.2 * Global.nivel
		"Critical":
			return 0.05
		"Steps":
			return 2
		"Blank":
			return 0
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
		if (player.getSteps() > 0):
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
	anim_p.play("shake_and_scale")
	points.setDice(num)
	points.setNum(num)
	charge_sound.play(0.18)
	await get_tree().create_timer(0.5).timeout

	anim_a.play("shake_and_scale")
	anim_p.play("shake_and_scale")
	points.setNum(player.getAttack())
	charge_sound.play(0.18)
	await get_tree().create_timer(0.5).timeout

	anim_s.play("shake_and_scale")
	anim_p.play("shake_and_scale")
	points.multNum(player.getSpeed())
	charge_sound.play(0.18)
	await get_tree().create_timer(0.5).timeout

	var crit = get_random_critical()
	if crit:
		anim_c.play("shake_and_scale")
		anim_p.play("shake_and_scale")
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
			"Steps": player.setSteps(Global.enemyReward)
			"HealthA", "HealthS", "HealthC": player.setHealth(Global.enemyReward)
			_: pass
		if tileMap[pos.x][pos.y]["type"] == "Boss":
			Global.nivel += + 1
			Global.reto *= 1.6
			Global.gHealth = player.getHealth()
			Global.gAttack = player.getAttack()
			Global.gSpeed = player.getSpeed()
			Global.gCritical = player.getCritical()
			if (player.getSteps()> Global.gSteps):
				Global.gTempSteps = player.getSteps()
			Global.visited_tiles.clear()
			reseteaTablero()
			changeBlocked()
			Global.combatDone = true
			Global.posJugador = Vector2(0,0)
			transition_anim_exit.play("SceneExit")
			await get_tree().create_timer(3).timeout
			get_tree().change_scene_to_file("res://src/scenes/loadingScreen.tscn")
			return  # No continuar tras cambiar escena

		# Movimiento válido: Mover al jugador y marcar casilla como visitada
		var prev_tile = Global.posJugador
		player.position = tile_node.position
		anim_st.play("shake_and_scale")
		player.setSteps(-1)

		var prev_tile_vec = Vector2i(prev_tile.x, prev_tile.y)
		if not Global.visited_tiles.has(prev_tile_vec):
			Global.visited_tiles.append(prev_tile_vec)

		# Se marca como bloqueada para que no se pueda regresar
		tile_node.is_blocked = true

		reseteaTablero()
		activeHexagons(pos.x, pos.y)
		Global.posJugador = pos
	else:
		player.setHealth(-1)
		anim_h.play("shake_and_scale")
		oof.play()
		await get_tree().create_timer(0.5).timeout
		
	Global.combatDone = true
	
