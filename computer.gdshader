shader_type spatial;

uniform sampler2D tex : hint_default_black;

void fragment() {
    vec2 pos = UV;
    pos.x += sin(TIME * 100.0 + pos.y * 700.0)*0.003; // horizontal wave

    vec4 col = texture(tex, pos);

    ALBEDO = col.rgb;
    ALPHA = col.a;
	EMISSION = col.rgb * 2.0;
}