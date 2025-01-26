extends Camera2D;

@export var player: Player;
@export var quantidade_para_vencer := 5;
@export var rotationSpeed := 0.1;
var coletados := 0;
var folegoLabel: Label;
var mortoLabel: Label;
var vitoriaLabel: Label;
var itensLabel: Label;

var isGameOver := false;

signal onVictory

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	folegoLabel = $UI/folego_label;
	mortoLabel = $UI/Morto;
	vitoriaLabel = $UI/Vitoria;
	itensLabel = $UI/itens_coletados;
	player.onDeath.connect(game_over);
	player.onCollectObjective.connect(walk_to_victory);

func game_over() -> void:
	mortoLabel.show();
	isGameOver = true;

func walk_to_victory() -> void:
	coletados += 1;
	itensLabel.text = str(coletados) + '/' + str(quantidade_para_vencer);
	if coletados >= quantidade_para_vencer:
		victory();

func victory() -> void:
	vitoriaLabel.show();
	isGameOver = true;
	onVictory.emit();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = player.position;
	rotate(rotationSpeed * delta);
	folegoLabel.text = str(player.folego as int) + '/' + str(player.folegoMax);
	
	if isGameOver:
		if Input.is_action_just_pressed("ui_accept"):
			get_tree().reload_current_scene();
		elif Input.is_action_just_pressed("ui_cancel"):
			get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST);
			get_tree().quit();
