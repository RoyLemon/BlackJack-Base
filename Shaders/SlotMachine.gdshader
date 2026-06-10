shader_type canvas_item;

uniform float scroll_speed : hint_range(0.0, 10.0) = 3.0;
uniform float offset: hint_range(0.0, 1.0) = 0.0;

void fragment() {
	vec2 uv = UV;
	uv.y = fract(uv.y + TIME * scroll_speed + offset);
	COLOR = texture(TEXTURE, uv);
}