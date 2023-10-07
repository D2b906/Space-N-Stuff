extends Node2D

signal StartThrust
signal EndThrust


func GetPlayerInput() -> Vector2:
	return Input.get_vector("Up","Down","Left","Right")
	
func _process(_delta):
	if Input.is_action_just_pressed("Up"):
		StartThrust.emit()
	elif Input.is_action_just_released("Up"):
		EndThrust.emit()
