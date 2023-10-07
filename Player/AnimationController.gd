extends Node2D

class AnimationPart:
	var animation_player: AnimationPlayer
	var animation_stage: Animations
	func _init(new_animation_player,new_animation_stage):
		self.animation_player = new_animation_player
		self.animation_stage = new_animation_stage

enum Animations {THRUST_S,THRUST_M,THRUST_E,BOOST_S,BOOST_M,BOOST_E,DAMAGED_S,DAMAGED_M,DAMAGED_E, IDLE}

var _animation_parts : Array


func _ready():
	var Children:Array[Node]
	Children = get_children() 
	for index in range(Children.size()):
		var player = Children[index].get_child(0)
		if player is AnimationPlayer:
			_animation_parts.append(AnimationPart.new(player,Animations.IDLE))
			
			for animation_name in player.get_animation_list(): 
				print("0")
				#player.get_animation(animation_name).loop_mode = 

func _on_player_input_start_thrust():
	
	for x in range(_animation_parts.size()):
		var part : AnimationPart
		part = _animation_parts[x]
		
		if not part.animation_player.has_animation("ThrustS"):
			continue
			
		part.animation_stage = Animations.THRUST_S
		part.animation_player.stop()
		part.animation_player.play("ThrustS")

func _on_player_input_end_thrust():
	for x in range(_animation_parts.size()):
		var part : AnimationPart
		part = _animation_parts[x]
		
		if not part.animation_stage == Animations.THRUST_S:
			continue
			
		part.animation_stage = Animations.THRUST_S
		part.animation_player.queue("Idle")
		
