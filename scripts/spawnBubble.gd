extends Node2D

const bubblePrefab := preload("res://scenes/instances/bubble.tscn");
@onready var spawnTimer := $SpawnTimer;
@export var spawnTimeMin := 7.0;
@export var spawnTimeMax := 10.0;

@export var bubbleDirection := Vector2.UP * 250;
@export var bubbleType := Bubble.tipoDeBolha.boa;
@export var bubblePopsOnWalls := true;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnTimer.timeout.connect(spawn_bubble);
	restart_timer();
	randomize();

func restart_timer() -> void:
	spawnTimer.wait_time = randf_range(spawnTimeMin, spawnTimeMax);
	spawnTimer.start();

func spawn_bubble() -> void:
	var bubble: Bubble = bubblePrefab.instantiate();
	bubble.tipo = bubbleType;
	bubble.constantVelocity = to_global(bubbleDirection) - global_position;
	bubble.popOnWalls = bubblePopsOnWalls;
	get_parent().get_parent().add_child(bubble);
	bubble.global_position = global_position;
	restart_timer();
