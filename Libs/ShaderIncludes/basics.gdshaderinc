float relative_luminance(vec3 color) {
	return 0.299 * color.r + 0.587 * color.g + 0.114 * color.b;
}

float compare_contrast(vec3 color1, vec3 color2) {
	return relative_luminance(color1) - relative_luminance(color2);
}

int ceili(float value) {
	return int(ceil(value));
}

int floori(float value) {
	return int(floor(value));
}

vec3 toon_shade_with_colors(vec3 color, vec3[3] light_colors) {
	int no_of_colors = 3;
	return light_colors[clamp(floori(relative_luminance(color) * float(no_of_colors) + 0.5), 0, no_of_colors - 1)];
}

vec3 toon_shade_with_colors(vec3 color, vec3[5] light_colors) {
	int no_of_colors = 5;
	return light_colors[clamp(floori(relative_luminance(color) * float(no_of_colors)), 0, no_of_colors - 1)];
}

float limit_channel(float channel, int n_colors) {
	float n = float(n_colors - 1);
	return floor(channel * n + 0.5) / n;
}

vec3 toon_shade(vec3 color, int no_of_colors) {
	vec3 new_color;
	
	new_color.r = limit_channel(color.r, no_of_colors);
	new_color.g = limit_channel(color.g, no_of_colors);
	new_color.b = limit_channel(color.b, no_of_colors);
	
	return new_color;
}