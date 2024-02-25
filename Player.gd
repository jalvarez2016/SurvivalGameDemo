extends CharacterBody3D

@export var gravity := 50.0
@export var speed := 8.0
@export var jump_force := 20.0
@export var health := 10

@onready var spring_arm: SpringArm3D = $Head/SpringArm3D
@onready var mesh : MeshInstance3D = $MeshInstance3D

var angular_acceleration := 7
var isAlive := true
var is_drinking := false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if !isAlive:
		return
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_force
	
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var move_direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	move_direction = move_direction.rotated(Vector3.UP, spring_arm.rotation.y).normalized()
	
	if move_direction:
		velocity.x = move_direction.x * speed
		velocity.z = move_direction.z * speed
		mesh.rotation.y = lerp_angle(mesh.rotation.y, atan2(move_direction.x, move_direction.z), delta * angular_acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	move_and_slide()
	
	if is_drinking:
		drinking_water()
	
	if Input.is_action_just_pressed("drinking"):
		is_drinking = true
	if Input.is_action_just_released("drinking"):
		is_drinking = false

func drinking_water():
	$MeshInstance3D/Botabag.drink()
	$PlayerNeeds.drink(.02)

func _on_get_food_area_entered(area):
	if area.is_in_group("apple"):
		area.get_parent().queue_free()
		$PlayerNeeds.eat(100)
