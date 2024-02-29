extends StaticBody3D
@onready var apple = preload("res://apple.tscn")
@onready var apple_spawn_point = $AppleSpawnPoint
# Called when the node enters the scene tree for the first time.
var spawn_index = 0
var rng = RandomNumberGenerator.new()

func _ready():
	var number = floor( rng.randf_range(2,0))
	#print(number)
	if number == 0:
		$Timer.paused = true
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_timer_timeout():
	if apple_spawn_point.get_child(spawn_index).get_child_count() == 0:
		#var root = get_tree().get_root().get_node("World")
		var object_instance = apple.instantiate()
		#object_instance.position = appleSpawnPoint.get_child(apple_growing).global_position
		apple_spawn_point.get_child(spawn_index).add_child(object_instance)
		spawn_index += 1
	if spawn_index > 2:
		spawn_index = 0
	pass # Replace with function body.
