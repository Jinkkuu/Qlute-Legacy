extends Node

var qlutedir = "user://"
var beatmap_dir = qlutedir + "beatmaps/"
var download_dir = qlutedir + "downloads/"
var screenshot_dir = qlutedir + "screenshots/"
var checkdir = [qlutedir, beatmap_dir, download_dir, screenshot_dir]
var songcount = 0
var beatmaps = []


func get_dir_contents(path):
	var contents = []
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name != "." and file_name != "..":
				contents.append(file_name)
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print("❌ Couldn't open dir: ", path)
	return contents

func read_lines(path):
	var file = File.new()
	var lines = []
	if file.file_exists(path):
		file.open(path, File.READ)
		while not file.eof_reached():
			lines.append(file.get_line())
		file.close()
	return lines

var SongID = 0

func _ready():
	var directory = Directory.new()
	for dir in checkdir:
		if directory.dir_exists(dir):
			print("[QluteLE] "+ str(dir) +" exists continuing")
		else:
			print("[QluteLE] "+ str(dir) +" does not exist. Creating it for you.")
			directory.make_dir(dir)
	for content in get_dir_contents(beatmap_dir):
		BeatmapProcessor.parse_beatmapdir(content)
	SongID = BeatmapProcessor.get_random_beatmap().ID
	
