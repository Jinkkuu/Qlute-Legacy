extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for song in Settingsoperator.beatmaps:
		$SongList.add_child(Label.new().text(song.Title))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _back():
	get_tree().change_scene("res://Panels/HomeScreen.tscn")
