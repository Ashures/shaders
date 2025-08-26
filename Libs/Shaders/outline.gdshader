shader_type spatial;
render_mode unshaded, fog_disabled;

#include "res://Libs/ShaderIncludes/shader_basics_3d.gdshaderinc"

uniform sampler2D DEPTH_TEXTURE: hint_depth_texture;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture;

uniform vec4 outline_color;
uniform float outline_size;
uniform float effect_dist;

void vertex() {
	POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

void fragment() {
	float depth = texture(DEPTH_TEXTURE, SCREEN_UV).r;
	float linear_depth = linearize_depth(depth, SCREEN_UV, INV_PROJECTION_MATRIX);

	vec3 tex = texture(SCREEN_TEXTURE, SCREEN_UV).rgb;
	vec3 color = tex;
	
	if (linear_depth <= effect_dist) {
		color = detect_edge(DEPTH_TEXTURE, SCREEN_UV, INV_PROJECTION_MATRIX, outline_color.rgb, outline_size);
	}
	
	if (linear_depth > effect_dist || color == vec3(-1.0)) {
		discard;
	}

	ALBEDO = color;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
