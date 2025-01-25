extends Area2D

enum tipoDeBolha {ruim, boa, muiboa}

@export var tipo: tipoDeBolha = tipoDeBolha.boa;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(when_player_enters);
	match tipo:
		tipoDeBolha.boa:
			modulate = Color.SKY_BLUE;
		tipoDeBolha.ruim:
			modulate = Color.GREEN;
		tipoDeBolha.muiboa:
			modulate = Color.BLUE;


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
		tipoDeBolha.muiboa:
			alter = 2.0;
			body.folegoMax += 2.0;
	body.alter_folego(alter);
	queue_free();
