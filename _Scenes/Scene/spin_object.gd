extends MeshInstance3D

func _process(delta: float) -> void:
	rotate_y(PI / 4 * delta)
