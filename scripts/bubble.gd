extends Area2D
class_name Bubble

enum tipoDeBolha {boa = 0, ruim = 1, armadilha = 2}

@onready var imagens := [load("res://art/placeholder/bubble.png"), load("res://art/placeholder/bubble-toxic.png"), load("res://art/placeholder/bubble_trap.png")];
@export var tipo: tipoDeBolha = tipoDeBolha.boa;

@export var constantVelocity := Vector2.ZERO;
@export var popOnWalls := true;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(when_player_enters);
	$Bubble.texture = imagens[tipo];
	if !popOnWalls:
		$VisibleOnScreenNotifier2D.screen_exited.connect(queue_free);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += constantVelocity * delta;

func when_player_enters(body: Node2D) -> void:
	if body is not Player:
		if popOnWalls:
			queue_free();
		return;
	var alter: float;
	match tipo:
		tipoDeBolha.boa:
			alter = 6.0;
		tipoDeBolha.ruim:
			alter = -2.0;
		tipoDeBolha.armadilha:
			body.prender();
			var bubble := get_child(1);
			bubble.reparent(body);
			bubble.position = Vector2.ZERO;
			alter = 1.0;
	body.alter_folego(alter);
	queue_free();
