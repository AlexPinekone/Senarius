extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Verifica si ya existe otro nodo con el mismo nombre
	for child in get_tree().get_root().get_children():
		if child != self and child.name == name and child is AudioStreamPlayer2D:
			queue_free()  # Elimina esta nueva instancia
			return
	# Persistir esta instancia entre escenas
	#get_tree().get_root().add_child(self)
	#set_owner(null)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
