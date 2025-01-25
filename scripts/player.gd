extends CharacterBody2D
class_name Player

@export var moveSpeed := 150
@export var rotationSpeed := 0.1
@export var folegoMax := 30.0
var folego: float;
var preso := 0.0;

var morto := false
signal onDeath
signal onCollectObjective

func _ready() -> void:
	folego = folegoMax;
	pass

func _process(delta: float) -> void:
	rotation += delta * rotationSpeed
	
	if morto:
		return
	
	if preso <= 0:
		var diry = (1 if Input.is_action_pressed("ui_down") else 0) - (1 if Input.is_action_pressed("ui_up") else 0)
		var dirx = (1 if Input.is_action_pressed("ui_right") else 0) - (1 if Input.is_action_pressed("ui_left") else 0)
		var dir = to_global(Vector2(dirx, diry)) - position
		if dir == Vector2.ZERO && Input.is_action_pressed("press"):
			dir = get_global_mouse_position() - position;
		move_and_collide(dir.normalized() * moveSpeed * delta)
	else:
		preso -= delta;
		if Input.is_action_just_pressed("ui_down") || Input.is_action_just_pressed("ui_up") || Input.is_action_just_pressed("ui_left") || Input.is_action_just_pressed("ui_right") || Input.is_action_just_pressed("press"):
			preso -= 0.25;
		if preso <= 0:
			liberar();
	
	folego -= delta
	if folego <= 0:
		die()

func alter_folego(amount: float) -> void:
	folego += amount
	if folego >= folegoMax:
		folego = folegoMax
	elif folego<=0:
		die()

func prender() -> void:
	preso = 5.0;

func liberar() -> void:
	preso = 0.0;
	get_child(2).queue_free();

func die() -> void:
	morto = true
	onDeath.emit()
