extends Camera2D;

@export var player: Player;
var folegoLabel: Label;
var mortoLabel: Label;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	folegoLabel = $UI/folego_label;
	mortoLabel = $UI/Morto;
	player.onDeath.connect(game_over);

func game_over() -> void:
	mortoLabel.show();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	position = player.position;
	rotation = player.rotation;
	folegoLabel.text = str(player.folego as int) + '/' + str(player.folegoMax);
