extends KinematicBody2D

export var max_move_speed = 250
export var min_move_speed = 50
export var stop_distance = 250
var vel: Vector2
var distance
var hitpoints = 3

func _ready() -> void:
	Globals.register_ship(self)
	$Effect.visible = false

func _process(_delta: float) -> void:
	_look_at_mouse()
	_move_to_mouse()
	
func _look_at_mouse():
	look_at(get_global_mouse_position())
	rotation_degrees += 90
	
func _move_to_mouse():
	distance = abs(floor(get_local_mouse_position().y))
	if position.distance_to(Vector2(abs(get_local_mouse_position().x),abs(get_local_mouse_position().y))) > stop_distance:
		var direction = get_global_mouse_position() - position
		var normalized_direction = direction.normalized()
		var direction_distance = direction.length()
		vel = move_and_slide(normalized_direction * max(min_move_speed, min(max_move_speed, direction_distance)))

# Collision #
func receive_damage():
	print("Got hit")
	hitpoints -= 1
	if hitpoints == 0:
		$Effect.visible = true
		$AnimationPlayer.play("Explosion")
		Globals.death()
		set_process(false)

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	$Effect.visible = false
