extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func parse_beatmap(filename: String, set_id: int = 0):
	var file := File.new()
	if not file.file_exists(filename):
		print("❌ File not found: ", filename)
		return
	
	file.open(filename, File.READ)
	var text := file.get_as_text()
	file.close()

	var lines := text.split("\n")
	
	var songtitle = ""
	var artist = ""
	var version = ""
	var timetotal = 0
	var bpm = 0
	var osubeatid = 0
	var osubeatidset = 0
	var qlbeatid = 0
	var qlbeatidset = 0
	var accuracy = 0
	var ppvalue = 0.0
	var mapper = ""
	var levelrating = 0.0
	var notetime = 0
	var background = ""
	var audio = ""
	var rawurl = filename
	var hitob = 0
	var dance := []
	var is_hit_object_section = false
	var path = filename.replace(filename.get_file(), "")
	var keycount = 4

	for line in lines:
		line = line.strip_edges()
		if line.begins_with("Title:"):
			songtitle = line.split(":")[1].strip_edges()
		elif line.begins_with("Artist:"):
			artist = line.split(":")[1].strip_edges()
		elif line.begins_with("CircleSize:"):
			var parsed = float(line.split(":")[1].strip_edges())
			keycount = int(parsed)
		elif line.begins_with("OverallDifficulty:"):
			var parsed = float(line.split(":")[1].strip_edges())
			accuracy = int(parsed)
		elif line.begins_with("AudioFilename:"):
			audio = line.split(":")[1].strip_edges()
		elif line.begins_with("BeatmapID:"):
			osubeatid = int(line.split(":")[1].strip_edges())
		elif line.begins_with("BeatmapSetID:"):
			osubeatidset = int(line.split(":")[1].strip_edges())
		elif line.begins_with("QluteBeatID:"):
			qlbeatid = int(line.split(":")[1].strip_edges())
		elif line.begins_with("QluteBeatIDSet:"):
			qlbeatidset = int(line.split(":")[1].strip_edges())
		elif line.begins_with("Creator:"):
			mapper = line.split(":")[1].strip_edges()
		elif line.begins_with("Version:"):
			version = line.split(":")[1].strip_edges()
		elif line.begins_with("0,0,\"") and "\"" in line:
			var parts = line.split("\"")
			if parts.size() > 1:
				background = parts[1].strip_edges()
		elif line.begins_with("[TimingPoints]"):
			var found_bpm = false
			var index = lines.find(line) + 1
			while index < lines.size() and not lines[index].begins_with("["):
				var timing_line = lines[index].strip_edges()
				if timing_line == "":
					index += 1
					continue
				var timing_parts = timing_line.split(",")
				if timing_parts.size() > 1:
					if not found_bpm:
						var bpm_val = float(timing_parts[1])
						if bpm_val != 0:
							bpm = int(60000 / bpm_val)
							found_bpm = true
					var timecount = int(timing_parts[0])
					var flashtime = int(timing_parts[-1])
					var dc = DanceCounter.new()
					dc.time = timecount
					dc.flash = flashtime == 1
					dance.append(dc)
				index += 1
		elif line == "[HitObjects]":
			is_hit_object_section = true
			continue
		elif is_hit_object_section:
			if line == "" or line.begins_with("["):
				ppvalue = 0  # Stubbed for now
				levelrating = hitob * 0.005
				timetotal = notetime
				is_hit_object_section = false
				continue
			var note_cfg = line.split(",")
			if note_cfg.size() > 2:
				notetime = int(float(note_cfg[2]))
				hitob += 1

	var beatmap = BeatmapLegend.new()
	beatmap.ID = len(Settingsoperator.beatmaps)
	beatmap.SetID = set_id
	beatmap.Title = songtitle
	beatmap.Artist = artist
	beatmap.Mapper = mapper
	beatmap.KeyCount = keycount
	beatmap.Version = version
	beatmap.pp = ppvalue
	beatmap.Osubeatid = osubeatid
	beatmap.Osubeatidset = osubeatidset
	beatmap.Beatid = qlbeatid
	beatmap.Beatidset = qlbeatidset
	beatmap.Bpm = bpm
	beatmap.Dance = dance
	beatmap.Timetotal = timetotal
	beatmap.Levelrating = levelrating
	beatmap.Accuracy = accuracy
	beatmap.Background = background
	beatmap.Audio = audio
	beatmap.Rawurl = rawurl
	beatmap.Path = path

	Settingsoperator.beatmaps.append(beatmap)

func get_random_beatmap():
	if Settingsoperator.beatmaps.empty():
		return null
	var index = randi() % Settingsoperator.beatmaps.size()
	return Settingsoperator.beatmaps[index]

func parse_beatmapdir(path):
	for file in Settingsoperator.get_dir_contents(Settingsoperator.beatmap_dir+ "/" + path):
		if str(file).ends_with(".osu"):
			parse_beatmap(Settingsoperator.beatmap_dir+ "/" + path + "/" + file)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
