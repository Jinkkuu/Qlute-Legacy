extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	text = "... FPS"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var FPSCounterBox = $"../.."
	if delta > 10:
		FPSCounterBox.self_modulate = Color(1,0,0)
	else:
		FPSCounterBox.self_modulate = Color(0,1,0)
	text = str(Engine.get_frames_per_second()) + " FPS"
