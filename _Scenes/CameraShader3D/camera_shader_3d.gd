class_name CameraShader3D extends Camera3D

@onready var shader_parent: Node = $Shaders
@export var shaders: Array[CustomShader]

func _ready() -> void:
	for i in range(len(shaders)):
		var new_mesh: QuadMesh = QuadMesh.new()
		new_mesh.size = Vector2(2.0, 2.0)
		new_mesh.flip_faces = true
		
		var new_material: ShaderMaterial = ShaderMaterial.new()
		new_material.shader = shaders[i].shader
		new_material.render_priority = i
		
		for key in shaders[i].settings.keys():
			new_material.set_shader_parameter(key, shaders[i].settings[key])
		
		var new_mesh_instance: MeshInstance3D = MeshInstance3D.new()
		shader_parent.add_child(new_mesh_instance)
		new_mesh_instance.extra_cull_margin = 1.0
		new_mesh_instance.mesh = new_mesh
		new_mesh_instance.material_override = new_material
		new_mesh_instance.name = shaders[i].shader_name
		
