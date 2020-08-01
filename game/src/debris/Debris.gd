extends KinematicBody2D

var rotation_speed = float(rand_range(-2,2))
var debris_scale = float(rand_range(0.1,0.5))
var propulsion_speed = int(rand_range(10,150))
var propulsion

func _ready() -> void: 
	scale = Vector2(debris_scale, debris_scale)
	position = _randomize_position(Globals.spaceship.position)
	if Globals.difficulty > 0: propulsion = _calculate_trajectory(Globals.spaceship.position)
	if Globals.difficulty > 1: propulsion_speed *= 2

func _physics_process(delta: float) -> void:
	rotate(rotation_speed*delta)
	if Globals.difficulty > 0: var _velocity = move_and_slide(propulsion, Vector2.UP)
	if _out_of_focus(): _destroy()

func _calculate_trajectory(ship_pos):
	var rand_x = int(rand_range(ship_pos.x - 400, ship_pos.x + 400))
	var rand_y = int(rand_range(ship_pos.y - 400, ship_pos.y + 400))
	var trajectory = Vector2(rand_x, rand_y) - position
	return trajectory.normalized() * Vector2(propulsion_speed,propulsion_speed)

func _randomize_position(pos) -> Vector2:
	randomize()
	var rand_x = int(rand_range(-1000, 1000))
	var rand_y
	if rand_x <= -600 || rand_x >= 600: 
		rand_y = int(rand_range(-1000, 1000))
	else:
		rand_y = int(rand_range(600, 1000))
		rand_y = [rand_y, rand_y * -1]
		rand_y = rand_y[randi() % rand_y.size()]
	return Vector2(rand_x + pos.x,rand_y + pos.y)
	
func _destroy() -> void:
	Globals.debris_destroyed()
	queue_free()

func _collision(body: Node) -> void:
	match body.get_filename():
		"res://src/spaceship/Spaceship.tscn":
			collision_mask = 0
			$AnimationPlayer.play("Explosion")
			_play_sound(false)
			Globals.spaceship.receive_damage(_damage_calculation())
		"res://src/debris/Debris.tscn":
			if body != self: 
				$AnimationPlayer.play("Explosion")
				_play_sound(true)

func _deathAnimation_end(_anim_name: String) -> void: _destroy()

func _damage_calculation() -> int: 
	var damage = int((debris_scale * 100) / 2)
	if Globals.difficulty > 1: damage *= 1.5
	return damage

func _out_of_focus() -> bool:
	var distance = get_global_position().distance_to(Globals.spaceship.get_global_position())
	if distance > 1400: return true
	else: return false

func _play_sound(self_collide):
	var soundstream = load(Music.sounds_total[0].path)
	$Soundeffects.set_stream(soundstream)
	if self_collide: $Soundeffects.volume_db = linear2db(0.1)
	else: $Soundeffects.volume_db = linear2db(Globals.game_volume)
	$Soundeffects.play()
