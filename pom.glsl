vec2 ParallaxOcclusionMapping( sampler2D depthMap, vec2 uv, vec2 displacement, float pivot ) {
	const float layerDepth = 1.0 / float( layers );
	float currentLayerDepth = 0.0;

	vec2 deltaUv = displacement / float( layers );
	vec2 currentUv = uv + pivot * displacement;
	float currentDepth = texture2D( depthMap, currentUv ).r;

	for( int i = 0; i < layers; i++ ) {
		if( currentLayerDepth > currentDepth )
			break;

		currentUv -= deltaUv;
		currentDepth = texture2D( depthMap, currentUv ).r;
		currentLayerDepth += layerDepth;
	}

	vec2 prevUv = currentUv + deltaUv;
	float endDepth = currentDepth - currentLayerDepth;
	float startDepth =
		texture2D( depthMap, prevUv ).r - currentLayerDepth + layerDepth;

	float w = endDepth / ( endDepth - startDepth );

	return mix( currentUv, prevUv, w );
}


vec2 ParallaxOcclusionMapping( sampler2D depthMap, vec2 uv, vec2 displacement ) {
	return ParallaxOcclusionMapping( depthMap, uv, displacement, 0.0 );
}

// clang-format off
#pragma glslify: export(ParallaxOcclusionMapping)
