extends Node2D

@export var matterCount : int = 0
@export var bodyNode : Node2D

var isInvisible : bool = false

signal matter_changed(amount: int)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_pressed(Key.KEY_F) and isInvisible:
		for i in bodyNode.get_children():
			if i is Sprite2D:
				i.modulate.a = 1;
		isInvisible = false
	
	if Input.is_key_pressed(Key.KEY_SPACE) and matterCount >= 10:
		isInvisible = true;
		for i in bodyNode.get_children():
			if i is Sprite2D:
				i.modulate.a = .5;
		matterCount -= 10
		matter_changed.emit(matterCount)


func _on_area_2d_area_entered(area: Area2D) -> void:
	const MATTER_GROUP_NAME = "matter"
	if area.is_in_group(MATTER_GROUP_NAME):
			area.queue_free()
			matterCount += 1
			matter_changed.emit(matterCount)
