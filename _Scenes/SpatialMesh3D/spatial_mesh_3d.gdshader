shader_type spatial;
render_mode unshaded, fog_disabled;

#include "res://Libs/ShaderIncludes/shader_basics_3d.gdshaderinc"

uniform sampler2D DEPTH_TEXTURE: hint_depth_texture;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture;

//uniform vec3[5] light_colors;
uniform vec3 background_color;

void vertex() {
	POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

void fragment() {
	float depth = texture(DEPTH_TEXTURE, SCREEN_UV).r;
	float linear_depth = linearize_depth(depth, SCREEN_UV, INV_PROJECTION_MATRIX);

	vec3 tex = texture(SCREEN_TEXTURE, SCREEN_UV).rgb;

	vec3 color = tex;

	if (linear_depth <= 50.0) {
		int no_of_colors = 5;
		color = toon_shade(color, no_of_colors);
		
		vec3 edge_color = vec3(1.0);
		float edge_width = 0.0075;
		color = detect_edge(DEPTH_TEXTURE, SCREEN_UV, INV_PROJECTION_MATRIX, color, edge_color, edge_width);
	} else {
		color = background_color;
	}

	ALBEDO = color;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
