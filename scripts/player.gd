extends CharacterBody2D;
class_name Player;

@export var moveSpeed := 50;
@export var rotationSpeed := 0.1;
@export var folegoMax := 30.0;
var folego := folegoMax;

var morto := false;
signal onDeath;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation += delta * rotationSpeed;
	
	if morto:
		return;
	
	var diry = (1 if Input.is_action_pressed("ui_down") || Input.is_key_pressed(KEY_S) else 0) - (1 if Input.is_action_pressed("ui_up") || Input.is_key_pressed(KEY_W) else 0);
	var dirx = (1 if Input.is_action_pressed("ui_right") || Input.is_key_pressed(KEY_D) else 0) - (1 if Input.is_action_pressed("ui_left") || Input.is_key_pressed(KEY_A) else 0);
	var dir = to_global(Vector2(dirx, diry)) - position;
	move_and_collide(dir * moveSpeed * delta);
	
	folego -= delta;
	if folego <= 0:
		die();

func alter_folego(amount: float) -> void:
	folego += amount;
	if folego >= folegoMax:
		folego = folegoMax;
	elif folego<=0:
		die()

func die() -> void:
	morto = true;
	onDeath.emit();
