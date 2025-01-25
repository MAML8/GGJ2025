extends CharacterBody2D
class_name Player

@export var moveSpeed := 150
@export var rotationSpeed := 0.1
@export var folegoMax := 30.0
var folego := folegoMax

@onready var itens_label = get_parent().get_node("Camera2D/UI/itens_coletados")
var itensColetados = 0:
	set(value):
		itensColetados = value
		if itens_label:
			itens_label.text = str(itensColetados)

var morto := false
var vitoria := false
signal onDeath

func _ready() -> void:
	print("Label de itens encontrada: ", itens_label != null)
	pass

func _process(delta: float) -> void:
	rotation += delta * rotationSpeed
	
	if morto:
		return
		
	if itensColetados == 5:
		victory()
	
	var diry = (1 if Input.is_action_pressed("ui_down") || Input.is_key_pressed(KEY_S) else 0) - (1 if Input.is_action_pressed("ui_up") || Input.is_key_pressed(KEY_W) else 0)
	var dirx = (1 if Input.is_action_pressed("ui_right") || Input.is_key_pressed(KEY_D) else 0) - (1 if Input.is_action_pressed("ui_left") || Input.is_key_pressed(KEY_A) else 0)
	var dir = to_global(Vector2(dirx, diry)) - position
	move_and_collide(dir * moveSpeed * delta)
	
	folego -= delta
	if folego <= 0:
		die()

func alter_folego(amount: float) -> void:
	folego += amount
	if folego >= folegoMax:
		folego = folegoMax
	elif folego<=0:
		die()

func victory() -> void:
	vitoria = true
	#onVictory.emit()

func die() -> void:
	morto = true
	onDeath.emit()
