class_name CameraShader3D extends Camera3D

@onready
var screen_mesh: MeshInstance3D = $SpatialMesh3D

@export var shader: Shader

@export_color_no_alpha var background_color: Color

func _ready() -> void:
	var new_mesh: QuadMesh = QuadMesh.new()
	new_mesh.size = Vector2(2.0, 2.0)
	new_mesh.flip_faces = true
	
	var new_material: ShaderMaterial = ShaderMaterial.new()
	new_material.shader = shader
	new_material.set_shader_parameter("background_color", background_color)
	
	screen_mesh.mesh = new_mesh
	screen_mesh.material_override = new_material
