extends Control

func SetTextInfo(text: String):
	$ScoreLevelText.text = "[center]" + text
	match text:
		"PERFECT":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("ffce00"))
		"GREAT":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("80f53d"))
		"GOOD":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("80f59c"))
		"OK":
			$ScoreLevelText.set("theme_override_colors/default_color", Color("80f5ea"))
		_:
			$ScoreLevelText.set("theme_override_colors/default_color", Color("646464"))
