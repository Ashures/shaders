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