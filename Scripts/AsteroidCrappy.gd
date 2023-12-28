extends RigidBody2D


@export var speed : float = 8
@export var direction : Vector2
@export var rotationSpeed : float = 0.01
var clockwise : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	var rotdir = rng.randf_range(0.0,360.0)
	rotation_degrees = rotdir  
	
	if rng.randi() % 2:
		rotationSpeed = -rotationSpeed
	
	var radians = deg_to_rad(rng.randf_range(0.0,360.0))
	var x = cos(radians)
	var y = sin(radians)
	
	direction = Vector2(x, y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Calculate the movement vector using the random direction and speed
	var movement = direction * speed * delta
	rotation = rotation + rotationSpeed
	# Move the object
	move_and_collide(movement)
