shader_type canvas_item;

void fragment() {
    vec4 text_color = texture(TEXTURE, UV);
    vec4 glow_color = vec4(1.0, 0.8, 0.3, 1.0); // Set glow color here (RGBA)
    float glow_intensity = 0.5; // Adjust intensity

    // Glow effect based on alpha
    COLOR = text_color + glow_color * text_color.a * glow_intensity;
}


