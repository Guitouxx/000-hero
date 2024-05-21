precision highp float;

in vec2 vUv;
out vec4 outColor;

uniform float uTotalCells;
uniform float uCellDefaultRadius;
uniform float uCellHighlightRadius;
uniform float uMouseRadius;
uniform float uTime;
uniform vec2 uMouse;
uniform vec2 uResolution;
uniform vec3 uCellDefaultColor;

#include "./utils.glsl";
#include "./letters.glsl";

void main() {
  //uv aspect ratio
  vec2 arUv = squareAspectRatio(vUv, uResolution);

  //output
  vec3 final = vec3(0.);
  vec3 color = uCellDefaultColor;

  //mouse coordinates
  vec2 mUv = uMouse;
  mUv *= -.5; 
  float mouse = 1. - circleSmooth(vUv + mUv, 0., uMouseRadius);

  //grid
  vec2 pattern = fract(arUv * uTotalCells);

  //Cell index
  vec2 cellPosition = floor(arUv * uTotalCells);

  // Add letters
  vec2 startPosition = vec2( floor(uTotalCells / 2. - 24.), floor(uTotalCells / 2. - 8.));
  float letters = 1. - generateText(cellPosition, startPosition, mouse);

  //create dots for the letter and the mouse
  float letterDot = circle(pattern, (1. - (letters)) * (uCellHighlightRadius + mouse) );

  //create normal dot
  float c = circle(pattern, uCellDefaultRadius);
  c *= letterDot; // add letters to normal dots

  // Color Only for Letter
  if(letterDot < uCellDefaultRadius + fwidth(letterDot) * 2.) {
    vec3 a = vec3(0.5,0.5,0.5);
    vec3 b = vec3(0.5,0.5,0.5);
    vec3 c = vec3(2.0,1.0,1.0);
    vec3 d = vec3(1.0,0.17,0.23);

    //color sin palette
    color = 1. / mouse * palette(rand(cellPosition), a, b, c, d);
  }
  
  // add the color
  final = vec3(1. - c) * color;

  //boom
  outColor = vec4(final, 1.);
}
