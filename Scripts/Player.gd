extends KinematicBody2D

var velocity = Vector2.ZERO

export(int) var JUMP_FORCE = -130
export(int) var JUMP_RELEASE_FORCE = -70
export(int) var MAX_SPEED = 50
export(int) var ACCELERATION = 10
export(int) var FRICTION = 10
export(int) var GRAVITY = 4
export(int) var ADDITIONAL_FALL_GRAVITY = 4

func _ready():
	pass

func _physics_process(delta):
	
	apply_gravity()
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if input.x == 0:
		apply_friction()
		$AnimatedSprite.animation = "Idle"
	else:
		apply_acceleration(input.x)
		$AnimatedSprite.animation = "Run"
		if input.x > 0:
			$AnimatedSprite.flip_h = false
		else:
			$AnimatedSprite.flip_h = true
	
	
	if is_on_floor() or is_on_wall():
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_FORCE
	else:
		$AnimatedSprite.animation = "Jump"
		if Input.is_action_just_released("jump") and velocity.y < -80:
			velocity.y = JUMP_RELEASE_FORCE
		
		if velocity.y > 0:
			velocity.y += ADDITIONAL_FALL_GRAVITY;
	
	var was_in_air = not is_on_floor()
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	var just_landed = is_on_floor() and was_in_air
	if just_landed:
		$AnimatedSprite.animation = "Run"
		$AnimatedSprite.frame = 1

func apply_gravity():
	velocity.y += GRAVITY

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, FRICTION)

func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, MAX_SPEED * amount, ACCELERATION)


func _on_Flashing_timeout():
	$Siren.play()
	$Camera2D/FOV.animation = "Flash"
	$Wait.start()


func _on_Wait_timeout():
	$Camera2D/FOV.animation = "Default"
	$Flashing.start()
