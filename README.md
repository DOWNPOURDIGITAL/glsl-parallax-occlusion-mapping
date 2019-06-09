# glsl-parallax-occlusion-mapping

[glslify](https://github.com/glslify/glslify) module implementing [parallax occlusion mapping](https://www.gamedev.net/articles/programming/graphics/a-closer-look-at-parallax-occlusion-mapping-r3262).

## Installation
[glslify](https://github.com/glslify/glslify) is required for importing.

```
yarn add glsl-parallax-occlusion-mapping
```
```
npm i glsl-parallax-occlusion-mapping --save
```

## Usage
When requiring, you must specify the number of **`layers`** to use.

```glsl
#pragma glslify: pom = require('glsl-parallax-occlusion-mapping', layers=8)
```

```glsl
vec2 pom( sampler2D depthMap, vec2 uv, vec2 displacement, float pivot )
```
The function accepts 4 arguments:

- **`depthMap`** is your depth/displacement map. Only the red channel is used.
- **`uv`** are your regular texture coordinates for `depthMap`.
- **`displacement`** is the direction in which to shift the texture. Usually this is the `xy` component of your view direction multiplied by a depth scalar.
- **`pivot`** (optional) describes the elevation from which to pivot the displacement (where 0.0 is the highest and 1.0 is the lowest elevation). Defaults to 0.0. 

It returns the new texture coordinates.

## Example
```glsl
#pragma glslify: pom = require('glsl-parallax-occlusion-mapping', layers=8)

uniform sampler2D tDiffuse;
uniform sampler2D tDepth;

varying vec2 vUv;

void main() {
  vec2 newUv = pom( tDepth, vUv, viewDirection.xy * .1 );
  
  gl_FragColor = texture2D( tDiffuse, newUv );
}	
```

## Credits
This implementation is based on [this great article](https://learnopengl.com/Advanced-Lighting/Parallax-Mapping).
