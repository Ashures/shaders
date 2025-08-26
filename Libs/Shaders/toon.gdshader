shader_type spatial;
render_mode unshaded, fog_disabled;

#include "res://Libs/ShaderIncludes/shader_basics_3d.gdshaderinc"

uniform sampler2D DEPTH_TEXTURE: hint_depth_texture;
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture;

uniform int no_of_colors;

void vertex() {
	POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

void fragment() {
	float depth = texture(DEPTH_TEXTURE, SCREEN_UV).r;
	float linear_depth = linearize_depth(depth, SCREEN_UV, INV_PROJECTION_MATRIX);

	vec3 tex = texture(SCREEN_TEXTURE, SCREEN_UV).rgb;
	vec3 color = tex;
	
	if (linear_depth <= 50.0) {
		color = toon_shade(color, no_of_colors);
	} else {
		discard;
	}

	ALBEDO = color;
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
