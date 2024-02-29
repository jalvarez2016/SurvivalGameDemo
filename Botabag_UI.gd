extends Control

var water_level : Need
# Called when the node enters the scene tree for the first time.
func _ready():
	water_level = get_node("WaterLevel")
	print(water_level.start_value)
	water_level.value = water_level.start_value


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	water_level.update_ui_bar()

func drink(amount):
	water_level.subtract(amount)

func fill(amount):
	water_level.add(amount)
