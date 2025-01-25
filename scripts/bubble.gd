extends Area2D

enum tipoDeBolha {boa = 0, ruim = 1, armadilha = 2}

@onready var imagens := [load("res://art/placeholder/bubble.png"), load("res://art/placeholder/bubble-toxic.png"), load("res://art/placeholder/bubble_trap.png")];
@export var tipo: tipoDeBolha = tipoDeBolha.boa;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(when_player_enters);
	$Bubble.texture = imagens[tipo];


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func when_player_enters(body: Node2D) -> void:
	if body is not Player:
		return;
	var alter: float;
	match tipo:
		tipoDeBolha.boa:
			alter = 2.0;
		tipoDeBolha.ruim:
			alter = -2.0;
		tipoDeBolha.armadilha:
			return;
	body.alter_folego(alter);
	queue_free();
