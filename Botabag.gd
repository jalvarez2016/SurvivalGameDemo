extends Node3D
var water_level : Need

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func drink():
	$SubViewport/Control.drink(.02)
