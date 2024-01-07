extends Node2D

@export var spawnDelayMax : float = 1
@export var spawnDelayMin : float = .2
@export var shouldCount : bool = true
@export var followNode : Node

var currentSpawnDelay : float
var rng : RandomNumberGenerator

const matter = preload("res://Matter/Matter.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng = RandomNumberGenerator.new()
	currentSpawnDelay = rng.randf_range(spawnDelayMax,spawnDelayMin)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if shouldCount && currentSpawnDelay <= 0:
		SpawnMatter()
		currentSpawnDelay = rng.randf_range(spawnDelayMax,spawnDelayMin)
	
	currentSpawnDelay -= delta
	pass
	

func SpawnMatter():
	var screen_size = get_viewport_rect().size
	
	var screen_x = screen_size.x * .75
	var screen_y = screen_size.y * .75
	
	var random_x :float = randf_range(-screen_x,screen_x)
	var random_y :float= randf_range(-screen_y,screen_y)
	
	var matter : Node = matter.instantiate()
	matter.position.x = random_x + followNode.position.x
	matter.position.y = random_y + followNode.position.y
	add_child(matter)

func _get_viewport_center() -> Vector2:
	var transform : Transform2D = get_viewport_transform()
	var scale : Vector2 = transform.get_scale()
	return -transform.origin / scale + get_viewport_rect().size / scale / 2
