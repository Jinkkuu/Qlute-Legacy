extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var StartMenu = $StartMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = get_node("Tween")
	tween.interpolate_property(StartMenu, "rect_position",
		Vector2(get_viewport_rect().size.x,StartMenu.rect_position.y), Vector2(0, StartMenu.rect_position.y), 0.5,
			Tween.TRANS_CUBIC, Tween.EASE_OUT)
	tween.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _exit():
	get_tree().quit()


func _play():
	get_tree().change_scene("res://Panels/Main/SongSelect.tscn")


func _browse():
	get_tree().change_scene("res://Panels/Main/Browse.tscn")
