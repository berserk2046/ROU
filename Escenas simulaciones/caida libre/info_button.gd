extends Button

func _ready():
	pressed.connect(self._info_button_pressed)

func _info_button_pressed():
	if $"../info_window".visible: $"../info_window".visible=false
	else: $"../info_window".visible=true
