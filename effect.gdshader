shader_type canvas_item;

void fragment() {
	vec2 uv = UV - mod(UV, vec2(0.003, 0.003));
    vec4 col = texture(TEXTURE, uv);
	col.r = float(int(col.r * 10.0))/10.0;
	col.g = float(int(col.g * 10.0))/10.0;
	col.b = float(int(col.b * 10.0))/10.0;
	COLOR = col;
}