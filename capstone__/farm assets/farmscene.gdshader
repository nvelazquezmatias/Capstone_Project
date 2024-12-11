shader_type canvas_item;

uniform vec4 glow_color : 
uniform float intensity : hint_range
uniform float glow_speed : hint_range(0.0, 5.0) = 1.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
    vec4 base_color = texture(TEXTURE, UV);
    float glow_factor = sin(TIME * glow_speed) * 0.5 + 0.5;
    COLOR = base_color + glow_color * glow_factor * intensity;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
