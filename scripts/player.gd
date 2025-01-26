extends CharacterBody2D
class_name Player

@export var camera: Camera2D;

@export var moveSpeed := 150
@export var folegoMax := 30.0
var folego: float;
var preso := 0.0;

var morto := false
signal onDeath
signal onCollectObjective

var spriteAnim: AnimatedSprite2D;

func _ready() -> void:
	folego = folegoMax;
	spriteAnim = $AnimatedSprite2D;

func _process(delta: float) -> void:
	
	if morto:
		return
	
	if preso <= 0:
		var diry = (1 if Input.is_action_pressed("ui_down") else 0) - (1 if Input.is_action_pressed("ui_up") else 0)
		var dirx = (1 if Input.is_action_pressed("ui_right") else 0) - (1 if Input.is_action_pressed("ui_left") else 0)
		var dir = camera.to_global(Vector2(dirx, diry)) - position
		if dir == Vector2.ZERO && Input.is_action_pressed("press"):
			dir = camera.get_global_mouse_position() - position;
		move_and_collide(dir.normalized() * moveSpeed * delta)
		if dir != Vector2.ZERO:
			if spriteAnim.animation == "idle":
				spriteAnim.play("nadando");
			spriteAnim.look_at(to_global(dir));
			spriteAnim.rotation_degrees -= 90;
		else:
			if spriteAnim.animation == "nadando":
				spriteAnim.play("idle");
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
	spriteAnim.stop();
	preso = 5.0;

func liberar() -> void:
	spriteAnim.play();
	preso = 0.0;
	get_child(2).queue_free();

func die() -> void:
	morto = true
	onDeath.emit()
