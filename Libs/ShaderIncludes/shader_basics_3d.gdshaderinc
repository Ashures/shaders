#include "basics.gdshaderinc"

/*
	CONVERTING DEPTH FROM 0 - 1 VALUES TO ORIGINAL WORLD SPACE DEPTHS.
*/
float linearize_depth(float depth, vec2 screen_uv, mat4 inv_proj) {
	vec3 ndc = vec3(screen_uv * 2.0 - 1.0, depth);
	vec4 view = inv_proj * vec4(ndc, 1.0);
	view.xyz /= view.w;
	return -view.z;
}

/*
	CHECKING FOR EDGES WITHIN size DISTANCE IN ALL CARDINAL DIRECTIONS.
	CHANGE color FROM INPUT TO edge_color IF EDGE IS DETECTED.
	DO NOTHING IF EDGE IS NOT DETECTED.
*/
vec3 detect_edge(sampler2D DEPTH_TEXTURE, vec2 screen_uv, mat4 inv_proj, vec3 curr_color, vec3 edge_color, float size) {
	float n = linearize_depth(texture(DEPTH_TEXTURE, screen_uv + size * vec2(0.0, 1.0)).r, screen_uv + size * vec2(0.0, 1.0), inv_proj);
	float e = linearize_depth(texture(DEPTH_TEXTURE, screen_uv + size / 2.0 * vec2(1.0, 0.0)).r, screen_uv + size * vec2(1.0, 0.0), inv_proj);
	float s = linearize_depth(texture(DEPTH_TEXTURE, screen_uv + size * vec2(0.0, -1.0)).r, screen_uv + size * vec2(0.0, -1.0), inv_proj);
	float w = linearize_depth(texture(DEPTH_TEXTURE, screen_uv + size / 2.0 * vec2(-1.0, 0.0)).r, screen_uv + size * vec2(-1.0, 0.0), inv_proj);

	float threshold = 1.0;
	if (n - s > threshold || w - e > threshold || s - n > threshold || e - w > threshold)
		return edge_color;

	return curr_color;
}