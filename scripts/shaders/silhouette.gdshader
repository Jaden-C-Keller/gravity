shader_type spatial;
render_mode depth_test_disabled;

uniform sampler2D depthTex:hint_depth_texture;

void fragment() {
	// Called for every pixel the material is visible on.
	float depth = texture(depthTex, SCREEN_UV).x;
	ALBEDO = vec3(1.0, 0.0, 0.0);
	if(depth > FRAGCOORD.z){
		ALBEDO = vec3(0.0);
		ALPHA = 0.5;
	}
}
