extends Window

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	popup_window = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_close_requested() -> void:
	visible = false