extends MeshInstance3D

@export var rotations_per_min: float

func _process(delta: float) -> void:
	rotate_y(2 * PI * rotations_per_min * delta)
