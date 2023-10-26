extends CharacterBody2D

@export var acceleration : float = 1
@export var rotationSpeed : float = 0.75
@export var rotationLerp : float = 0.05
@export var maxRotationSpeed : float = 1
@export var thrustlesRotationSpeed : float = 0.01
@export var thrustRotationImpact : float = 0.1
@export var maxReverseSpeed : float = 0.3
@export var friction : float = 1
@export var maxspeed : float = 70

var currentRotationSpeed : float = 0


func _physics_process(_delta: float) -> void:
	var thrust : float = Input.get_axis("ThrustForward","ThrustReverse")
	var rot : float = Input.get_axis("RotateCounterClockwise","RotateClockwise")
	if thrust > 0:
		thrust =- min (thrust, -maxReverseSpeed)
	
	var leftBasis : Vector2 = transform.basis_xform(Vector2.LEFT)
	
	velocity = (thrust * acceleration * leftBasis) + velocity * friction
	velocity.x = min (velocity.x, maxspeed)
	velocity.y = min (velocity.y, maxspeed)
	var rotateAmount : float = rot * rotationSpeed * abs(thrust * thrustRotationImpact) + rot * thrustlesRotationSpeed
	currentRotationSpeed = min(lerp(currentRotationSpeed,rotateAmount,rotationLerp ) ,maxRotationSpeed)
	rotation = currentRotationSpeed + rotation
	move_and_slide()

