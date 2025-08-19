{@}AntimatterCopy.fs{@}uniform sampler2D tDiffuse;

varying vec2 vUv;

void main() {
    gl_FragColor = texture2D(tDiffuse, vUv);
}{@}AntimatterCopy.vs{@}varying vec2 vUv;
void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}{@}AntimatterPass.vs{@}varying vec2 vUv;

void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}{@}AntimatterPosition.vs{@}uniform sampler2D tPos;
uniform float uDPR;

void main() {
    vec4 decodedPos = texture2D(tPos, position.xy);
    vec3 pos = decodedPos.xyz;

    vec4 mvPosition = modelViewMatrix * vec4(pos, 1.0);
    gl_PointSize = (0.02 * uDPR) * (1000.0 / length(mvPosition.xyz));
    gl_Position = projectionMatrix * mvPosition;
}{@}AntimatterBasicFrag.fs{@}void main() {
    gl_FragColor = vec4(1.0);
}{@}antimatter.glsl{@}vec3 getData(sampler2D tex, vec2 uv) {
    return texture2D(tex, uv).xyz;
}

vec4 getData4(sampler2D tex, vec2 uv) {
    return texture2D(tex, uv);
}

{@}blendmodes.glsl{@}float blendColorDodge(float base, float blend) {
    return (blend == 1.0)?blend:min(base/(1.0-blend), 1.0);
}
vec3 blendColorDodge(vec3 base, vec3 blend) {
    return vec3(blendColorDodge(base.r, blend.r), blendColorDodge(base.g, blend.g), blendColorDodge(base.b, blend.b));
}
vec3 blendColorDodge(vec3 base, vec3 blend, float opacity) {
    return (blendColorDodge(base, blend) * opacity + base * (1.0 - opacity));
}
float blendColorBurn(float base, float blend) {
    return (blend == 0.0)?blend:max((1.0-((1.0-base)/blend)), 0.0);
}
vec3 blendColorBurn(vec3 base, vec3 blend) {
    return vec3(blendColorBurn(base.r, blend.r), blendColorBurn(base.g, blend.g), blendColorBurn(base.b, blend.b));
}
vec3 blendColorBurn(vec3 base, vec3 blend, float opacity) {
    return (blendColorBurn(base, blend) * opacity + base * (1.0 - opacity));
}
float blendVividLight(float base, float blend) {
    return (blend<0.5)?blendColorBurn(base, (2.0*blend)):blendColorDodge(base, (2.0*(blend-0.5)));
}
vec3 blendVividLight(vec3 base, vec3 blend) {
    return vec3(blendVividLight(base.r, blend.r), blendVividLight(base.g, blend.g), blendVividLight(base.b, blend.b));
}
vec3 blendVividLight(vec3 base, vec3 blend, float opacity) {
    return (blendVividLight(base, blend) * opacity + base * (1.0 - opacity));
}
float blendHardMix(float base, float blend) {
    return (blendVividLight(base, blend)<0.5)?0.0:1.0;
}
vec3 blendHardMix(vec3 base, vec3 blend) {
    return vec3(blendHardMix(base.r, blend.r), blendHardMix(base.g, blend.g), blendHardMix(base.b, blend.b));
}
vec3 blendHardMix(vec3 base, vec3 blend, float opacity) {
    return (blendHardMix(base, blend) * opacity + base * (1.0 - opacity));
}
float blendLinearDodge(float base, float blend) {
    return min(base+blend, 1.0);
}
vec3 blendLinearDodge(vec3 base, vec3 blend) {
    return min(base+blend, vec3(1.0));
}
vec3 blendLinearDodge(vec3 base, vec3 blend, float opacity) {
    return (blendLinearDodge(base, blend) * opacity + base * (1.0 - opacity));
}
float blendLinearBurn(float base, float blend) {
    return max(base+blend-1.0, 0.0);
}
vec3 blendLinearBurn(vec3 base, vec3 blend) {
    return max(base+blend-vec3(1.0), vec3(0.0));
}
vec3 blendLinearBurn(vec3 base, vec3 blend, float opacity) {
    return (blendLinearBurn(base, blend) * opacity + base * (1.0 - opacity));
}
float blendLinearLight(float base, float blend) {
    return blend<0.5?blendLinearBurn(base, (2.0*blend)):blendLinearDodge(base, (2.0*(blend-0.5)));
}
vec3 blendLinearLight(vec3 base, vec3 blend) {
    return vec3(blendLinearLight(base.r, blend.r), blendLinearLight(base.g, blend.g), blendLinearLight(base.b, blend.b));
}
vec3 blendLinearLight(vec3 base, vec3 blend, float opacity) {
    return (blendLinearLight(base, blend) * opacity + base * (1.0 - opacity));
}
float blendLighten(float base, float blend) {
    return max(blend, base);
}
vec3 blendLighten(vec3 base, vec3 blend) {
    return vec3(blendLighten(base.r, blend.r), blendLighten(base.g, blend.g), blendLighten(base.b, blend.b));
}
vec3 blendLighten(vec3 base, vec3 blend, float opacity) {
    return (blendLighten(base, blend) * opacity + base * (1.0 - opacity));
}
float blendDarken(float base, float blend) {
    return min(blend, base);
}
vec3 blendDarken(vec3 base, vec3 blend) {
    return vec3(blendDarken(base.r, blend.r), blendDarken(base.g, blend.g), blendDarken(base.b, blend.b));
}
vec3 blendDarken(vec3 base, vec3 blend, float opacity) {
    return (blendDarken(base, blend) * opacity + base * (1.0 - opacity));
}
float blendPinLight(float base, float blend) {
    return (blend<0.5)?blendDarken(base, (2.0*blend)):blendLighten(base, (2.0*(blend-0.5)));
}
vec3 blendPinLight(vec3 base, vec3 blend) {
    return vec3(blendPinLight(base.r, blend.r), blendPinLight(base.g, blend.g), blendPinLight(base.b, blend.b));
}
vec3 blendPinLight(vec3 base, vec3 blend, float opacity) {
    return (blendPinLight(base, blend) * opacity + base * (1.0 - opacity));
}
float blendReflect(float base, float blend) {
    return (blend == 1.0)?blend:min(base*base/(1.0-blend), 1.0);
}
vec3 blendReflect(vec3 base, vec3 blend) {
    return vec3(blendReflect(base.r, blend.r), blendReflect(base.g, blend.g), blendReflect(base.b, blend.b));
}
vec3 blendReflect(vec3 base, vec3 blend, float opacity) {
    return (blendReflect(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendGlow(vec3 base, vec3 blend) {
    return blendReflect(blend, base);
}
vec3 blendGlow(vec3 base, vec3 blend, float opacity) {
    return (blendGlow(base, blend) * opacity + base * (1.0 - opacity));
}
float blendOverlay(float base, float blend) {
    return base<0.5?(2.0*base*blend):(1.0-2.0*(1.0-base)*(1.0-blend));
}
vec3 blendOverlay(vec3 base, vec3 blend) {
    return vec3(blendOverlay(base.r, blend.r), blendOverlay(base.g, blend.g), blendOverlay(base.b, blend.b));
}
vec3 blendOverlay(vec3 base, vec3 blend, float opacity) {
    return (blendOverlay(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendHardLight(vec3 base, vec3 blend) {
    return blendOverlay(blend, base);
}
vec3 blendHardLight(vec3 base, vec3 blend, float opacity) {
    return (blendHardLight(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendPhoenix(vec3 base, vec3 blend) {
    return min(base, blend)-max(base, blend)+vec3(1.0);
}
vec3 blendPhoenix(vec3 base, vec3 blend, float opacity) {
    return (blendPhoenix(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendNormal(vec3 base, vec3 blend) {
    return blend;
}
vec3 blendNormal(vec3 base, vec3 blend, float opacity) {
    return (blendNormal(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendNegation(vec3 base, vec3 blend) {
    return vec3(1.0)-abs(vec3(1.0)-base-blend);
}
vec3 blendNegation(vec3 base, vec3 blend, float opacity) {
    return (blendNegation(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendMultiply(vec3 base, vec3 blend) {
    return base*blend;
}
vec3 blendMultiply(vec3 base, vec3 blend, float opacity) {
    return (blendMultiply(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendAverage(vec3 base, vec3 blend) {
    return (base+blend)/2.0;
}
vec3 blendAverage(vec3 base, vec3 blend, float opacity) {
    return (blendAverage(base, blend) * opacity + base * (1.0 - opacity));
}
float blendScreen(float base, float blend) {
    return 1.0-((1.0-base)*(1.0-blend));
}
vec3 blendScreen(vec3 base, vec3 blend) {
    return vec3(blendScreen(base.r, blend.r), blendScreen(base.g, blend.g), blendScreen(base.b, blend.b));
}
vec3 blendScreen(vec3 base, vec3 blend, float opacity) {
    return (blendScreen(base, blend) * opacity + base * (1.0 - opacity));
}
float blendSoftLight(float base, float blend) {
    return (blend<0.5)?(2.0*base*blend+base*base*(1.0-2.0*blend)):(sqrt(base)*(2.0*blend-1.0)+2.0*base*(1.0-blend));
}
vec3 blendSoftLight(vec3 base, vec3 blend) {
    return vec3(blendSoftLight(base.r, blend.r), blendSoftLight(base.g, blend.g), blendSoftLight(base.b, blend.b));
}
vec3 blendSoftLight(vec3 base, vec3 blend, float opacity) {
    return (blendSoftLight(base, blend) * opacity + base * (1.0 - opacity));
}
float blendSubtract(float base, float blend) {
    return max(base+blend-1.0, 0.0);
}
vec3 blendSubtract(vec3 base, vec3 blend) {
    return max(base+blend-vec3(1.0), vec3(0.0));
}
vec3 blendSubtract(vec3 base, vec3 blend, float opacity) {
    return (blendSubtract(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendExclusion(vec3 base, vec3 blend) {
    return base+blend-2.0*base*blend;
}
vec3 blendExclusion(vec3 base, vec3 blend, float opacity) {
    return (blendExclusion(base, blend) * opacity + base * (1.0 - opacity));
}
vec3 blendDifference(vec3 base, vec3 blend) {
    return abs(base-blend);
}
vec3 blendDifference(vec3 base, vec3 blend, float opacity) {
    return (blendDifference(base, blend) * opacity + base * (1.0 - opacity));
}
float blendAdd(float base, float blend) {
    return min(base+blend, 1.0);
}
vec3 blendAdd(vec3 base, vec3 blend) {
    return min(base+blend, vec3(1.0));
}
vec3 blendAdd(vec3 base, vec3 blend, float opacity) {
    return (blendAdd(base, blend) * opacity + base * (1.0 - opacity));
}{@}conditionals.glsl{@}vec4 when_eq(vec4 x, vec4 y) {
  return 1.0 - abs(sign(x - y));
}

vec4 when_neq(vec4 x, vec4 y) {
  return abs(sign(x - y));
}

vec4 when_gt(vec4 x, vec4 y) {
  return max(sign(x - y), 0.0);
}

vec4 when_lt(vec4 x, vec4 y) {
  return max(sign(y - x), 0.0);
}

vec4 when_ge(vec4 x, vec4 y) {
  return 1.0 - when_lt(x, y);
}

vec4 when_le(vec4 x, vec4 y) {
  return 1.0 - when_gt(x, y);
}

vec3 when_eq(vec3 x, vec3 y) {
  return 1.0 - abs(sign(x - y));
}

vec3 when_neq(vec3 x, vec3 y) {
  return abs(sign(x - y));
}

vec3 when_gt(vec3 x, vec3 y) {
  return max(sign(x - y), 0.0);
}

vec3 when_lt(vec3 x, vec3 y) {
  return max(sign(y - x), 0.0);
}

vec3 when_ge(vec3 x, vec3 y) {
  return 1.0 - when_lt(x, y);
}

vec3 when_le(vec3 x, vec3 y) {
  return 1.0 - when_gt(x, y);
}

vec2 when_eq(vec2 x, vec2 y) {
  return 1.0 - abs(sign(x - y));
}

vec2 when_neq(vec2 x, vec2 y) {
  return abs(sign(x - y));
}

vec2 when_gt(vec2 x, vec2 y) {
  return max(sign(x - y), 0.0);
}

vec2 when_lt(vec2 x, vec2 y) {
  return max(sign(y - x), 0.0);
}

vec2 when_ge(vec2 x, vec2 y) {
  return 1.0 - when_lt(x, y);
}

vec2 when_le(vec2 x, vec2 y) {
  return 1.0 - when_gt(x, y);
}

float when_eq(float x, float y) {
  return 1.0 - abs(sign(x - y));
}

float when_neq(float x, float y) {
  return abs(sign(x - y));
}

float when_gt(float x, float y) {
  return max(sign(x - y), 0.0);
}

float when_lt(float x, float y) {
  return max(sign(y - x), 0.0);
}

float when_ge(float x, float y) {
  return 1.0 - when_lt(x, y);
}

float when_le(float x, float y) {
  return 1.0 - when_gt(x, y);
}

vec4 and(vec4 a, vec4 b) {
  return a * b;
}

vec4 or(vec4 a, vec4 b) {
  return min(a + b, 1.0);
}

vec4 Not(vec4 a) {
  return 1.0 - a;
}

vec3 and(vec3 a, vec3 b) {
  return a * b;
}

vec3 or(vec3 a, vec3 b) {
  return min(a + b, 1.0);
}

vec3 Not(vec3 a) {
  return 1.0 - a;
}

vec2 and(vec2 a, vec2 b) {
  return a * b;
}

vec2 or(vec2 a, vec2 b) {
  return min(a + b, 1.0);
}


vec2 Not(vec2 a) {
  return 1.0 - a;
}

float and(float a, float b) {
  return a * b;
}

float or(float a, float b) {
  return min(a + b, 1.0);
}

float Not(float a) {
  return 1.0 - a;
}{@}contrast.glsl{@}vec3 adjustContrast(vec3 color, float c, float m) {
	float t = 0.5 - c * 0.5;
	color.rgb = color.rgb * c + t;
	return color * m;
}{@}curl.glsl{@}#test Device.mobile
float sinf2(float x) {
    x*=0.159155;
    x-=floor(x);
    float xx=x*x;
    float y=-6.87897;
    y=y*xx+33.7755;
    y=y*xx-72.5257;
    y=y*xx+80.5874;
    y=y*xx-41.2408;
    y=y*xx+6.28077;
    return x*y;
}

float cosf2(float x) {
    return sinf2(x+1.5708);
}
#endtest

#test !Device.mobile
    #define sinf2 sin
    #define cosf2 cos
#endtest

float potential1(vec3 v) {
    float noise = 0.0;
    noise += sinf2(v.x * 1.8 + v.z * 3.) + sinf2(v.x * 4.8 + v.z * 4.5) + sinf2(v.x * -7.0 + v.z * 1.2) + sinf2(v.x * -5.0 + v.z * 2.13);
    noise += sinf2(v.y * -0.48 + v.z * 5.4) + sinf2(v.y * 2.56 + v.z * 5.4) + sinf2(v.y * 4.16 + v.z * 2.4) + sinf2(v.y * -4.16 + v.z * 1.35);
    return noise;
}

float potential2(vec3 v) {
    float noise = 0.0;
    noise += sinf2(v.y * 1.8 + v.x * 3. - 2.82) + sinf2(v.y * 4.8 + v.x * 4.5 + 74.37) + sinf2(v.y * -7.0 + v.x * 1.2 - 256.72) + sinf2(v.y * -5.0 + v.x * 2.13 - 207.683);
    noise += sinf2(v.z * -0.48 + v.x * 5.4 -125.796) + sinf2(v.z * 2.56 + v.x * 5.4 + 17.692) + sinf2(v.z * 4.16 + v.x * 2.4 + 150.512) + sinf2(v.z * -4.16 + v.x * 1.35 - 222.137);
    return noise;
}

float potential3(vec3 v) {
    float noise = 0.0;
    noise += sinf2(v.z * 1.8 + v.y * 3. - 194.58) + sinf2(v.z * 4.8 + v.y * 4.5 - 83.13) + sinf2(v.z * -7.0 + v.y * 1.2 -845.2) + sinf2(v.z * -5.0 + v.y * 2.13 - 762.185);
    noise += sinf2(v.x * -0.48 + v.y * 5.4 - 707.916) + sinf2(v.x * 2.56 + v.y * 5.4 + -482.348) + sinf2(v.x * 4.16 + v.y * 2.4 + 9.872) + sinf2(v.x * -4.16 + v.y * 1.35 - 476.747);
    return noise;
}

vec3 snoiseVec3( vec3 x ) {
    float s  = potential1(x);
    float s1 = potential2(x);
    float s2 = potential3(x);
    return vec3( s , s1 , s2 );
}

//Analitic derivatives of the potentials for the curl noise, based on: http://weber.itn.liu.se/~stegu/TNM084-2019/bridson-siggraph2007-curlnoise.pdf

float dP3dY(vec3 v) {
    float noise = 0.0;
    noise += 3. * cosf2(v.z * 1.8 + v.y * 3. - 194.58) + 4.5 * cosf2(v.z * 4.8 + v.y * 4.5 - 83.13) + 1.2 * cosf2(v.z * -7.0 + v.y * 1.2 -845.2) + 2.13 * cosf2(v.z * -5.0 + v.y * 2.13 - 762.185);
    noise += 5.4 * cosf2(v.x * -0.48 + v.y * 5.4 - 707.916) + 5.4 * cosf2(v.x * 2.56 + v.y * 5.4 + -482.348) + 2.4 * cosf2(v.x * 4.16 + v.y * 2.4 + 9.872) + 1.35 * cosf2(v.x * -4.16 + v.y * 1.35 - 476.747);
    return noise;
}

float dP2dZ(vec3 v) {
    return -0.48 * cosf2(v.z * -0.48 + v.x * 5.4 -125.796) + 2.56 * cosf2(v.z * 2.56 + v.x * 5.4 + 17.692) + 4.16 * cosf2(v.z * 4.16 + v.x * 2.4 + 150.512) -4.16 * cosf2(v.z * -4.16 + v.x * 1.35 - 222.137);
}

float dP1dZ(vec3 v) {
    float noise = 0.0;
    noise += 3. * cosf2(v.x * 1.8 + v.z * 3.) + 4.5 * cosf2(v.x * 4.8 + v.z * 4.5) + 1.2 * cosf2(v.x * -7.0 + v.z * 1.2) + 2.13 * cosf2(v.x * -5.0 + v.z * 2.13);
    noise += 5.4 * cosf2(v.y * -0.48 + v.z * 5.4) + 5.4 * cosf2(v.y * 2.56 + v.z * 5.4) + 2.4 * cosf2(v.y * 4.16 + v.z * 2.4) + 1.35 * cosf2(v.y * -4.16 + v.z * 1.35);
    return noise;
}

float dP3dX(vec3 v) {
    return -0.48 * cosf2(v.x * -0.48 + v.y * 5.4 - 707.916) + 2.56 * cosf2(v.x * 2.56 + v.y * 5.4 + -482.348) + 4.16 * cosf2(v.x * 4.16 + v.y * 2.4 + 9.872) -4.16 * cosf2(v.x * -4.16 + v.y * 1.35 - 476.747);
}

float dP2dX(vec3 v) {
    float noise = 0.0;
    noise += 3. * cosf2(v.y * 1.8 + v.x * 3. - 2.82) + 4.5 * cosf2(v.y * 4.8 + v.x * 4.5 + 74.37) + 1.2 * cosf2(v.y * -7.0 + v.x * 1.2 - 256.72) + 2.13 * cosf2(v.y * -5.0 + v.x * 2.13 - 207.683);
    noise += 5.4 * cosf2(v.z * -0.48 + v.x * 5.4 -125.796) + 5.4 * cosf2(v.z * 2.56 + v.x * 5.4 + 17.692) + 2.4 * cosf2(v.z * 4.16 + v.x * 2.4 + 150.512) + 1.35 * cosf2(v.z * -4.16 + v.x * 1.35 - 222.137);
    return noise;
}

float dP1dY(vec3 v) {
    return -0.48 * cosf2(v.y * -0.48 + v.z * 5.4) + 2.56 * cosf2(v.y * 2.56 + v.z * 5.4) +  4.16 * cosf2(v.y * 4.16 + v.z * 2.4) -4.16 * cosf2(v.y * -4.16 + v.z * 1.35);
}


vec3 curlNoise( vec3 p ) {

    //A sinf2 or cosf2 call is a trigonometric function, these functions are expensive in the GPU
    //the partial derivatives with approximations require to calculate the snoiseVec3 function 4 times.
    //The previous function evaluate the potentials that include 8 trigonometric functions each.
    //
    //This means that the potentials are evaluated 12 times (4 calls to snoiseVec3 that make 3 potential calls).
    //The whole process call 12 * 8 trigonometric functions, a total of 96 times.


    /*
    const float e = 1e-1;
    vec3 dx = vec3( e   , 0.0 , 0.0 );
    vec3 dy = vec3( 0.0 , e   , 0.0 );
    vec3 dz = vec3( 0.0 , 0.0 , e   );
    vec3 p0 = snoiseVec3(p);
    vec3 p_x1 = snoiseVec3( p + dx );
    vec3 p_y1 = snoiseVec3( p + dy );
    vec3 p_z1 = snoiseVec3( p + dz );
    float x = p_y1.z - p0.z - p_z1.y + p0.y;
    float y = p_z1.x - p0.x - p_x1.z + p0.z;
    float z = p_x1.y - p0.y - p_y1.x + p0.x;
    return normalize( vec3( x , y , z ));
    */


    //The noise that is used to define the potentials is based on analitic functions that are easy to derivate,
    //meaning that the analitic solution would provide a much faster approach with the same visual results.
    //
    //Usinf2g the analitic derivatives the algorithm does not require to evaluate snoiseVec3, instead it uses the
    //analitic partial derivatives from each potential on the corresponding axis, providing a total of
    //36 calls to trigonometric functions, making the analytic evaluation almost 3 times faster than the aproximation method.


    float x = dP3dY(p) - dP2dZ(p);
    float y = dP1dZ(p) - dP3dX(p);
    float z = dP2dX(p) - dP1dY(p);


    return normalize( vec3( x , y , z ));



}{@}depthvalue.fs{@}float getDepthValue(sampler2D tDepth, vec2 uv, float n, float f) {
    vec4 depth = texture2D(tDepth, uv);
    return (2.0 * n) / (f + n - depth.x * (f - n));
}

float getDepthValue(float z, float n, float f) {
    return (2.0 * n) / (f + n - z * (f - n));
}

float getEyeZ(float depth, float n, float f) {
    float z = depth * 2.0 - 1.0;
    return (2.0 * n * f) / (f + n - z * (f - n));
}

vec3 eyePosFromDepth(sampler2D tDepth, vec2 c, float n, float f) {
    float eyeZ = getEyeZ(texelFetch(tDepth, ivec2(gl_FragCoord.xy), 0).x, n, f);
    float x = ((1.0 - projectionMatrix[2][0]) / projectionMatrix[0][0]) - (2.0 * (c.x + 0.5) / (resolution.x * projectionMatrix[0][0]));
    float y = ((1.0 + projectionMatrix[2][1]) / projectionMatrix[1][1]) - (2.0 * (c.y + 0.5) / (resolution.y * projectionMatrix[1][1]));
    return vec3(vec2(x,y) * -eyeZ, -eyeZ);
}

vec3 eyePosFromDepth(float depth, float n, float f, vec2 c, bool linearDepth) {
    float eyeZ = linearDepth ? depth : getEyeZ(depth, n, f);
    float x = ((1.0 - projectionMatrix[2][0]) / projectionMatrix[0][0]) - (2.0 * (c.x + 0.5) / (resolution.x * projectionMatrix[0][0]));
    float y = ((1.0 + projectionMatrix[2][1]) / projectionMatrix[1][1]) - (2.0 * (c.y + 0.5) / (resolution.y * projectionMatrix[1][1]));
    return vec3(vec2(x,y) * -eyeZ, -eyeZ);
}

vec3 worldPosFromDepth(sampler2D tDepth) {
    float depth = texture2D(tDepth, vUv).r;
    float z = depth * 2.0 - 1.0;

    vec4 clipSpacePosition = vec4(vUv * 2.0 - 1.0, z, 1.0);
    vec4 viewSpacePosition = inverse(projectionMatrix) * clipSpacePosition;

    // Perspective division
    viewSpacePosition /= viewSpacePosition.w;

    vec4 worldSpacePosition = inverse(viewMatrix) * viewSpacePosition;

    return worldSpacePosition.xyz;
}
{@}eases.glsl{@}#ifndef PI
#define PI 3.141592653589793
#endif

#ifndef HALF_PI
#define HALF_PI 1.5707963267948966
#endif

float backInOut(float t) {
  float f = t < 0.5
    ? 2.0 * t
    : 1.0 - (2.0 * t - 1.0);

  float g = pow(f, 3.0) - f * sin(f * PI);

  return t < 0.5
    ? 0.5 * g
    : 0.5 * (1.0 - g) + 0.5;
}

float backIn(float t) {
  return pow(t, 3.0) - t * sin(t * PI);
}

float backOut(float t) {
  float f = 1.0 - t;
  return 1.0 - (pow(f, 3.0) - f * sin(f * PI));
}

float bounceOut(float t) {
  const float a = 4.0 / 11.0;
  const float b = 8.0 / 11.0;
  const float c = 9.0 / 10.0;

  const float ca = 4356.0 / 361.0;
  const float cb = 35442.0 / 1805.0;
  const float cc = 16061.0 / 1805.0;

  float t2 = t * t;

  return t < a
    ? 7.5625 * t2
    : t < b
      ? 9.075 * t2 - 9.9 * t + 3.4
      : t < c
        ? ca * t2 - cb * t + cc
        : 10.8 * t * t - 20.52 * t + 10.72;
}

float bounceIn(float t) {
  return 1.0 - bounceOut(1.0 - t);
}

float bounceInOut(float t) {
  return t < 0.5
    ? 0.5 * (1.0 - bounceOut(1.0 - t * 2.0))
    : 0.5 * bounceOut(t * 2.0 - 1.0) + 0.5;
}

float circularInOut(float t) {
  return t < 0.5
    ? 0.5 * (1.0 - sqrt(1.0 - 4.0 * t * t))
    : 0.5 * (sqrt((3.0 - 2.0 * t) * (2.0 * t - 1.0)) + 1.0);
}

float circularIn(float t) {
  return 1.0 - sqrt(1.0 - t * t);
}

float circularOut(float t) {
  return sqrt((2.0 - t) * t);
}

float cubicInOut(float t) {
  return t < 0.5
    ? 4.0 * t * t * t
    : 0.5 * -pow(2.0 - 2.0 * t, 3.0) + 1.0;
}

float cubicIn(float t) {
  return t * t * t;
}

float cubicOut(float t) {
  float f = t - 1.0;
  return f * f * f + 1.0;
}

float elasticInOut(float t) {
  return t < 0.5
    ? 0.5 * sin(+13.0 * HALF_PI * 2.0 * t) * pow(2.0, 10.0 * (2.0 * t - 1.0))
    : 0.5 * sin(-13.0 * HALF_PI * ((2.0 * t - 1.0) + 1.0)) * pow(2.0, -10.0 * (2.0 * t - 1.0)) + 1.0;
}

float elasticIn(float t) {
  return sin(13.0 * t * HALF_PI) * pow(2.0, 10.0 * (t - 1.0));
}

float elasticOut(float t) {
  return sin(-13.0 * (t + 1.0) * HALF_PI) * pow(2.0, -10.0 * t) + 1.0;
}

float expoInOut(float t) {
  return t == 0.0 || t == 1.0
    ? t
    : t < 0.5
      ? +0.5 * pow(2.0, (20.0 * t) - 10.0)
      : -0.5 * pow(2.0, 10.0 - (t * 20.0)) + 1.0;
}

float expoIn(float t) {
  return t == 0.0 ? t : pow(2.0, 10.0 * (t - 1.0));
}

float expoOut(float t) {
  return t == 1.0 ? t : 1.0 - pow(2.0, -10.0 * t);
}

float linear(float t) {
  return t;
}

float quadraticInOut(float t) {
  float p = 2.0 * t * t;
  return t < 0.5 ? p : -p + (4.0 * t) - 1.0;
}

float quadraticIn(float t) {
  return t * t;
}

float quadraticOut(float t) {
  return -t * (t - 2.0);
}

float quarticInOut(float t) {
  return t < 0.5
    ? +8.0 * pow(t, 4.0)
    : -8.0 * pow(1.0 - t, 4.0) + 1.0;
}

float quarticIn(float t) {
  return pow(t, 4.0);
}

float quarticOut(float t) {
  return pow(1.0 - t, 3.0) * (t - 1.0) + 1.0;
}

float qinticInOut(float t) {
  return t < 0.5
    ? +16.0 * pow(t, 5.0)
    : -0.5 * pow(2.0 * t - 2.0, 5.0) + 1.0;
}

float qinticIn(float t) {
  return pow(t, 5.0);
}

float qinticOut(float t) {
  return 1.0 - (pow(1.0 - t, 5.0));
}

float sineInOut(float t) {
  return -0.5 * (cos(PI * t) - 1.0);
}

float sineIn(float t) {
  return sin((t - 1.0) * HALF_PI) + 1.0;
}

float sineOut(float t) {
  return sin(t * HALF_PI);
}
{@}ColorMaterial.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 color;
uniform float alpha;

#!VARYINGS

#!SHADER: ColorMaterial.vs
void main() {
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: ColorMaterial.fs
void main() {
    gl_FragColor = vec4(color, alpha);
}{@}DebugCamera.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;

#!VARYINGS
varying vec3 vColor;

#!SHADER: DebugCamera.vs
void main() {
    vColor = mix(uColor, vec3(1.0, 0.0, 0.0), step(position.z, -0.1));
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: DebugCamera.fs
void main() {
    gl_FragColor = vec4(vColor, 1.0);
}{@}OcclusionMaterial.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 bbMin;
uniform vec3 bbMax;

#!VARYINGS

#!SHADER: Vertex.vs
void main() {
    vec3 pos = position;
    pos *= bbMax - bbMin;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment.fs
void main() {
    gl_FragColor = vec4(1.0);
}{@}ScreenQuad.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;

#!VARYINGS

#!SHADER: ScreenQuad.vs
void main() {
    gl_Position = vec4(position, 1.0);
}

#!SHADER: ScreenQuad.fs
void main() {
    gl_FragColor = texture2D(tMap, gl_FragCoord.xy / resolution);
    gl_FragColor.a = 1.0;
}{@}ScreenQuadVR.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uEye;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex

vec2 scaleUV(vec2 uv, vec2 scale, vec2 origin) {
    vec2 st = uv - origin;
    st /= scale;
    return st + origin;
}

void main() {
    vUv = scaleUV(uv, vec2(2.0, 1.0), vec2(0.0)) - vec2(uEye, 0.0);
    gl_Position = vec4(position, 1.0);
}

#!SHADER: Fragment
void main() {
    gl_FragColor = texture2D(tMap, vUv);
}{@}TestMaterial.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform float alpha;

#!VARYINGS
varying vec3 vNormal;

#!SHADER: TestMaterial.vs
void main() {
    vec3 pos = position;
    vNormal = normalMatrix * normal;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: TestMaterial.fs
void main() {
    gl_FragColor = vec4(vNormal, 1.0);
}{@}TextureMaterial.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;

#!VARYINGS
varying vec2 vUv;

#!SHADER: TextureMaterial.vs
void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: TextureMaterial.fs
void main() {
    gl_FragColor = texture2D(tMap, vUv);
    gl_FragColor.rgb /= gl_FragColor.a;
}{@}BlitPass.fs{@}void main() {
    gl_FragColor = texture2D(tDiffuse, vUv);
    gl_FragColor.a = 1.0;
}{@}NukePass.vs{@}varying vec2 vUv;

void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}{@}ShadowDepth.glsl{@}#!ATTRIBUTES

#!UNIFORMS

#!VARYINGS

#!SHADER: ShadowDepth.vs
void main() {
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: ShadowDepth.fs
void main() {
    gl_FragColor = vec4(vec3(gl_FragCoord.x), 1.0);
}{@}instance.vs{@}vec3 transformNormal(vec3 n, vec4 orientation) {
    vec3 nn = n + 2.0 * cross(orientation.xyz, cross(orientation.xyz, n) + orientation.w * n);
    return nn;
}

vec3 transformPosition(vec3 position, vec3 offset, vec3 scale, vec4 orientation) {
    vec3 _pos = position;
    _pos *= scale;

    _pos = _pos + 2.0 * cross(orientation.xyz, cross(orientation.xyz, _pos) + orientation.w * _pos);
    _pos += offset;
    return _pos;
}

vec3 transformPosition(vec3 position, vec3 offset, vec4 orientation) {
    vec3 _pos = position;

    _pos = _pos + 2.0 * cross(orientation.xyz, cross(orientation.xyz, _pos) + orientation.w * _pos);
    _pos += offset;
    return _pos;
}

vec3 transformPosition(vec3 position, vec3 offset, float scale, vec4 orientation) {
    return transformPosition(position, offset, vec3(scale), orientation);
}

vec3 transformPosition(vec3 position, vec3 offset) {
    return position + offset;
}

vec3 transformPosition(vec3 position, vec3 offset, float scale) {
    vec3 pos = position * scale;
    return pos + offset;
}

vec3 transformPosition(vec3 position, vec3 offset, vec3 scale) {
    vec3 pos = position * scale;
    return pos + offset;
}{@}lights.fs{@}vec3 worldLight(vec3 pos, vec3 vpos) {
    vec4 mvPos = modelViewMatrix * vec4(vpos, 1.0);
    vec4 worldPosition = viewMatrix * vec4(pos, 1.0);
    return worldPosition.xyz - mvPos.xyz;
}{@}lights.vs{@}vec3 worldLight(vec3 pos) {
    vec4 mvPos = modelViewMatrix * vec4(position, 1.0);
    vec4 worldPosition = viewMatrix * vec4(pos, 1.0);
    return worldPosition.xyz - mvPos.xyz;
}

vec3 worldLight(vec3 lightPos, vec3 localPos) {
    vec4 mvPos = modelViewMatrix * vec4(localPos, 1.0);
    vec4 worldPosition = viewMatrix * vec4(lightPos, 1.0);
    return worldPosition.xyz - mvPos.xyz;
}{@}shadows.fs{@}#define PI2 6.2831853072
#define PI 3.141592653589793

#define MAX_PCSS_SAMPLES 17
vec2 poissonDisk[MAX_PCSS_SAMPLES];

struct PCSShadowConfig {
    int sampleCount;
    int ringCount;
    float lightWorldSize;
    float lightFrustumWidth;
    float nearPlane;
};

PCSShadowConfig defaultPCSSShadowConfig() {
    PCSShadowConfig config;
    config.sampleCount = 10;
    config.ringCount = 11;
    config.lightWorldSize = 0.3;
    config.lightFrustumWidth = 6.75;
    config.nearPlane = 6.5;
    return config;
}

bool frustumTest(vec3 coords) {
    return coords.x >= 0.0 && coords.x <= 1.0 && coords.y >= 0.0 && coords.y <= 1.0 && coords.z <= 1.0;
}

float rand(float n){return fract(sin(n) * 43758.5453123);}
highp float rand( const in vec2 uv ) {
    const highp float a = 12.9898, b = 78.233, c = 43758.5453;
    highp float dt = dot( uv.xy, vec2( a, b ) ), sn = mod( dt, PI );
    return fract( sin( sn ) * c );
}

void initPoissonSamples(const in vec2 randomSeed, PCSShadowConfig config) {
    float angleStep = PI2 * float(config.ringCount) / float(config.sampleCount);
    float invSampleCount = 1.0 / float(config.sampleCount);
    float angle = rand(randomSeed) * PI2;
    float radius = invSampleCount;
    float radiusStep = radius;
    
    for(int i = 0; i < MAX_PCSS_SAMPLES; i ++ ) {
        if( i > config.sampleCount ) {
            break;
        }
        poissonDisk[i] = vec2(cos(angle), sin(angle)) * pow(radius, 0.75);
        radius += radiusStep;
        angle += angleStep;
    }
}

float penumbraSize(const in float zReceiver, const in float zBlocker) {
    return (zReceiver - zBlocker) / zBlocker;
}

float findBlocker(sampler2D shadowMap, const in vec2 uv, const in float zReceiver, PCSShadowConfig config) {
    // This uses similar triangles to compute what
    // area of the shadow map we should search
    float lightSizeUV = config.lightWorldSize / config.lightFrustumWidth;
    float searchRadius = lightSizeUV * (zReceiver - config.nearPlane) / zReceiver;
    float blockerDepthSum = 0.0;
    int numBlockers = 0;
    
    for(int i = 0; i < MAX_PCSS_SAMPLES; i ++ ) {
        if( i > config.sampleCount ) {
            break;
        }
        float shadowMapDepth = texture2D(shadowMap, uv + poissonDisk[i] * searchRadius).r;
        if (shadowMapDepth < zReceiver) {
            blockerDepthSum += shadowMapDepth;
            numBlockers ++ ;
        }
    }
    
    if (numBlockers == 0)return -1.0;
    
    return blockerDepthSum / float(numBlockers);
}

float pcfFilter(sampler2D shadowMap, vec2 uv, float zReceiver, float filterRadius, PCSShadowConfig config) {
    float sum = 0.0;
    float depth;
    int numSamples = config.sampleCount;
    for(int i = 0; i < MAX_PCSS_SAMPLES; i ++ ) {
        if( i > numSamples ) {
            break;
        }
        depth = texture2D(shadowMap, uv + poissonDisk[i] * filterRadius).r;
        if (zReceiver <= depth) sum += 1.0;
    }
    for(int i = 0; i < MAX_PCSS_SAMPLES; i ++ ) {
        if( i > numSamples ) {
            break;
        }
        depth = texture2D(shadowMap, uv + -poissonDisk[i].yx * filterRadius).r;
        if (zReceiver <= depth) sum += 1.0;
    }
    return sum / (2.0 * float(numSamples));
}

float PCSS(sampler2D shadowMap, vec3 coords, PCSShadowConfig config) {
    vec2 uv = coords.xy;
    float zReceiver = coords.z; // Assumed to be eye-space z in this code
    
    initPoissonSamples(uv, config);
    
    float avgBlockerDepth = findBlocker(shadowMap, uv, zReceiver, config);
    if (avgBlockerDepth == -1.0)return 1.0; 

    float penumbraRatio = penumbraSize(zReceiver, avgBlockerDepth);
    float lightSizeUV = config.lightWorldSize / config.lightFrustumWidth;
    float filterRadius = penumbraRatio * lightSizeUV * config.nearPlane / zReceiver;    

    return pcfFilter(shadowMap, uv, zReceiver, filterRadius, config);
}

float shadowLookupPCSS(sampler2D map, vec3 coords, float size, float compare, vec3 wpos, PCSShadowConfig config) {
    float shadow = 1.0;
    bool frustumTest = frustumTest(coords);
    if (frustumTest) {
        shadow = PCSS(map, coords, config);
    }
    return clamp(shadow, 0.0, 1.0);
}

float shadowCompare(sampler2D map, vec2 coords, float compare) {
    return step(compare, texture2D(map, coords).r);
}

float shadowLerp(sampler2D map, vec2 coords, float compare, float size) {
    const vec2 offset = vec2(0.0, 1.0);

    vec2 texelSize = vec2(1.0) / size;
    vec2 centroidUV = floor(coords * size + 0.5) / size;

    float lb = shadowCompare(map, centroidUV + texelSize * offset.xx, compare);
    float lt = shadowCompare(map, centroidUV + texelSize * offset.xy, compare);
    float rb = shadowCompare(map, centroidUV + texelSize * offset.yx, compare);
    float rt = shadowCompare(map, centroidUV + texelSize * offset.yy, compare);

    vec2 f = fract( coords * size + 0.5 );

    float a = mix( lb, lt, f.y );
    float b = mix( rb, rt, f.y );
    float c = mix( a, b, f.x );

    return c;
}

float srange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    float oldRange = oldMax - oldMin;
    float newRange = newMax - newMin;
    return (((oldValue - oldMin) * newRange) / oldRange) + newMin;
}

float shadowrandom(vec3 vin) {
    vec3 v = vin * 0.1;
    float t = v.z * 0.3;
    v.y *= 0.8;
    float noise = 0.0;
    float s = 0.5;
    noise += srange(sin(v.x * 0.9 / s + t * 10.0) + sin(v.x * 2.4 / s + t * 15.0) + sin(v.x * -3.5 / s + t * 4.0) + sin(v.x * -2.5 / s + t * 7.1), -1.0, 1.0, -0.3, 0.3);
    noise += srange(sin(v.y * -0.3 / s + t * 18.0) + sin(v.y * 1.6 / s + t * 18.0) + sin(v.y * 2.6 / s + t * 8.0) + sin(v.y * -2.6 / s + t * 4.5), -1.0, 1.0, -0.3, 0.3);
    return noise;
}

float shadowLookup(sampler2D map, vec3 coords, float size, float compare, vec3 wpos) {
    float shadow = 1.0;

    #if defined(SHADOW_MAPS)
    bool frustumTest = coords.x >= 0.0 && coords.x <= 1.0 && coords.y >= 0.0 && coords.y <= 1.0 && coords.z <= 1.0;
    if (frustumTest) {
        
        vec2 texelSize = vec2(1.0) / size;

        float dx0 = -texelSize.x;
        float dy0 = -texelSize.y;
        float dx1 = +texelSize.x;
        float dy1 = +texelSize.y;

        float rnoise = shadowrandom(wpos) * 0.00015;
        dx0 += rnoise;
        dy0 -= rnoise;
        dx1 += rnoise;
        dy1 -= rnoise;

        #if defined(SHADOWS_MED)
        shadow += shadowCompare(map, coords.xy + vec2(0.0, dy0), compare);
        //        shadow += shadowCompare(map, coords.xy + vec2(dx1, dy0), compare);
        shadow += shadowCompare(map, coords.xy + vec2(dx0, 0.0), compare);
        shadow += shadowCompare(map, coords.xy, compare);
        shadow += shadowCompare(map, coords.xy + vec2(dx1, 0.0), compare);
        //        shadow += shadowCompare(map, coords.xy + vec2(dx0, dy1), compare);
        shadow += shadowCompare(map, coords.xy + vec2(0.0, dy1), compare);
        shadow /= 5.0;

        #elif defined(SHADOWS_HIGH)
        shadow = shadowLerp(map, coords.xy + vec2(dx0, dy0), compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(0.0, dy0), compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(dx1, dy0), compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(dx0, 0.0), compare, size);
        shadow += shadowLerp(map, coords.xy, compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(dx1, 0.0), compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(dx0, dy1), compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(0.0, dy1), compare, size);
        shadow += shadowLerp(map, coords.xy + vec2(dx1, dy1), compare, size);
        shadow /= 9.0;

        #else
        shadow = shadowCompare(map, coords.xy, compare);
        #endif
    }

        #endif

    return clamp(shadow, 0.0, 1.0);
}

#test !!window.Metal
vec3 transformShadowLight(vec3 pos, vec3 vpos, mat4 mvMatrix, mat4 viewMatrix) {
    vec4 mvPos = mvMatrix * vec4(vpos, 1.0);
    vec4 worldPosition = viewMatrix * vec4(pos, 1.0);
    return normalize(worldPosition.xyz - mvPos.xyz);
}

float getShadow(vec3 pos, vec3 normal, float bias, Uniforms uniforms, GlobalUniforms globalUniforms, sampler2D shadowMap) {
    float shadow = 1.0;
    #if defined(SHADOW_MAPS)

    vec4 shadowMapCoords;
    vec3 coords;
    float lookup;

    for (int i = 0; i < SHADOW_COUNT; i++) {
        shadowMapCoords = uniforms.shadowMatrix[i] * vec4(pos, 1.0);
        coords = (shadowMapCoords.xyz / shadowMapCoords.w) * vec3(0.5) + vec3(0.5);
        lookup = shadowLookup(shadowMap, coords, uniforms.shadowSize[i], coords.z - bias, pos);
        lookup += mix(1.0 - step(0.002, dot(transformShadowLight(uniforms.shadowLightPos[i], pos, uniforms.modelViewMatrix, globalUniforms.viewMatrix), normal)), 0.0, step(999.0, normal.x));
        shadow *= clamp(lookup, 0.0, 1.0);
    }

    #endif
    return shadow;
}

float getShadow(vec3 pos, vec3 normal, Uniforms uniforms, GlobalUniforms globalUniforms, sampler2D shadowMap) {
    return getShadow(pos, normal, 0.0, uniforms, globalUniforms, shadowMap);
}

float getShadow(vec3 pos, float bias, Uniforms uniforms, GlobalUniforms globalUniforms, sampler2D shadowMap) {
    return getShadow(pos, vec3(99999.0), bias, uniforms, globalUniforms, shadowMap);
}

float getShadow(vec3 pos, Uniforms uniforms, GlobalUniforms globalUniforms, sampler2D shadowMap) {
    return getShadow(pos, vec3(99999.0), 0.0, uniforms, globalUniforms, shadowMap);
}

float getShadow(vec3 pos, vec3 normal) {
    return 1.0;
}

float getShadow(vec3 pos, float bias) {
    return 1.0;
}

float getShadow(vec3 pos) {
    return 1.0;
}

float getShadowPCSS(vec3 pos, vec3 normal, Uniforms uniforms, GlobalUniforms globalUniforms, sampler2D shadowMap, PCSShadowConfig config) {
    float shadow = 1.0;
    #if defined(SHADOW_MAPS)

    vec4 shadowMapCoords;
    vec3 coords;
    float lookup;

    for (int i = 0; i < SHADOW_COUNT; i++) {
        shadowMapCoords = uniforms.shadowMatrix[i] * vec4(pos, 1.0);
        coords = (shadowMapCoords.xyz / shadowMapCoords.w) * vec3(0.5) + vec3(0.5);
        lookup = shadowLookupPCSS(shadowMap, coords, uniforms.shadowSize[i], coords.z - bias, pos);
        lookup += mix(1.0 - step(0.002, dot(transformShadowLight(uniforms.shadowLightPos[i], pos, uniforms.modelViewMatrix, globalUniforms.viewMatrix), normal)), 0.0, step(999.0, normal.x));
        shadow *= clamp(lookup, 0.0, 1.0);
    }

    #endif
    return shadow;
}

float getShadowPCSS(vec3 pos, vec3 normal, Uniforms uniforms, GlobalUniforms globalUniforms, sampler2D shadowMap) {
    PCSShadowConfig config = defaultPCSSShadowConfig();
    return getShadowPCSS(pos, normal, bias, config);
}

#endtest

#test !window.Metal
vec3 transformShadowLight(vec3 pos, vec3 vpos) {
    vec4 mvPos = modelViewMatrix * vec4(vpos, 1.0);
    vec4 worldPosition = viewMatrix * vec4(pos, 1.0);
    return normalize(worldPosition.xyz - mvPos.xyz);
}

float getShadow(vec3 pos, vec3 normal, float bias) {

    float shadow = 1.0;
    #if defined(SHADOW_MAPS)

    vec4 shadowMapCoords;
    vec3 coords;
    float lookup;

    #pragma unroll_loop
    for (int i = 0; i < SHADOW_COUNT; i++) {
        shadowMapCoords = shadowMatrix[i] * vec4(pos, 1.0);
        coords = (shadowMapCoords.xyz / shadowMapCoords.w) * vec3(0.5) + vec3(0.5);
        lookup = shadowLookup(shadowMap[i], coords, shadowSize[i], coords.z - bias, pos);        
        lookup += mix(1.0 - step(0.002, dot(transformShadowLight(shadowLightPos[i], pos), normal)), 0.0, step(999.0, normal.x));
        shadow *= clamp(lookup, 0.0, 1.0);
    }
    #endif
    return shadow;
}

float getShadow(vec3 pos, vec3 normal) {
    return getShadow(pos, normal, 0.0);
}

float getShadow(vec3 pos, float bias) {
    return getShadow(pos, vec3(99999.0), bias);
}

float getShadow(vec3 pos) {
    return getShadow(pos, vec3(99999.0), 0.0);
}

float getShadowPCSS(vec3 pos, vec3 normal, float bias, PCSShadowConfig config) {    
    float shadow = 1.0;
    #if defined(SHADOW_MAPS)

    vec4 shadowMapCoords;
    vec3 coords;
    float lookup;

    #pragma unroll_loop
    for (int i = 0; i < SHADOW_COUNT; i++) {
        shadowMapCoords = shadowMatrix[i] * vec4(pos, 1.0);
        coords = (shadowMapCoords.xyz / shadowMapCoords.w) * vec3(0.5) + vec3(0.5);
        lookup = shadowLookupPCSS(shadowMap[i], coords, shadowSize[i], coords.z - bias, pos, config);
        lookup += mix(1.0 - step(0.002, dot(transformShadowLight(shadowLightPos[i], pos), normal)), 0.0, step(999.0, normal.x));
        shadow *= clamp(lookup, 0.0, 1.0);
    }
    #endif
    
    return shadow;
}

float getShadowPCSS(vec3 pos, vec3 normal, float bias) {
    PCSShadowConfig config = defaultPCSSShadowConfig();
    return getShadowPCSS(pos, normal, bias, config);
}
#endtest{@}fresnel.glsl{@}float getFresnel(vec3 normal, vec3 viewDir, float power) {
    float d = dot(normalize(normal), normalize(viewDir));
    return 1.0 - pow(abs(d), power);
}

float getFresnel(float inIOR, float outIOR, vec3 normal, vec3 viewDir) {
    float ro = (inIOR - outIOR) / (inIOR + outIOR);
    float d = dot(normalize(normal), normalize(viewDir));
    return ro + (1. - ro) * pow((1. - d), 5.);
}


//viewDir = -vec3(modelViewMatrix * vec4(position, 1.0));{@}FXAA.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMask;

#!VARYINGS
varying vec2 v_rgbNW;
varying vec2 v_rgbNE;
varying vec2 v_rgbSW;
varying vec2 v_rgbSE;
varying vec2 v_rgbM;

#!SHADER: FXAA.vs

varying vec2 vUv;

void main() {
    vUv = uv;

    vec2 fragCoord = uv * resolution;
    vec2 inverseVP = 1.0 / resolution.xy;
    v_rgbNW = (fragCoord + vec2(-1.0, -1.0)) * inverseVP;
    v_rgbNE = (fragCoord + vec2(1.0, -1.0)) * inverseVP;
    v_rgbSW = (fragCoord + vec2(-1.0, 1.0)) * inverseVP;
    v_rgbSE = (fragCoord + vec2(1.0, 1.0)) * inverseVP;
    v_rgbM = vec2(fragCoord * inverseVP);

    gl_Position = vec4(position, 1.0);
}

#!SHADER: FXAA.fs

#require(conditionals.glsl)

#ifndef FXAA_REDUCE_MIN
    #define FXAA_REDUCE_MIN   (1.0/ 128.0)
#endif
#ifndef FXAA_REDUCE_MUL
    #define FXAA_REDUCE_MUL   (1.0 / 8.0)
#endif
#ifndef FXAA_SPAN_MAX
    #define FXAA_SPAN_MAX     8.0
#endif

vec4 fxaa(sampler2D tex, vec2 fragCoord, vec2 resolution,
            vec2 v_rgbNW, vec2 v_rgbNE,
            vec2 v_rgbSW, vec2 v_rgbSE,
            vec2 v_rgbM) {
    vec4 color;
    mediump vec2 inverseVP = vec2(1.0 / resolution.x, 1.0 / resolution.y);
    vec3 rgbNW = texture2D(tex, v_rgbNW).xyz;
    vec3 rgbNE = texture2D(tex, v_rgbNE).xyz;
    vec3 rgbSW = texture2D(tex, v_rgbSW).xyz;
    vec3 rgbSE = texture2D(tex, v_rgbSE).xyz;
    vec4 texColor = texture2D(tex, v_rgbM);
    vec3 rgbM  = texColor.xyz;
    vec3 luma = vec3(0.299, 0.587, 0.114);
    float lumaNW = dot(rgbNW, luma);
    float lumaNE = dot(rgbNE, luma);
    float lumaSW = dot(rgbSW, luma);
    float lumaSE = dot(rgbSE, luma);
    float lumaM  = dot(rgbM,  luma);
    float lumaMin = min(lumaM, min(min(lumaNW, lumaNE), min(lumaSW, lumaSE)));
    float lumaMax = max(lumaM, max(max(lumaNW, lumaNE), max(lumaSW, lumaSE)));

    mediump vec2 dir;
    dir.x = -((lumaNW + lumaNE) - (lumaSW + lumaSE));
    dir.y =  ((lumaNW + lumaSW) - (lumaNE + lumaSE));

    float dirReduce = max((lumaNW + lumaNE + lumaSW + lumaSE) *
                          (0.25 * FXAA_REDUCE_MUL), FXAA_REDUCE_MIN);

    float rcpDirMin = 1.0 / (min(abs(dir.x), abs(dir.y)) + dirReduce);
    dir = min(vec2(FXAA_SPAN_MAX, FXAA_SPAN_MAX),
              max(vec2(-FXAA_SPAN_MAX, -FXAA_SPAN_MAX),
              dir * rcpDirMin)) * inverseVP;

    vec3 rgbA = 0.5 * (
        texture2D(tex, fragCoord * inverseVP + dir * (1.0 / 3.0 - 0.5)).xyz +
        texture2D(tex, fragCoord * inverseVP + dir * (2.0 / 3.0 - 0.5)).xyz);
    vec3 rgbB = rgbA * 0.5 + 0.25 * (
        texture2D(tex, fragCoord * inverseVP + dir * -0.5).xyz +
        texture2D(tex, fragCoord * inverseVP + dir * 0.5).xyz);

    float lumaB = dot(rgbB, luma);

    color = vec4(rgbB, texColor.a);
    color = mix(color, vec4(rgbA, texColor.a), when_lt(lumaB, lumaMin));
    color = mix(color, vec4(rgbA, texColor.a), when_gt(lumaB, lumaMax));

    return color;
}

void main() {
    vec2 fragCoord = vUv * resolution;
    float mask = texture2D(tMask, vUv).r;
    if (mask < 0.5) {
        gl_FragColor = fxaa(tDiffuse, fragCoord, resolution, v_rgbNW, v_rgbNE, v_rgbSW, v_rgbSE, v_rgbM);
    } else {
        gl_FragColor = texture2D(tDiffuse, vUv);
    }
    gl_FragColor.a = 1.0;
}
{@}glscreenprojection.glsl{@}vec2 frag_coord(vec4 glPos) {
    return ((glPos.xyz / glPos.w) * 0.5 + 0.5).xy;
}

vec2 getProjection(vec3 pos, mat4 projMatrix) {
    vec4 mvpPos = projMatrix * vec4(pos, 1.0);
    return frag_coord(mvpPos);
}

void applyNormal(inout vec3 pos, mat4 projNormalMatrix) {
    vec3 transformed = vec3(projNormalMatrix * vec4(pos, 0.0));
    pos = transformed;
}{@}DefaultText.glsl{@}#!ATTRIBUTES

#!UNIFORMS

uniform sampler2D tMap;
uniform vec3 uColor;
uniform float uAlpha;

#!VARYINGS

varying vec2 vUv;

#!SHADER: DefaultText.vs

void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: DefaultText.fs

#require(msdf.glsl)

void main() {
    float alpha = msdf(tMap, vUv);

    gl_FragColor.rgb = uColor;
    gl_FragColor.a = alpha * uAlpha;
}
{@}msdf.glsl{@}float msdf(vec3 tex, vec2 uv, bool discards) {
    // TODO: fallback for fwidth for webgl1 (need to enable ext)
    float signedDist = max(min(tex.r, tex.g), min(max(tex.r, tex.g), tex.b)) - 0.5;
    float d = fwidth(signedDist);
    float alpha = smoothstep(-d, d, signedDist);
    if (alpha < 0.01 && discards) discard;
    return alpha;
}

float msdf(sampler2D tMap, vec2 uv, bool discards) {
    vec3 tex = texture2D(tMap, uv).rgb;
    return msdf( tex, uv, discards );
}

float msdf(vec3 tex, vec2 uv) {
    return msdf( tex, uv, true );
}

float msdf(sampler2D tMap, vec2 uv) {
    vec3 tex = texture2D(tMap, uv).rgb;
    return msdf( tex, uv );
}

float strokemsdf(sampler2D tMap, vec2 uv, float stroke, float padding) {
    vec3 tex = texture2D(tMap, uv).rgb;
    float signedDist = max(min(tex.r, tex.g), min(max(tex.r, tex.g), tex.b)) - 0.5;
    float t = stroke;
    float alpha = smoothstep(-t, -t + padding, signedDist) * smoothstep(t, t - padding, signedDist);
    return alpha;
}
{@}GLUIBatch.glsl{@}#!ATTRIBUTES
attribute vec3 offset;
attribute vec2 scale;
attribute float rotation;
//attributes

#!UNIFORMS
uniform sampler2D tMap;
uniform vec3 uColor;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;
//varyings

#!SHADER: Vertex

mat4 rotationMatrix(vec3 axis, float angle) {
    axis = normalize(axis);
    float s = sin(angle);
    float c = cos(angle);
    float oc = 1.0 - c;

    return mat4(oc * axis.x * axis.x + c,           oc * axis.x * axis.y - axis.z * s,  oc * axis.z * axis.x + axis.y * s,  0.0,
    oc * axis.x * axis.y + axis.z * s,  oc * axis.y * axis.y + c,           oc * axis.y * axis.z - axis.x * s,  0.0,
    oc * axis.z * axis.x - axis.y * s,  oc * axis.y * axis.z + axis.x * s,  oc * axis.z * axis.z + c,           0.0,
    0.0,                                0.0,                                0.0,                                1.0);
}

void main() {
    vUv = uv;
    //vdefines

    vec3 pos = vec3(rotationMatrix(vec3(0.0, 0.0, 1.0), rotation) * vec4(position, 1.0));
    pos.xy *= scale;
    pos.xyz += offset;

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
void main() {
    gl_FragColor = vec4(1.0);
}{@}GLUIBatchText.glsl{@}#!ATTRIBUTES
attribute vec3 offset;
attribute vec2 scale;
attribute float rotation;
//attributes

#!UNIFORMS
uniform sampler2D tMap;
uniform vec3 uColor;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;
//varyings

#!SHADER: Vertex

mat4 lrotationMatrix(vec3 axis, float angle) {
    axis = normalize(axis);
    float s = sin(angle);
    float c = cos(angle);
    float oc = 1.0 - c;

    return mat4(oc * axis.x * axis.x + c,           oc * axis.x * axis.y - axis.z * s,  oc * axis.z * axis.x + axis.y * s,  0.0,
    oc * axis.x * axis.y + axis.z * s,  oc * axis.y * axis.y + c,           oc * axis.y * axis.z - axis.x * s,  0.0,
    oc * axis.z * axis.x - axis.y * s,  oc * axis.y * axis.z + axis.x * s,  oc * axis.z * axis.z + c,           0.0,
    0.0,                                0.0,                                0.0,                                1.0);
}

void main() {
    vUv = uv;
    //vdefines

    vec3 pos = vec3(lrotationMatrix(vec3(0.0, 0.0, 1.0), rotation) * vec4(position, 1.0));

    //custommain

    pos.xy *= scale;
    pos += offset;

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

#require(msdf.glsl)

void main() {
    float alpha = msdf(tMap, vUv);

    gl_FragColor.rgb = v_uColor;
    gl_FragColor.a = alpha * v_uAlpha;
}
{@}GLUIColor.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: GLUIColor.vs
void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: GLUIColor.fs
void main() {
    vec2 uv = vUv;
    vec3 uvColor = vec3(uv, 1.0);
    gl_FragColor = vec4(mix(uColor, uvColor, 0.0), uAlpha);
}{@}GLUIObject.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: GLUIObject.vs
void main() {
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: GLUIObject.fs
void main() {
    gl_FragColor = texture2D(tMap, vUv);
    gl_FragColor.a *= uAlpha;
}{@}gluimask.fs{@}uniform vec4 uMaskValues;

#require(range.glsl)

vec2 getMaskUV() {
    vec2 ores = gl_FragCoord.xy / resolution;
    vec2 uv;
    uv.x = range(ores.x, uMaskValues.x, uMaskValues.z, 0.0, 1.0);
    uv.y = 1.0 - range(1.0 - ores.y, uMaskValues.y, uMaskValues.w, 0.0, 1.0);
    return uv;
}{@}matcap.vs{@}vec2 reflectMatcap(vec3 position, mat4 modelMatrix, vec3 normal) {
    vec3 worldNormal = mat3(modelMatrix[0].xyz, modelMatrix[1].xyz, modelMatrix[2].xyz) * normal;
    vec3 worldPos = (modelMatrix * vec4(position, 1.0)).xyz;
    vec3 viewDir = normalize(cameraPosition - worldPos);
    vec3 x = normalize(vec3(viewDir.z, 0.0, - viewDir.x));
    vec3 y = cross(viewDir, x);
    vec2 uv = vec2(dot(x, worldNormal), dot(y, worldNormal)) * 0.495 + 0.5; // 0.495 to remove artifacts caused by undersized matcap disks
    return uv;
}

vec2 reflectMatcap(vec3 worldPos, vec3 worldNormal) {
    vec3 viewDir = normalize(cameraPosition - worldPos);
    vec3 x = normalize(vec3(viewDir.z, 0.0, - viewDir.x));
    vec3 y = cross(viewDir, x);
    vec2 uv = vec2(dot(x, worldNormal), dot(y, worldNormal)) * 0.495 + 0.5; // 0.495 to remove artifacts caused by undersized matcap disks
    return uv;
}
{@}PBR.glsl{@}#!ATTRIBUTES

#!UNIFORMS

#!VARYINGS

#!SHADER: Vertex

#require(pbr.vs)

void main() {
    vec3 pos = position;
    setupPBR(pos);

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

#require(pbr.fs)

void main() {
    gl_FragColor = getPBR();
}
{@}pbr.fs{@}uniform sampler2D tBaseColor;
uniform sampler2D tMRO;
uniform sampler2D tNormal;
uniform sampler2D tLUT;

uniform sampler2D tEnvDiffuse;
uniform sampler2D tEnvSpecular;
uniform vec2 uEnvOffset;

uniform sampler2D tLightmap;
uniform float uUseLightmap;
uniform float uLightmapIntensity;
uniform float uUseLinearOutput;

uniform vec3 uTint;
uniform vec2 uTiling;
uniform vec2 uOffset;
uniform vec4 uMRON;
uniform vec3 uEnv;

uniform float uHDR;

varying vec2 vUv;
varying vec2 vUv2;
varying vec3 vV;
varying vec3 vWorldNormal;

vec3 unpackNormalPBR( vec3 eye_pos, vec3 surf_norm, sampler2D normal_map, float intensity, float scale, vec2 uv ) {
    vec3 q0 = dFdx( eye_pos.xyz );
    vec3 q1 = dFdy( eye_pos.xyz );
    vec2 st0 = dFdx( uv.st );
    vec2 st1 = dFdy( uv.st );

    vec3 N = normalize(surf_norm);

    vec3 q1perp = cross( q1, N );
    vec3 q0perp = cross( N, q0 );

    vec3 T = q1perp * st0.x + q0perp * st1.x;
    vec3 B = q1perp * st0.y + q0perp * st1.y;

    float det = max( dot( T, T ), dot( B, B ) );
    float scalefactor = ( det == 0.0 ) ? 0.0 : inversesqrt( det );

    vec3 mapN = texture2D( normal_map, uv * scale ).xyz * 2.0 - 1.0;
    mapN.xy *= intensity;

    return normalize( T * ( mapN.x * scalefactor ) + B * ( mapN.y * scalefactor ) + N * mapN.z );
}

const vec2 INV_ATAN = vec2(0.1591, 0.3183);
const float LN2 = 0.6931472;
const float ENV_LODS = 7.0;
const float PI = 3.14159;

struct PBRConfig {
    float reflection;
    float clearcoat;
    vec3 color;
    vec3 lightColor;
    vec3 envReflection;
    bool overrideMRO;
    bool overrideENV;
    vec3 mro;
    vec3 env;
};

vec3 fresnelSphericalGaussianRoughness(float cosTheta, vec3 F0, float roughness) {
    return F0 + (max(vec3(1.0 - roughness), F0) - F0) * pow(2.0, (-5.55473 * cosTheta - 6.98316) * cosTheta);
}

vec2 sampleSphericalMap(vec3 v) {
    vec3 normalizedV = normalize(v);
    vec2 uv = vec2(0.5 + atan(normalizedV.z, normalizedV.x) / (2.0 * PI), 0.5 + asin(normalizedV.y) / PI);
    return uv;
}

vec4 SRGBtoLinear(vec4 srgb) {
    vec3 linOut = pow(srgb.xyz, vec3(2.2));
    return vec4(linOut, srgb.w);
}

vec3 linearToSRGB(vec3 color) {
    return pow(color, vec3(0.4545454545454545));
}

vec4 linearToSRGB(vec4 color) {
    return vec4(pow(color.rgb, vec3(0.4545454545454545)), 1.0);
}

vec4 RGBMToLinear(vec4 value) {
    float maxRange = 6.0;
    return vec4(value.xyz * value.w * maxRange, 1.0);
}

vec4 autoToLinear(vec4 texel, float uHDR) {
    vec4 color = RGBMToLinear(texel);
    if (uHDR < 0.001) { color = SRGBtoLinear(texel); }
    return color;
}

vec3 uncharted2Tonemap(vec3 x) {
    float A = 0.15;
    float B = 0.50;
    float C = 0.10;
    float D = 0.20;
    float E = 0.02;
    float F = 0.30;
    return ((x * (A * x + C * B) + D * E) / (x * (A * x + B) + D * F)) - E / F;
}

vec3 uncharted2(vec3 color) {
    const float W = 11.2;
    float exposureBias = 2.0;
    vec3 curr = uncharted2Tonemap(exposureBias * color);
    vec3 whiteScale = 1.0 / uncharted2Tonemap(vec3(W));
    return curr * whiteScale;
}

vec4 getIBLContribution(float NdV, vec4 baseColor, vec4 MRO, vec3 R, vec3 V, vec3 N, sampler2D tLUT, sampler2D tEnvDiffuse, sampler2D tEnvSpecular, PBRConfig config) {
    float metallic = clamp(MRO.x + uMRON.x - 1.0, 0.0, 1.0);
    float roughness = clamp(MRO.y + uMRON.y - 1.0, 0.0, 1.0);
    float ao = mix(1.0, MRO.z, uMRON.z);
    vec3 env = uEnv;

    if (config.overrideMRO) {
        metallic = config.mro.x;
        roughness = config.mro.y;
        ao = config.mro.z;
    }

    if (config.overrideENV) {
        env = config.env;
    }

    vec2 lutUV = vec2(NdV, roughness);
    vec2 diffuseUV = sampleSphericalMap(N);

    vec3 brdf = SRGBtoLinear(texture2D(tLUT, lutUV)).rgb;
    vec3 diffuse = autoToLinear( texture2D(tEnvDiffuse, diffuseUV + uEnvOffset ), uHDR).rgb;

    vec3 lightmap = vec3(1.0);

    if (uUseLightmap > 0.0) {
        lightmap = texture2D(tLightmap, vUv2).rgb;
        lightmap.rgb = pow(lightmap.rgb, vec3(2.2)) * uLightmapIntensity;
        diffuse.rgb *= lightmap.rgb;
    }

    diffuse *= baseColor.rgb;

    float level = floor(roughness * ENV_LODS);
    vec2 specUV = sampleSphericalMap(R);

    specUV.y /= 2.0;
    specUV /= pow(2.0, level);
    specUV.y += 1.0 - exp(-LN2 * level);

    vec3 specular = autoToLinear(texture2D(tEnvSpecular, specUV + uEnvOffset), uHDR).rgb;

    // fake stronger specular highlight
    specular += pow(specular, vec3(2.2)) * env.y;

    if (uUseLightmap > 0.0) {
        specular *= lightmap;
    }

    vec3 F0 = vec3(0.04);
    F0 = mix(F0, baseColor.rgb, metallic);

    vec3 F = fresnelSphericalGaussianRoughness(NdV, F0, roughness);

    vec3 diffuseContrib = 1.0 - F;
    specular = specular.rgb * (F * brdf.x + brdf.y);

    diffuseContrib *= 1.0 - metallic;

    float alpha = baseColor.a;

    return vec4((diffuseContrib * diffuse + specular + (config.envReflection*0.01)) * ao * env.x, alpha);
}

vec3 getNormal() {
    vec3 N = vWorldNormal;
    vec3 V = normalize(vV);
    return unpackNormalPBR(V, N, tNormal, uMRON.w, 1.0, vUv).xyz;
}

vec4 getPBR(vec3 baseColor, PBRConfig config) {
    vec3 N = vWorldNormal;
    vec3 V = normalize(vV);
    vec3 worldNormal = getNormal();
    vec3 R = reflect(V, worldNormal);
    float NdV = abs(dot(worldNormal, V));
    vec4 baseColor4 = SRGBtoLinear(vec4(baseColor, 1.0));

    vec4 MRO = texture2D(tMRO, vUv);
    vec4 color = getIBLContribution(NdV, baseColor4, MRO, R, V, worldNormal, tLUT, tEnvDiffuse, tEnvSpecular, config);

    if (uUseLinearOutput < 0.5) {
        color.rgb = uncharted2(color.rgb);
        color = linearToSRGB(color);
    }

    return color;
}

vec4 getPBR(vec3 baseColor) {
    PBRConfig config;
    return getPBR(baseColor, config);
}

vec4 getPBR() {
    vec4 baseColor = texture2D(tBaseColor, vUv);
    vec4 color = getPBR(baseColor.rgb * uTint);
    color.a *= baseColor.a;
    return color;
}
{@}pbr.vs{@}attribute vec2 uv2;

uniform sampler2D tBaseColor;
uniform vec2 uTiling;
uniform vec2 uOffset;

varying vec2 vUv;
varying vec2 vUv2;
varying vec3 vNormal;
varying vec3 vWorldNormal;
varying vec3 vV;

void setupPBR(vec3 p0) { //inlinemain
    vUv = uv * uTiling + uOffset;
    vUv2 = uv2;
    vec4 worldPos = modelMatrix * vec4(p0, 1.0);
    vV = worldPos.xyz - cameraPosition;
    vNormal = normalMatrix * normal;
    vWorldNormal = mat3(modelMatrix[0].xyz, modelMatrix[1].xyz, modelMatrix[2].xyz) * normal;
}

void setupPBR(vec3 p0, vec3 n) {
    vUv = uv * uTiling + uOffset;
    vUv2 = uv2;
    vec4 worldPos = modelMatrix * vec4(p0, 1.0);
    vV = worldPos.xyz - cameraPosition;
    vNormal = normalMatrix * n;
    vWorldNormal = mat3(modelMatrix[0].xyz, modelMatrix[1].xyz, modelMatrix[2].xyz) * n;
}
{@}radialblur.fs{@}vec3 radialBlur( sampler2D map, vec2 uv, float size, vec2 resolution, float quality ) {
    vec3 color = vec3(0.);

    const float pi2 = 3.141596 * 2.0;
    const float direction = 8.0;

    vec2 radius = size / resolution;
    float test = 1.0;

    for ( float d = 0.0; d < pi2 ; d += pi2 / direction ) {
        vec2 t = radius * vec2( cos(d), sin(d));
        for ( float i = 1.0; i <= 100.0; i += 1.0 ) {
            if (i >= quality) break;
            color += texture2D( map, uv + t * i / quality ).rgb ;
        }
    }

    return color / ( quality * direction);
}

vec3 radialBlur( sampler2D map, vec2 uv, float size, float quality ) {
    vec3 color = vec3(0.);

    const float pi2 = 3.141596 * 2.0;
    const float direction = 8.0;

    vec2 radius = size / vec2(1024.0);
    float test = 1.0;
    float samples = 0.0;

    for ( float d = 0.0; d < pi2 ; d += pi2 / direction ) {
        vec2 t = radius * vec2( cos(d), sin(d));
        for ( float i = 1.0; i <= 100.0; i += 1.0 ) {
            if (i >= quality) break;
            color += texture2D( map, uv + t * i / quality ).rgb ;
            samples += 1.0;
        }
    }

    return color / samples;
}
{@}range.glsl{@}

float range(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    vec3 sub = vec3(oldValue, newMax, oldMax) - vec3(oldMin, newMin, oldMin);
    return sub.x * sub.y / sub.z + newMin;
}

vec2 range(vec2 oldValue, vec2 oldMin, vec2 oldMax, vec2 newMin, vec2 newMax) {
    vec2 oldRange = oldMax - oldMin;
    vec2 newRange = newMax - newMin;
    vec2 val = oldValue - oldMin;
    return val * newRange / oldRange + newMin;
}

vec3 range(vec3 oldValue, vec3 oldMin, vec3 oldMax, vec3 newMin, vec3 newMax) {
    vec3 oldRange = oldMax - oldMin;
    vec3 newRange = newMax - newMin;
    vec3 val = oldValue - oldMin;
    return val * newRange / oldRange + newMin;
}

float crange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    return clamp(range(oldValue, oldMin, oldMax, newMin, newMax), min(newMin, newMax), max(newMin, newMax));
}

vec2 crange(vec2 oldValue, vec2 oldMin, vec2 oldMax, vec2 newMin, vec2 newMax) {
    return clamp(range(oldValue, oldMin, oldMax, newMin, newMax), min(newMin, newMax), max(newMin, newMax));
}

vec3 crange(vec3 oldValue, vec3 oldMin, vec3 oldMax, vec3 newMin, vec3 newMax) {
    return clamp(range(oldValue, oldMin, oldMax, newMin, newMax), min(newMin, newMax), max(newMin, newMax));
}

float rangeTransition(float t, float x, float padding) {
    float transition = crange(t, 0.0, 1.0, -padding, 1.0 + padding);
    return crange(x, transition - padding, transition + padding, 1.0, 0.0);
}
{@}rgb2hsv.fs{@}vec3 rgb2hsv(vec3 c) {
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
    
    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}{@}rgbshift.fs{@}vec4 getRGB(sampler2D tDiffuse, vec2 uv, float angle, float amount) {
    vec2 offset = vec2(cos(angle), sin(angle)) * amount;
    vec4 r = texture2D(tDiffuse, uv + offset);
    vec4 g = texture2D(tDiffuse, uv);
    vec4 b = texture2D(tDiffuse, uv - offset);
    return vec4(r.r, g.g, b.b, g.a);
}{@}rotation.glsl{@}mat4 rotationMatrix(vec3 axis, float angle) {
    axis = normalize(axis);
    float s = sin(angle);
    float c = cos(angle);
    float oc = 1.0 - c;

    return mat4(oc * axis.x * axis.x + c,           oc * axis.x * axis.y - axis.z * s,  oc * axis.z * axis.x + axis.y * s,  0.0,
                oc * axis.x * axis.y + axis.z * s,  oc * axis.y * axis.y + c,           oc * axis.y * axis.z - axis.x * s,  0.0,
                oc * axis.z * axis.x - axis.y * s,  oc * axis.y * axis.z + axis.x * s,  oc * axis.z * axis.z + c,           0.0,
                0.0,                                0.0,                                0.0,                                1.0);
}


mat2 rotationMatrix(float angle) {
  float s = sin(angle);
  float c = cos(angle);
  return mat2(c, -s, s, c);
}{@}simplenoise.glsl{@}float getNoise(vec2 uv, float time) {
    float x = uv.x * uv.y * time * 1000.0;
    x = mod(x, 13.0) * mod(x, 123.0);
    float dx = mod(x, 0.01);
    float amount = clamp(0.1 + dx * 100.0, 0.0, 1.0);
    return amount;
}

#test Device.mobile
float sinf(float x) {
    x*=0.159155;
    x-=floor(x);
    float xx=x*x;
    float y=-6.87897;
    y=y*xx+33.7755;
    y=y*xx-72.5257;
    y=y*xx+80.5874;
    y=y*xx-41.2408;
    y=y*xx+6.28077;
    return x*y;
}
#endtest

#test !Device.mobile
    #define sinf sin
#endtest

highp float getRandom(vec2 co) {
    highp float a = 12.9898;
    highp float b = 78.233;
    highp float c = 43758.5453;
    highp float dt = dot(co.xy, vec2(a, b));
    highp float sn = mod(dt, 3.14);
    return fract(sin(sn) * c);
}

float cnoise(vec3 v) {
    float t = v.z * 0.3;
    v.y *= 0.8;
    float noise = 0.0;
    float s = 0.5;
    noise += (sinf(v.x * 0.9 / s + t * 10.0) + sinf(v.x * 2.4 / s + t * 15.0) + sinf(v.x * -3.5 / s + t * 4.0) + sinf(v.x * -2.5 / s + t * 7.1)) * 0.3;
    noise += (sinf(v.y * -0.3 / s + t * 18.0) + sinf(v.y * 1.6 / s + t * 18.0) + sinf(v.y * 2.6 / s + t * 8.0) + sinf(v.y * -2.6 / s + t * 4.5)) * 0.3;
    return noise;
}

float cnoise(vec2 v) {
    float t = v.x * 0.3;
    v.y *= 0.8;
    float noise = 0.0;
    float s = 0.5;
    noise += (sinf(v.x * 0.9 / s + t * 10.0) + sinf(v.x * 2.4 / s + t * 15.0) + sinf(v.x * -3.5 / s + t * 4.0) + sinf(v.x * -2.5 / s + t * 7.1)) * 0.3;
    noise += (sinf(v.y * -0.3 / s + t * 18.0) + sinf(v.y * 1.6 / s + t * 18.0) + sinf(v.y * 2.6 / s + t * 8.0) + sinf(v.y * -2.6 / s + t * 4.5)) * 0.3;
    return noise;
}

float fbm(vec3 x, int octaves) {
    float v = 0.0;
    float a = 0.5;
    vec3 shift = vec3(100);

    for (int i = 0; i < 10; ++i) {
        if (i >= octaves){ break; }

        v += a * cnoise(x);
        x = x * 2.0 + shift;
        a *= 0.5;
    }

    return v;
}

float fbm(vec2 x, int octaves) {
    float v = 0.0;
    float a = 0.5;
    vec2 shift = vec2(100);
    mat2 rot = mat2(cos(0.5), sin(0.5), -sin(0.5), cos(0.50));

    for (int i = 0; i < 10; ++i) {
        if (i >= octaves){ break; }

        v += a * cnoise(x);
        x = rot * x * 2.0 + shift;
        a *= 0.5;
    }

    return v;
}
{@}transformUV.glsl{@}vec2 translateUV(vec2 uv, vec2 translate) {
    return uv - translate;
}

vec2 rotateUV(vec2 uv, float r, vec2 origin) {
    float c = cos(r);
    float s = sin(r);
    mat2 m = mat2(c, -s,
                  s, c);
    vec2 st = uv - origin;
    st = m * st;
    return st + origin;
}

vec2 scaleUV(vec2 uv, vec2 scale, vec2 origin) {
    vec2 st = uv - origin;
    st /= scale;
    return st + origin;
}

vec2 rotateUV(vec2 uv, float r) {
    return rotateUV(uv, r, vec2(0.5));
}

vec2 scaleUV(vec2 uv, vec2 scale) {
    return scaleUV(uv, scale, vec2(0.5));
}

vec2 skewUV(vec2 st, vec2 skew) {
    return st + st.gr * skew;
}

vec2 transformUV(vec2 uv, float a[9]) {

    // Array consists of the following
    // 0 translate.x
    // 1 translate.y
    // 2 skew.x
    // 3 skew.y
    // 4 rotate
    // 5 scale.x
    // 6 scale.y
    // 7 origin.x
    // 8 origin.y

    vec2 st = uv;

    //Translate
    st -= vec2(a[0], a[1]);

    //Skew
    st = st + st.gr * vec2(a[2], a[3]);

    //Rotate
    st = rotateUV(st, a[4], vec2(a[7], a[8]));

    //Scale
    st = scaleUV(st, vec2(a[5], a[6]), vec2(a[7], a[8]));

    return st;
}{@}tridither.glsl{@}//https://www.shadertoy.com/view/4djSRW
float hash12(vec2 p)
{
    vec3 p3  = fract(vec3(p.xyx) * .1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

vec3 hash32(vec2 p)
{
    vec3 p3 = fract(vec3(p.xyx) * vec3(.1031, .1030, .0973));
    p3 += dot(p3, p3.yxz+33.33);
    return fract((p3.xxy+p3.yzz)*p3.zyx);
}

vec4 hash42(vec2 p)
{
    vec4 p4 = fract(vec4(p.xyxy) * vec4(.1031, .1030, .0973, .1099));
    p4 += dot(p4, p4.wzxy+33.33);
    return fract((p4.xxyz+p4.yzzw)*p4.zywx);

}

float dither1(in float color, in vec2 coord, in float time) {
    float noiseA = hash12(coord + fract(time + 1781.0));
    float noiseB = hash12(coord + fract(time + 1130.0));
    return color + ((noiseA + (noiseB - 1.0)) / 255.0);
}

vec3 dither3(in vec3 color, in vec2 coord, in float time) {
    vec2 seed = coord;
    vec3 noiseA = hash32(seed + fract(time) * 1300.0);
    vec3 noiseB = hash32(seed.yx + fract(time) * 1854.0);
    return color + ((noiseA + (noiseB - 1.0)) / 255.0);
}

vec4 dither4(in vec4 color, in vec2 coord, in float time) {
    vec2 seed = coord;
    vec4 noiseA = hash42(seed + fract(time + 1015.0));
    vec4 noiseB = hash42(seed + fract(time + 1543.0));
    return color + ((noiseA + (noiseB - 1.0)) / 255.0);
}
{@}AmbientParticleShader.glsl{@}#!ATTRIBUTES
attribute vec4 random;

#!UNIFORMS
uniform sampler2D tBokeh;
uniform sampler2D tPos;
uniform sampler2D tLightTexture;
uniform sampler2D tPointColor;
uniform sampler2D tMap;
uniform vec3 uLightPos;
uniform vec3 uTint;
uniform float DPR;
uniform float uScroll;

#!VARYINGS
varying vec3 vLightColor;
varying vec3 vPos;
varying vec4 vRandom;
varying float vDist;
varying float vRipple;
varying vec3 vWorldPos;
varying vec2 vUv;

#!SHADER: Vertex

const float PI = 3.1415926535897932384626433832795;

#require(range.glsl)
#require(simplenoise.glsl)

void main() {
    vec4 decodedPos = texture2D(tPos, position.xy);
    vec3 pos = decodedPos.xyz;

    vec3 worldPos = vec3(modelMatrix * vec4(pos, 1.0));
    vWorldPos = worldPos;

    float scale = crange(random.z,0.0,1.0,0.1,0.7);

    float dist = length(worldPos - cameraPosition);
    vDist = dist;
    vUv = uv;
    vPos = pos;
    vRandom = random;

vec4 mvPosition = modelViewMatrix * vec4(pos, 1.0);
    gl_PointSize = scale * (0.01) * DPR * (2000.0 / length(mvPosition.xyz));
    gl_Position = projectionMatrix * mvPosition;
}

#!SHADER: Fragment

#require(range.glsl)
#require(transformUV.glsl)
#require(simplenoise.glsl)
#require(rgb2hsv.fs)
#require(blendmodes.glsl)
#require(shadows.fs)

void main() {
    vec2 uv = vec2(gl_PointCoord.x, 1.0 - gl_PointCoord.y);
    //if (length(uv-0.5) > 0.5) discard;

    vec3 bokeh = texture2D(tBokeh,uv).rgb;
    if (bokeh.r < 0.1) discard;

    vec3 color = vec3(1.0,0.8, 0.4);
    color = mix(color,vRandom.rgb,0.4);
    color *= 2.0;

    float sparkle = 0.4 + crange(sin(time * 2.4 + vRandom.y * 20.0),-1.0,1.0,0.0,1.0);
    float sparkle2 = crange(sin(time * 6.4 + vRandom.x * 20.0),-1.0,1.0,0.4,5.0);

    float op = bokeh.r;
    op *= sparkle;
    if (vRandom.z < 0.1) {
        op *= sparkle2;
        color *= sparkle2;
    }

    color *= 0.25;
    color *= smoothstep(0.0, 4.0, vDist);

    #drawbuffer Color gl_FragColor = vec4(vec3(color), op);
    #drawbuffer Refraction gl_FragColor = vec4(vec3(color), op);
}{@}InteriorFBRShader.glsl{@}#!ATTRIBUTES
attribute vec3 vdata;

#!UNIFORMS
uniform sampler2D tMap;
uniform sampler2D tMapR;
uniform float uTile;
uniform float uExp;
uniform float uFBRMix;
uniform float uBakeStrength; //js {value: 0.6}
uniform vec2 uUVR; //js {value: new Vector2(1.0, 1.0)}

#!VARYINGS
varying vec3 vPos;
varying vec3 vData;

#!SHADER: Vertex

#require(fbr.vs)

void main() {
    vec3 pos = position;
    setupFBR(pos);
    vPos = pos;
    vData = vdata;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

#require(fbr.fs)
#require(shadows.fs)
#require(range.glsl)

vec3 toneMap(vec3 color, float exposure, float highlight, float blacks, float blacksThreshold) {
    color *= pow(2.0, exposure);

    float luminance = dot(color, vec3(0.2126, 0.7152, 0.0722));

    float highlightCrush = mix(1.0, 0.0, highlight);
    color = mix(color, color*0.5, clamp((luminance - 1.0) * highlightCrush, 0.0, 1.0));

    float shadowFactor = smoothstep(0.0, blacksThreshold, luminance);
    color = mix(color, mix(vec3(0.0), color, 1.0-blacks), 1.0 - shadowFactor);

    return color;
}

void main() {
    vec3 baseColor = texture2D(tMap, vUv).rgb;
    vec3 color = getFBR(baseColor*uColor, vUv*uTile);
    color = mix(baseColor*uColor,color,uFBRMix);

    
    float wave = crange(sin(0.6*time + vPos.y*0.4),-0.2,1.0,0.0,1.0);
    color = mix(color*0.95, color,wave);

    color.rgb = toneMap(color.rgb, uExp, 0.0, 0.4, 0.8);

    gl_FragColor = vec4(color, 1.0);
}{@}MetalPBRShader.glsl{@}#!ATTRIBUTES
attribute vec3 vdata;

#!UNIFORMS
uniform sampler2D tMap;
uniform sampler2D tMRO;

uniform float uBrightness;
uniform float uTile;
uniform float uExp;
uniform float uPBRMix;
uniform float uPBRMixR;
uniform float uFresnelAngle;
uniform float uFresnelStrength;
uniform vec3 uFresnelColor;
uniform vec3 uColor;

#!VARYINGS
varying vec3 vPos;
varying vec3 vData;
varying vec3 vNormal;
varying vec3 vViewDir;

#!SHADER: Vertex
#require(pbr.vs)


void main() {
    vec3 pos = position;

    setupPBR(pos);
    vPos = pos;
    vData = vdata;
    vNormal = normalize(normalMatrix * normal);
    vViewDir = -vec3(modelViewMatrix * vec4(position, 1.0));

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

#require(pbr.fs)
#require(shadows.fs)
#require(range.glsl)
#require(fresnel.glsl)

vec3 toneMap(vec3 color, float exposure, float highlight, float blacks, float blacksThreshold) {
    color *= pow(2.0, exposure);

    float luminance = dot(color, vec3(0.2126, 0.7152, 0.0722));

    float highlightCrush = mix(1.0, 0.0, highlight);
    color = mix(color, color*0.5, clamp((luminance - 1.0) * highlightCrush, 0.0, 1.0));

    float shadowFactor = smoothstep(0.0, blacksThreshold, luminance);
    color = mix(color, mix(vec3(0.0), color, 1.0-blacks), 1.0 - shadowFactor);

    return color;
}

vec3 saturation(vec3 rgb, float adjustment) {
    const vec3 W = vec3(0.2126729, 0.7151522, 0.0721750);
    vec3 intensity = vec3(dot(rgb, W));
    return mix(intensity, rgb, adjustment);
}



void main() {
    vec3 baseColor = texture2D(tMap, vUv).rgb;

    vec4 pbr = getPBR(baseColor*uColor*uBrightness);
    vec3 color = linearToSRGB(pbr).rgb;
    vec3 mro = texture2D(tMRO,vUv).rgb;
    vec3 baked = baseColor*uColor;
    baked *= mro.z;
    baked = saturation(baked,1.3)*1.2;
    color = mix(baked,color,uPBRMix);
    float op = 1.0;


    float fresnel = getFresnel(vNormal, vViewDir, uFresnelAngle);
    float normalBias = clamp(vNormal.y * 0.5 + 0.5, 0.25, 1.0);
    fresnel *= normalBias;
    fresnel = crange(fresnel, 0.1,1.0,0.0,1.0);
    color = mix(color, uFresnelColor*1.9, fresnel * uFresnelStrength);

    color.rgb = toneMap(color.rgb, uExp, 0.0, 0.7, 0.9);

    if (uUseLightmap > 0.5) {
        color *= texture2D(tLightmap, vUv).rgb;
    }

    gl_FragColor = vec4(color, op);
}{@}MovecComposite.fs{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tDiffuse;
uniform sampler2D tLightStreak;
uniform sampler2D tVolumetricBlur;
uniform vec2 uContrastGlobal;

uniform float uExposure; //js {value: 0.0}
uniform float uHighlight; //js {value: 1.0}
uniform float uBlacks; //js {value: 0.0}
uniform float uBlacksThreshold; //js {value: 0.2}
uniform float uHue; //js {value: 0.0}
uniform float uSat; //js {value: 1.0}

uniform sampler2D tSSAO;
uniform float uSSAOStrength;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    gl_Position = vec4(position, 1.0);
    vUv = uv;
}

#!SHADER: Fragment
#require(simplenoise.glsl)
#require(blendmodes.glsl)
#require(UnrealBloom.fs)
#require(rgbshift.fs)
#require(contrast.glsl)
#require(range.glsl)
#require(radialblur.fs)
#require(eases.glsl)

// Constants for ACES
const mat3 ACESInputTransform = mat3(
    0.613132, 0.339538, 0.047417,
    0.070124, 0.916394, 0.013452,
    0.020588, 0.109575, 0.869785
);

const mat3 ACESOutputTransform = mat3(
    1.704859, -0.621716, -0.083299,
    -0.130077, 1.140736, -0.010560,
    -0.023964, -0.128976, 1.153014
);

vec3 saturation(vec3 rgb, float adjustment) {
    const vec3 W = vec3(0.2126729, 0.7151522, 0.0721750);
    vec3 intensity = vec3(dot(rgb, W));
    return mix(intensity, rgb, adjustment);
}
vec3 hue(vec3 color, float hue) {
    const vec3 k = vec3(0.57735, 0.57735, 0.57735);
    float cosAngle = cos(hue);
    return vec3(color * cosAngle + cross(k, color) * sin(hue) + k * dot(k, color) * (1.0 - cosAngle));
}

vec3 sRGBToACES(vec3 color) {
    return ACESInputTransform * color;
}
vec3 ACESToOutputColor(vec3 color) {
    return ACESOutputTransform * color;
}
vec3 toneMap(vec3 color, float exposure, float highlight, float blacks, float blacksThreshold) {
    color *= pow(2.0, exposure);

    float luminance = dot(color, vec3(0.2126, 0.7152, 0.0722));

    float highlightCrush = mix(1.0, 0.0, highlight);
    color = mix(color, color*0.5, clamp((luminance - 1.0) * highlightCrush, 0.0, 1.0));

    float shadowFactor = smoothstep(0.0, blacksThreshold, luminance);
    color = mix(color, mix(vec3(0.0), color, 1.0-blacks), 1.0 - shadowFactor);

    return color;
}

void main() {
    vec3 color = getRGB(tDiffuse, vUv, 0.2, 0.0007).rgb;
    vec3 lightStreak = pow(texture2D(tLightStreak, vUv).rgb, vec3(1.25));
    vec3 bloom = getUnrealBloom(vUv);
    vec3 noise = vec3(getNoise(vUv,time));
    float ssao = texture2D(tSSAO, vUv).r;

    // COLOR FUNCTIONS
    color = blendScreen(color, lightStreak * 1.5);
    color = blendOverlay(color, noise, 0.06);
    color *= (ssao * uSSAOStrength) + (1.0 - uSSAOStrength);
    color += bloom;
    color = toneMap(color, uExposure, uHighlight, uBlacks, uBlacksThreshold);


    color = hue(color, uHue);
    color = saturation(color, uSat);

    vec2 st = vUv;
    vec3 blurredColor = radialBlur(tDiffuse,st,10.0,10.0).rgb;
    float vignette = sineOut(crange(length(st - vec2(0.5)), 0.0, 1.0, 1.0, 2.1));
    float bright = 0.15*sineOut(crange(length(st - vec2(0.5)), 0.0, 1.0, 1.4, 2.3));

    color = mix(blurredColor, color, vignette);
    vec3 darkerColor = saturation(color,10.0)*0.21;
    //color *= vignette;
    color = mix(darkerColor, color, vignette);
    color *= crange(bright,0.0,1.0,0.8,4.0);

    gl_FragColor = vec4(vec3(color), 1.0);
}
{@}ProductVFX.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tDiffuse;
uniform sampler2D tLightStreak;
uniform sampler2D tVolumetricBlur;
uniform float uTransition;
uniform float uScroll;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    gl_Position = vec4(position, 1.0);
    vUv = uv;
}

#!SHADER: Fragment
#require(UnrealBloom.fs)
#require(simplenoise.glsl)
#require(blendmodes.glsl)
#require(rgbshift.fs)
#require(eases.glsl)
#require(range.glsl)
#require(contrast.glsl)
#require(radialblur.fs)
#require(transformUV.glsl)
#require(hexagons.fs)
#require(rgb2hsv.fs)

float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

vec4 sharpen(in sampler2D tex, in vec2 coords, in vec2 renderSize) {
    float dx = 1.0 / renderSize.x;
    float dy = 1.0 / renderSize.y;
    vec4 sum = vec4(0.0);
    sum += -1. * texture2D(tex, coords + vec2( -1.0 * dx , 0.0 * dy));
    sum += -1. * texture2D(tex, coords + vec2( 0.0 * dx , -1.0 * dy));
    sum += 5. * texture2D(tex, coords + vec2( 0.0 * dx , 0.0 * dy));
    sum += -1. * texture2D(tex, coords + vec2( 0.0 * dx , 1.0 * dy));
    sum += -1. * texture2D(tex, coords + vec2( 1.0 * dx , 0.0 * dy));
    return sum;
}

void main() {
    vec2 uv = scaleUV(vUv, vec2(1.0 - (1.0-uTransition) * 0.6));

    vec2 hexagonUV = scaleUV(vUv, vec2(1.0, resolution.x/resolution.y));
    hexagonUV.y -= uScroll * 0.2;

    vec3 hexagons = getHexagons(hexagonUV, max(resolution.y, resolution.x)/60.0);

    vec3 color = sharpen(tDiffuse, uv, resolution * 2.0).rgb;
    //color = mix(color, texture2D(tDiffuse, uv).rgb, 0.5);

    vec2 st = uv;
    vec3 blurredColor = radialBlur(tDiffuse,st,3.0,5.0).rgb;
    float vignette = sineOut(crange(length(st - vec2(0.5)), 0.0, 1.0, 1.0, 2.8));
    color = mix(blurredColor*0.9, color, vignette);

    color += pow(getUnrealBloom(uv), vec3(1.2));
    color = adjustContrast(color, 1.05, 0.92);
    color = blendOverlay(color, vec3(getNoise(vUv,time)), 0.05);

    float transition = uTransition;//0.5 + sin(time) * 0.5;
    vec2 revealUV = uv;
    //revealUV.y -= smoothstep(0.0, 1.0, abs(revealUV.x-0.5)) * 0.25 * smoothstep(1.0, 0.5, transition);
    float reveal = smoothstep(transition-0.15, transition+0.15, 1.0-revealUV.y);
    reveal *= smoothstep(1.0, 0.6, transition);
    //color = mix(color, vec3(0.95), reveal);
    //color *= mix(1.0, 1.4, smoothstep(0.5, 0.0, abs(reveal-0.5)));

    vec2 borderUV = vUv;//rotateUV(vUv, radians(5.0) * (1.0-uTransition));
    float border = step(0.5 * uTransition - 0.008 * pow(uTransition, 3.0), abs(borderUV.x-0.5 + hexagons.z * 0.0015));
    border = max(border, step(0.5 * pow(uTransition, 3.5) - 0.008 * pow(uTransition, 3.0) * (resolution.x/resolution.y), abs(borderUV.y-0.5 + hexagons.z * 0.0015)));

    vec3 borderColor = rgb2hsv(vec3(1.0, 0.4, 0.2));
    borderColor.x += cnoise(vUv*0.5 + time * 0.1 + uTransition * 2.5) * 0.03;
    borderColor = hsv2rgb(borderColor);
    color = mix(color, borderColor, border);

    border = step(1.6 * uTransition, abs(borderUV.x-0.5));
    border = max(border, step(1.1 * pow(uTransition, 3.5) * (resolution.x/resolution.y), abs(borderUV.y-0.5)));
    color = mix(color, vec3(0.95), border);

    gl_FragColor = vec4(color, 1.0);
}
{@}ProductShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2DArray tNormals;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex

#require(fbr.vs)

void main() {
    vUv = uv;
    setupFBR(position);
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

#require(motionvector.fs)
#require(fbr.fs)
#require(range.glsl)

void main() {
    vec4 color = getMVColor(vUv);
    vec3 normal = getMVNormal(tNormals, vUv);
    vec3 fbr = getFBR(color.rgb, normal);

    float op = crange(color.a,0.4,1.0,0.0,1.0);
    if (op < 0.1) discard;
    gl_FragColor = vec4(fbr, op);
}
{@}SpeedShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform vec3 uColor;
uniform float uTime;
uniform float uLength;

#!VARYINGS
varying vec2 vUv;
varying vec3 vPos;

#!SHADER: Vertex

void main() {
    vUv = uv;
    vec3 pos = position;
    vPos = pos;

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment


void main() {
    vec3 color = uColor;

    float t = uTime * 10.0 + time * 0.01;

    t -= vPos.y * 10.0;

    vec2 uv = vUv;
    uv.y += uv.x * 1.0 + time * 0.02;
    uv.x += vPos.y * 1.2 + time * 0.02;

    float velocity = min(0.4, abs(uLength * 50.0));
    velocity *= smoothstep(0.4, 0.2, abs(vPos.y));

    float lines = fract(-uv.x * 4.0 + t);
    lines *= fract(-uv.y * 1.2);

    color *= pow(lines, mix(10.0, 100.0, abs(sin(t * 5.0 - vPos.y * 20.0 + uv.x * 5.0))) * mix(1.0, 0.0, velocity));
    color *= abs(sin(time * 0.5 + vPos.y * 5.0 - uv.x * 3.0));
    color *= mix(0.5, 4.0, velocity);
    
    if (length(color) < 0.01) discard;

    gl_FragColor = vec4(color, 1.0);
}
{@}hexagons.fs{@}#define S(r,v) smoothstep(9./resolution.y,0.,abs(v-(r)))
const vec2 s = vec2(1, 1.7320508);
const vec3 baseCol = vec3(1.0);
const float borderThickness = .03;

float calcHexDistance(vec2 p) {
    p = abs(p);
    return max(dot(p, s * .5), p.x);
}

float random(vec2 co) {
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

vec4 sround(vec4 i) {
    return floor(i + 0.5);
}

vec4 calcHexInfo(vec2 uv) {
    vec4 hexCenter = sround(vec4(uv, uv - vec2(.5, 1.)) / s.xyxy);
    vec4 offset = vec4(uv - hexCenter.xy * s, uv - (hexCenter.zw + .5) * s);
    return dot(offset.xy, offset.xy) < dot(offset.zw, offset.zw) ? vec4(offset.xy, hexCenter.xy) : vec4(offset.zw, hexCenter.zw);
}

vec3 getHexagons(vec2 uv, float hexScale) {
    vec2 hexUV = uv * hexScale;
    float distort = 0.1;
    float distortion2 = 1.0 + smoothstep(0.1, 1.1, length(uv - 0.5));
    vec4 hexInfo = calcHexInfo(hexUV);

    float totalDist = calcHexDistance(hexInfo.xy) + borderThickness;
    float rand = random(hexInfo.zw);
    float angle = atan(hexInfo.y, hexInfo.x) + rand * 5. + time;
    float sinOffset = sin(time * 0.1 + rand * 8.);
    float aa = 5. / resolution.y;

    vec3 hexagons = vec3(0.0);
    hexagons.x = 1.0-smoothstep(.51, .51 - aa, totalDist);
    hexagons.y = pow(1. - max(0., .5 - totalDist), 10.) * 1.5;
    hexagons.z = sinOffset;

    return hexagons;
}{@}GameboyShader.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2DArray tNormals;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex

#require(fbr.vs)

void main() {
    vUv = uv;
    setupFBR(position);
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment

#require(motionvector.fs)
#require(fbr.fs)

void main() {
    vec4 color = getMVColor(vUv);
    vec3 normal = getMVNormal(tNormals, vUv);
    vec3 fbr = getFBR(color.rgb, normal);
    gl_FragColor = vec4(fbr, color.a);
}
{@}AntimatterSpawn.fs{@}uniform float uMaxCount;
uniform float uSetup;
uniform float decay;
uniform vec2 decayRandom;
uniform sampler2D tLife;
uniform sampler2D tAttribs;
uniform float HZ;

#require(range.glsl)

void main() {
    vec2 uv = vUv;
    #test !window.Metal
    uv = gl_FragCoord.xy / fSize;
    #endtest

    vec4 data = texture2D(tInput, uv);

    if (vUv.x + vUv.y * fSize > uMaxCount) {
        gl_FragColor = vec4(9999.0);
        return;
    }

    vec4 life = texture2D(tLife, uv);
    vec4 random = texture2D(tAttribs, uv);
    if (life.x > 0.5) {
        data.xyz = life.yzw;
        data.x -= 999.0;
    } else {
        if (data.x < -500.0) {
            data.x = 1.0;
        } else {
            data.x -= 0.005 * decay * crange(random.w, 0.0, 1.0, decayRandom.x, decayRandom.y) * HZ;
        }
    }

    if (uSetup > 0.5) {
        data = vec4(0.0);
    }

    gl_FragColor = data;
}{@}fbr.fs{@}uniform sampler2D tMRO;
uniform sampler2D tMatcap;
uniform sampler2D tNormal;
uniform vec4 uLight;
uniform vec3 uColor;
uniform float uNormalStrength;

varying vec3 vNormal;
varying vec3 vWorldNormal;
varying vec3 vPos;
varying vec3 vEyePos;
varying vec2 vUv;
varying vec3 vMPos;

const float PI = 3.14159265359;
const float PI2 = 6.28318530718;
const float RECIPROCAL_PI = 0.31830988618;
const float RECIPROCAL_PI2 = 0.15915494;
const float LOG2 = 1.442695;
const float EPSILON = 1e-6;
const float LN2 = 0.6931472;

#require(matcap.vs)

float prange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    float oldRange = oldMax - oldMin;
    float newRange = newMax - newMin;
    return (((oldValue - oldMin) * newRange) / oldRange) + newMin;
}

float pcrange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    return clamp(prange(oldValue, oldMin, oldMax, newMin, newMax), min(newMax, newMin), max(newMin, newMax));
}

vec3 unpackNormalFBR( vec3 eye_pos, vec3 surf_norm, vec3 mapN, float intensity, float scale, vec2 uv ) {
    vec3 q0 = dFdx( eye_pos.xyz );
    vec3 q1 = dFdy( eye_pos.xyz );
    vec2 st0 = dFdx( uv.st );
    vec2 st1 = dFdy( uv.st );

    vec3 N = normalize(surf_norm);

    vec3 q1perp = cross( q1, N );
    vec3 q0perp = cross( N, q0 );

    vec3 T = q1perp * st0.x + q0perp * st1.x;
    vec3 B = q1perp * st0.y + q0perp * st1.y;

    float det = max( dot( T, T ), dot( B, B ) );
    float scalefactor = ( det == 0.0 ) ? 0.0 : inversesqrt( det );

    mapN = mapN * 2.0 - 1.0;
    mapN.xy *= intensity;

    return normalize( T * ( mapN.x * scalefactor ) + B * ( mapN.y * scalefactor ) + N * mapN.z );
}

vec3 unpackNormalFBR( vec3 eye_pos, vec3 surf_norm, sampler2D normal_map, float intensity, float scale, vec2 uv ) {
    vec3 mapN = texture2D( normal_map, uv * scale ).xyz;
    return unpackNormalFBR( eye_pos, surf_norm, mapN, intensity, scale, uv );
}

float geometricOcclusion(float NdL, float NdV, float roughness) {
    float r = roughness;
    float attenuationL = 2.0 * NdL / (NdL + sqrt(r * r + (1.0 - r * r) * (NdL * NdL)));
    float attenuationV = 2.0 * NdV / (NdV + sqrt(r * r + (1.0 - r * r) * (NdV * NdV)));
    return attenuationL * attenuationV;
}

float microfacetDistribution(float roughness, float NdH) {
    float roughnessSq = roughness * roughness;
    float f = (NdH * roughnessSq - NdH) * NdH + 1.0;
    return roughnessSq / (PI * f * f);
}

vec3 getFBR(vec3 baseColor, vec2 uv, vec3 normal) {
    vec3 mro = texture2D(tMRO, uv).rgb;
    float roughness = mro.g;

    vec2 aUV = reflectMatcap(vMPos, normal);
    vec2 bUV = ((aUV - 0.5) * 0.5 - vec2(0.1)) + 0.5;
    vec2 mUV = mix(aUV, bUV, roughness);

    vec3 V = normalize(cameraPosition - vMPos);
    vec3 L = normalize(uLight.xyz);
    vec3 H = normalize((L + V) / 2.); // the halfway vector is the sum of L and H divided by the sum of their lengths

    float NdL = pcrange(clamp(dot(normal, L), 0.001, 1.0), 0.0, 1.0, 0.4, 1.0);
    float NdV = pcrange(clamp(abs(dot(normal, V)), 0.001, 1.0), 0.0, 1.0, 0.4, 1.0);
    float NdH = clamp(dot(normal, H), 0.0, 1.0);
    float VdH = clamp(dot(V, H), 0.0, 1.0);

    float G = geometricOcclusion(NdL, NdV, roughness);
    float D = microfacetDistribution(roughness, NdH);

    vec3 specContrib = G * D / (4.0 * NdL * NdV) * uColor;
    vec3 color = NdL * specContrib * uLight.w;

    return ((baseColor * texture2D(tMatcap, mUV).rgb) + color) * mro.b;
}

vec3 getFBR(vec3 baseColor, vec3 textureNormal) {
    vec3 normal = unpackNormalFBR(vEyePos, vWorldNormal, textureNormal, uNormalStrength, 1.0, vUv);
    return getFBR(baseColor, vUv, normal);
}

vec3 getFBR(vec3 baseColor, vec2 uv, vec2 normalUV) {
    vec3 normal = unpackNormalFBR(vEyePos, vWorldNormal, tNormal, uNormalStrength, 1.0, normalUV);
    return getFBR(baseColor, uv, normal);
}

vec3 getFBR(vec3 baseColor, vec2 uv) {
    return getFBR(baseColor, uv, uv);
}

vec3 getFBR(vec3 baseColor) {
    return getFBR(baseColor, vUv, vUv);
}

vec3 getFBR() {
    float roughness = texture2D(tMRO, vUv).g;

    vec3 normal = unpackNormalFBR(vEyePos, vWorldNormal, tNormal, 1.0, 1.0, vUv);
    vec2 aUV = reflectMatcap(vMPos, normal);
    vec2 bUV = ((aUV - 0.5) * 0.5 - vec2(0.1)) + 0.5;
    vec2 mUV = mix(aUV, bUV, roughness);

    return texture2D(tMatcap, mUV).rgb;
}

vec3 getFBRSimplified() {
    vec2 mUV = reflectMatcap(vMPos, vWorldNormal);
    return texture2D(tMatcap, mUV).rgb;
}
{@}fbr.vs{@}varying vec3 vNormal;
varying vec3 vWorldNormal;
varying vec3 vPos;
varying vec3 vEyePos;
varying vec2 vUv;
varying vec3 vMPos;

void setupFBR(vec3 p0) { //inlinemain
    vNormal = normalMatrix * normal;
    vWorldNormal = mat3(modelMatrix[0].xyz, modelMatrix[1].xyz, modelMatrix[2].xyz) * normal;
    vUv = uv;
    vPos = p0;
    vec4 mPos = modelMatrix * vec4(p0, 1.0);
    vMPos = mPos.xyz / mPos.w;
    vEyePos = vec3(modelViewMatrix * vec4(p0, 1.0));
}{@}advectionManualFilteringShader.fs{@}varying vec2 vUv;
uniform sampler2D uVelocity;
uniform sampler2D uSource;
uniform vec2 texelSize;
uniform vec2 dyeTexelSize;
uniform float dt;
uniform float dissipation;
vec4 bilerp (sampler2D sam, vec2 uv, vec2 tsize) {
    vec2 st = uv / tsize - 0.5;
    vec2 iuv = floor(st);
    vec2 fuv = fract(st);
    vec4 a = texture2D(sam, (iuv + vec2(0.5, 0.5)) * tsize);
    vec4 b = texture2D(sam, (iuv + vec2(1.5, 0.5)) * tsize);
    vec4 c = texture2D(sam, (iuv + vec2(0.5, 1.5)) * tsize);
    vec4 d = texture2D(sam, (iuv + vec2(1.5, 1.5)) * tsize);
    return mix(mix(a, b, fuv.x), mix(c, d, fuv.x), fuv.y);
}
void main () {
    vec2 coord = vUv - dt * bilerp(uVelocity, vUv, texelSize).xy * texelSize;
    gl_FragColor = dissipation * bilerp(uSource, coord, dyeTexelSize);
    gl_FragColor.a = 1.0;
}{@}advectionShader.fs{@}varying vec2 vUv;
uniform sampler2D uVelocity;
uniform sampler2D uSource;
uniform vec2 texelSize;
uniform float dt;
uniform float dissipation;
void main () {
    vec2 coord = vUv - dt * texture2D(uVelocity, vUv).xy * texelSize;
    gl_FragColor = dissipation * texture2D(uSource, coord);
    gl_FragColor.a = 1.0;
}{@}backgroundShader.fs{@}varying vec2 vUv;
uniform sampler2D uTexture;
uniform float aspectRatio;
#define SCALE 25.0
void main () {
    vec2 uv = floor(vUv * SCALE * vec2(aspectRatio, 1.0));
    float v = mod(uv.x + uv.y, 2.0);
    v = v * 0.1 + 0.8;
    gl_FragColor = vec4(vec3(v), 1.0);
}{@}clearShader.fs{@}varying vec2 vUv;
uniform sampler2D uTexture;
uniform float value;
void main () {
    gl_FragColor = value * texture2D(uTexture, vUv);
}{@}colorShader.fs{@}uniform vec4 color;
void main () {
    gl_FragColor = color;
}{@}curlShader.fs{@}varying highp vec2 vUv;
varying highp vec2 vL;
varying highp vec2 vR;
varying highp vec2 vT;
varying highp vec2 vB;
uniform sampler2D uVelocity;
void main () {
    float L = texture2D(uVelocity, vL).y;
    float R = texture2D(uVelocity, vR).y;
    float T = texture2D(uVelocity, vT).x;
    float B = texture2D(uVelocity, vB).x;
    float vorticity = R - L - T + B;
    gl_FragColor = vec4(0.5 * vorticity, 0.0, 0.0, 1.0);
}{@}displayShader.fs{@}varying vec2 vUv;
uniform sampler2D uTexture;
void main () {
    vec3 C = texture2D(uTexture, vUv).rgb;
    float a = max(C.r, max(C.g, C.b));
    gl_FragColor = vec4(C, a);
}{@}divergenceShader.fs{@}varying highp vec2 vUv;
varying highp vec2 vL;
varying highp vec2 vR;
varying highp vec2 vT;
varying highp vec2 vB;
uniform sampler2D uVelocity;
void main () {
    float L = texture2D(uVelocity, vL).x;
    float R = texture2D(uVelocity, vR).x;
    float T = texture2D(uVelocity, vT).y;
    float B = texture2D(uVelocity, vB).y;
    vec2 C = texture2D(uVelocity, vUv).xy;
   if (vL.x < 0.0) { L = -C.x; }
   if (vR.x > 1.0) { R = -C.x; }
   if (vT.y > 1.0) { T = -C.y; }
   if (vB.y < 0.0) { B = -C.y; }
    float div = 0.5 * (R - L + T - B);
    gl_FragColor = vec4(div, 0.0, 0.0, 1.0);
}
{@}fluidBase.vs{@}varying vec2 vUv;
varying vec2 vL;
varying vec2 vR;
varying vec2 vT;
varying vec2 vB;
uniform vec2 texelSize;

void main () {
    vUv = uv;
    vL = vUv - vec2(texelSize.x, 0.0);
    vR = vUv + vec2(texelSize.x, 0.0);
    vT = vUv + vec2(0.0, texelSize.y);
    vB = vUv - vec2(0.0, texelSize.y);
    gl_Position = vec4(position, 1.0);
}{@}gradientSubtractShader.fs{@}varying highp vec2 vUv;
varying highp vec2 vL;
varying highp vec2 vR;
varying highp vec2 vT;
varying highp vec2 vB;
uniform sampler2D uPressure;
uniform sampler2D uVelocity;
vec2 boundary (vec2 uv) {
    return uv;
    // uv = min(max(uv, 0.0), 1.0);
    // return uv;
}
void main () {
    float L = texture2D(uPressure, boundary(vL)).x;
    float R = texture2D(uPressure, boundary(vR)).x;
    float T = texture2D(uPressure, boundary(vT)).x;
    float B = texture2D(uPressure, boundary(vB)).x;
    vec2 velocity = texture2D(uVelocity, vUv).xy;
    velocity.xy -= vec2(R - L, T - B);
    gl_FragColor = vec4(velocity, 0.0, 1.0);
}{@}pressureShader.fs{@}varying highp vec2 vUv;
varying highp vec2 vL;
varying highp vec2 vR;
varying highp vec2 vT;
varying highp vec2 vB;
uniform sampler2D uPressure;
uniform sampler2D uDivergence;
vec2 boundary (vec2 uv) {
    return uv;
    // uncomment if you use wrap or repeat texture mode
    // uv = min(max(uv, 0.0), 1.0);
    // return uv;
}
void main () {
    float L = texture2D(uPressure, boundary(vL)).x;
    float R = texture2D(uPressure, boundary(vR)).x;
    float T = texture2D(uPressure, boundary(vT)).x;
    float B = texture2D(uPressure, boundary(vB)).x;
    float C = texture2D(uPressure, vUv).x;
    float divergence = texture2D(uDivergence, vUv).x;
    float pressure = (L + R + B + T - divergence) * 0.25;
    gl_FragColor = vec4(pressure, 0.0, 0.0, 1.0);
}{@}splatShader.fs{@}varying vec2 vUv;
uniform sampler2D uTarget;
uniform float aspectRatio;
uniform vec3 color;
uniform vec3 bgColor;
uniform vec2 point;
uniform vec2 prevPoint;
uniform float radius;
uniform float canRender;
uniform float uAdd;

float blendScreen(float base, float blend) {
    return 1.0-((1.0-base)*(1.0-blend));
}

vec3 blendScreen(vec3 base, vec3 blend) {
    return vec3(blendScreen(base.r, blend.r), blendScreen(base.g, blend.g), blendScreen(base.b, blend.b));
}

float l(vec2 uv, vec2 point1, vec2 point2) {
    vec2 pa = uv - point1, ba = point2 - point1;
    pa.x *= aspectRatio;
    ba.x *= aspectRatio;
    float h = clamp(dot(pa, ba) / dot(ba, ba), 0.0, 1.0);
    return length(pa - ba * h);
}

float cubicOut(float t) {
    float f = t - 1.0;
    return f * f * f + 1.0;
}

void main () {
    vec3 splat = (1.0 - cubicOut(clamp(l(vUv, prevPoint.xy, point.xy) / radius, 0.0, 1.0))) * color;
    vec3 base = texture2D(uTarget, vUv).xyz;
    base *= canRender;

    vec3 outColor = mix(blendScreen(base, splat), base + splat, uAdd);
    gl_FragColor = vec4(outColor, 1.0);
}{@}vorticityShader.fs{@}varying vec2 vUv;
varying vec2 vL;
varying vec2 vR;
varying vec2 vT;
varying vec2 vB;
uniform sampler2D uVelocity;
uniform sampler2D uCurl;
uniform float curl;
uniform float dt;
void main () {
    float L = texture2D(uCurl, vL).x;
    float R = texture2D(uCurl, vR).x;
    float T = texture2D(uCurl, vT).x;
    float B = texture2D(uCurl, vB).x;
    float C = texture2D(uCurl, vUv).x;
    vec2 force = 0.5 * vec2(abs(T) - abs(B), abs(R) - abs(L));
    force /= length(force) + 0.0001;
    force *= curl * C;
    force.y *= -1.0;
//    force.y += 400.3;
    vec2 vel = texture2D(uVelocity, vUv).xy;
    gl_FragColor = vec4(vel + force * dt, 0.0, 1.0);
}{@}FXScrollTransition.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap1;
uniform sampler2D tMap2;
uniform float uTransition;
uniform float uAngle;
uniform float uVelocity;
uniform float uAngleVelocity;
uniform float uRatio;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    vUv = uv;

    gl_Position = vec4(position, 1.0);
}

#!SHADER: Fragment
#require(range.glsl)
#require(hexagons.fs)
#require(transformUV.glsl)
#require(rgbshift.fs)
#require(blendmodes.glsl)
#require(simplenoise.glsl)
#require(eases.glsl)

float aastep(float threshold, float value) {
    float signedDist = threshold - value;
    float d = fwidth(signedDist);
    return 1.0 - smoothstep(-d, d, signedDist);
}

float aastep(float threshold, float value, float padding) {
    return smoothstep(threshold - padding, threshold + padding, value);
}

vec2 aastep(vec2 threshold, vec2 value) {
    return vec2(
        aastep(threshold.x, value.x),
        aastep(threshold.y, value.y)
    );
}

void main() {
    vec2 uv = vUv;

    float bend = smoothstep(0.5, 0.0, abs(uv.x-0.5));

    float inclination = -0.2 * uAngle * uRatio;
    vec2 hexagonUV = scaleUV(uv, vec2(1.0, resolution.x/resolution.y));
    hexagonUV = scaleUV(hexagonUV, vec2(1.0 + length(uv-0.5) * 1.0));
    vec3 hexagons = getHexagons(hexagonUV, max(resolution.y, resolution.x)/120.0);

    float bounceTransition = smoothstep(0.5, 0.0, abs(uTransition-0.5)) * smoothstep(0.5, 0.4, abs(uTransition-0.5));

    float offset = 0.2;
    float blendCut = smoothstep(uv.y + (uv.x * inclination) - offset, uv.y + (uv.x * inclination) + offset, crange(uTransition + hexagons.z * 0.08 * bounceTransition, 0.0, 1.0, inclination-offset, 1.0+offset));
    float merge = smoothstep(0.5, 0.0, abs(blendCut-0.5));
    //uv += pow(hexagons.z, 10.0) * merge * mix(0.15, 0.5, hexagons.x);

    float cut = aastep(uv.y + (uv.x * inclination), crange(uTransition + (hexagons.y * 0.06 + hexagons.z * 0.06) * bounceTransition, 0.0, 1.0, inclination, 1.0));

    uv += hexagons.y * sin(uv.y * 4.0 - time * 0.5) * merge * 0.025;

    vec2 fromUV = uv;
    fromUV = scaleUV(fromUV, vec2(1.0 + hexagons.z * cut * 0.2 + cubicIn(clamp(uTransition, 0.0, 1.0)) * 1.0));
    vec3 color1 = getRGB(tMap1, fromUV, 0.1, 0.001 * merge).rgb;

    vec2 toUV = uv;
    toUV = scaleUV(toUV, vec2(1.0 + hexagons.z * merge * 0.2 + cubicOut(1.0-clamp(uTransition, 0.0, 1.0)) * 0.05));
    vec3 color2 = getRGB(tMap2, toUV, 0.1, 0.001 * merge).rgb;

    vec3 color = mix(color1, color2, cut);

    float colorBlend = merge * hexagons.x * smoothstep(0.5, 0.0, abs(uTransition-0.5));
    color = blendAdd(color, vec3(1.0, 0.4, 0.0), colorBlend * 1.5 * (0.5 + sin(uTransition * 3.0 + time * 1.0 - uv.x * 10.0) * 0.5));

    gl_FragColor.rgb = color;
    gl_FragColor.a = 1.0;
}
{@}motionvector.fs{@}uniform float uMotionStrength;
uniform float uPlayhead;
uniform float uFrames;
uniform sampler2DArray tColor;
uniform sampler2DArray tMotionVectors;

float _mvFrameIndex;
float _mvNextFrameIndex;
vec2 _mvCurrentUV;
vec2 _mvNextUV;
float _mvBlend;

vec4 getMVColor(vec2 uv) {
    // Use uPlayhead uniform remapped to 0-1
    float totalFrames = uFrames;
    float currentFrame = fract(uPlayhead) * (totalFrames - 1.0);

    // Use floor to get the integer frame number
    float frameIndex = floor(currentFrame);
    // Calculate the next frame index
    float nextFrameIndex = mod(frameIndex + 1.0, totalFrames);

    // Calculate the blend factor between current and next frame
    float blend = fract(currentFrame);

    // Sample the color and motion vectors from both frames
    vec2 currentMotion = texture(tMotionVectors, vec3(uv, frameIndex)).rg;
    vec2 nextMotion = texture(tMotionVectors, vec3(uv, nextFrameIndex)).rg;

    currentMotion = (currentMotion * 2.0 - 1.0) * (uMotionStrength*0.01);
    nextMotion = (nextMotion * 2.0 - 1.0) * (uMotionStrength*0.01);

    // Use smoothstep for a more gradual blend
    float smoothBlend = smoothstep(0.0, 1.0, blend);

    vec2 currentUV = uv - currentMotion * smoothBlend;
    vec2 nextUV = uv + nextMotion * (1.0 - smoothBlend);

    currentUV = clamp(currentUV, 0.0, 1.0);
    nextUV = clamp(nextUV, 0.0, 1.0);

    _mvCurrentUV = currentUV;
    _mvNextUV = nextUV;
    _mvFrameIndex = frameIndex;
    _mvNextFrameIndex = nextFrameIndex;
    _mvBlend = smoothBlend;

    vec4 currentColorDisplaced = texture(tColor, vec3(currentUV, frameIndex));
    vec4 nextColorDisplaced = texture(tColor, vec3(nextUV, nextFrameIndex));

    return mix(currentColorDisplaced, nextColorDisplaced, smoothBlend);
}

vec3 getMVNormal(sampler2DArray tNormal, vec2 uv) {
    vec3 currentNormalDisplaced = texture(tNormal, vec3(_mvCurrentUV, _mvFrameIndex)).rgb;
    vec3 nextNormalDisplaced = texture(tNormal, vec3(_mvNextUV, _mvNextFrameIndex)).rgb;
    return mix(currentNormalDisplaced, nextNormalDisplaced, _mvBlend);
}{@}mousefluid.fs{@}uniform sampler2D tFluid;
uniform sampler2D tFluidMask;

vec2 getFluidVelocity() {
    float fluidMask = smoothstep(0.1, 0.7, texture2D(tFluidMask, vUv).r);
    return texture2D(tFluid, vUv).xy * fluidMask;
}

vec3 getFluidVelocityMask() {
    float fluidMask = smoothstep(0.1, 0.7, texture2D(tFluidMask, vUv).r);
    return vec3(texture2D(tFluid, vUv).xy * fluidMask, fluidMask);
}{@}ProtonAntimatter.fs{@}uniform sampler2D tOrigin;
uniform sampler2D tAttribs;
uniform float uMaxCount;
//uniforms

#require(range.glsl)
//requires

void main() {
    vec2 uv = vUv;
    #test !window.Metal
    uv = gl_FragCoord.xy / fSize;
    #endtest

    vec3 origin = texture2D(tOrigin, uv).xyz;
    vec4 inputData = texture2D(tInput, uv);
    vec3 pos = inputData.xyz;
    vec4 random = texture2D(tAttribs, uv);
    float data = inputData.w;

    if (vUv.x + vUv.y * fSize > uMaxCount) {
        gl_FragColor = vec4(9999.0);
        return;
    }

    //code

    gl_FragColor = vec4(pos, data);
}{@}ProtonAntimatterLifecycle.fs{@}uniform sampler2D tOrigin;
uniform sampler2D tAttribs;
uniform sampler2D tSpawn;
uniform float uMaxCount;
//uniforms

#require(range.glsl)
//requires

void main() {
    vec3 origin = texture2D(tOrigin, vUv).rgb;
    vec4 inputData = texture2D(tInput, vUv);
    vec3 pos = inputData.xyz;
    vec4 random = texture2D(tAttribs, vUv);
    float data = inputData.w;

    if (vUv.x + vUv.y * fSize > uMaxCount) {
        gl_FragColor = vec4(9999.0);
        return;
    }

    vec4 spawn = texture2D(tSpawn, vUv);
    float life = spawn.x;

    if (spawn.x < -500.0) {
        pos = spawn.xyz;
        pos.x += 999.0;
        spawn.x = 1.0;
        gl_FragColor = vec4(pos, data);
        return;
    }

    //abovespawn
    if (spawn.x <= 0.0) {
        pos.x = 9999.0;
        gl_FragColor = vec4(pos, data);
        return;
    }

    //abovecode
    //code

    gl_FragColor = vec4(pos, data);
}{@}ProtonNeutrino.fs{@}//uniforms

#require(range.glsl)
//requires

void main() {
    //code
}{@}SceneLayout.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform float uAlpha;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    vec3 pos = position;
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment
void main() {
    gl_FragColor = texture2D(tMap, vUv);
    gl_FragColor.a *= uAlpha;
    gl_FragColor.rgb /= gl_FragColor.a;
}{@}ssao.glsl{@}uniform highp sampler2D tDepth;
uniform float uNear;
uniform float uFar;
uniform float uAOClamp;
uniform float uAOLumInfluence;
uniform float uAORadius;
uniform float uAOSamples;
uniform float uAODisplace;
uniform float uAODiffArea;
uniform float uAOAdjustment;
uniform float uAOStrength;
uniform float uAOMaxDist;

#define DL 2.399963229728653
#define EULER 2.718281828459045

const bool useNoise = true;
const float noiseAmount = 0.0003;

vec2 rand(const vec2 coord) {
    vec2 noise;
    if (useNoise) {
        float nx = dot(coord, vec2(12.9898, 78.233));
        float ny = dot(coord, vec2(12.9898, 78.233) * 2.0);
        noise = clamp(fract(43758.5453 * sin(vec2(nx, ny))), 0.0, 1.0);
    } else {
        float ff = fract(1.0 - coord.s * (resolution.x / 2.0));
        float gg = fract(coord.t * (resolution.y / 2.0));
        noise = vec2(0.25, 0.75) * vec2(ff) + vec2(0.75, 0.25) * gg;
    }
    return (noise * 2.0 - 1.0) * noiseAmount;
}

float readDepth(const in vec2 uv) {
    float f = uFar;
    float n = uNear;
    vec4 depth = texture2D(tDepth, uv);
    return (2.0 * n) / (f + n - depth.x * (f - n));
}

float compareDepths(const in float depth1,
                    const in float depth2, inout int far) {
    float garea = 2.0;
    float diff = (depth1 - depth2) * 100.0;
    float udisp = uAODisplace * 0.01;
    float udiff = uAODiffArea * 0.01;
    if (diff < udisp) {
        garea = udiff;
    } else {
        far = 1;
    }
    float dd = diff - udisp;
    float gauss = pow(EULER, -2.0 * dd * dd / (garea * garea));
    return gauss;
}

float calcAO(float depth, float dw, float dh) {
    float dd = uAORadius - depth * uAORadius;
    vec2 vv = vec2(dw, dh);
    vec2 coord1 = vUv + dd * vv;
    vec2 coord2 = vUv - dd * vv;
    float temp1 = 0.0;
    float temp2 = 0.0;
    int far = 0;
    temp1 = compareDepths(depth, readDepth(coord1), far);
    if (far > 0) {
        temp2 = compareDepths(readDepth(coord2), depth, far);
        temp1 += (1.0 - temp1) * temp2;
    }
    return temp1;
}

float aorange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    vec3 sub = vec3(oldValue, newMax, oldMax) - vec3(oldMin, newMin, oldMin);
    return sub.x * sub.y / sub.z + newMin;
}

float aocrange(float oldValue, float oldMin, float oldMax, float newMin, float newMax) {
    return clamp(aorange(oldValue, oldMin, oldMax, newMin, newMax), min(newMin, newMax), max(newMin, newMax));
}

float getSSAO(vec2 vUv) {
    vec2 noise = rand(vUv);
    float depth = readDepth(vUv);
    float tt = clamp(depth, uAOClamp, 1.0);
    float w = (1.0 / resolution.x) / tt + (noise.x * (1.0 - noise.x));
    float h = (1.0 / resolution.y) / tt + (noise.y * (1.0 - noise.y));
    float ao = 0.0;
    float dz = 1.0 / uAOSamples;
    float z = 1.0 - dz / 2.0;
    float l = 0.0;
    for (int i = 0; i <= 10; i++) {
        float r = sqrt(1.0 - z);
        float pw = cos(l) * r;
        float ph = sin(l) * r;
        ao += calcAO(depth, pw * w, ph * h);
        z = z - dz;
        l = l + DL;
    }
    ao /= uAOSamples;
    ao = 1.0 - ao;
    vec3 color = texture2D(tDiffuse, vUv).rgb;
    vec3 lumcoeff = vec3(0.299, 0.587, 0.114);
    float lum = dot(color.rgb, lumcoeff);
    vec3 luminance = vec3(lum);
    vec3 final = vec3(mix(vec3(ao), vec3(1.0), luminance * uAOLumInfluence));

    float o = aocrange(final.r, 0.0, uAOAdjustment, 0.0, 1.0);
    o = mix(o, 1.0, step(uAOMaxDist, depth));

    return o = mix(1.0, o, uAOStrength);
}
{@}calcnormalfromdepth.glsl{@}vec3 uvToEyePos(in sampler2D depth, in vec2 uv) {
    float linearDepth = getDepthValue(depth, uv, 0.1, 1000.0);
    return (vec3(2.0 * uv - 1.0, -1.0) * uFrustum * linearDepth);
}

vec3 uvToEyePos(in float depth, in vec2 uv) {
    float linearDepth = getDepthValue(depth, 0.1, 1000.0);
    return (vec3(2.0 * uv - 1.0, -1.0) * uFrustum * linearDepth);
}

//if we trivialy accept differences between depths, there can be cases
//where the shortest difference does not belong to the same edge, and because of that
//a second depth is used to extrapolate the nearest depth value.
//points that are on the same surface should (based on the diagram) more or less
//end up at the same depth as the sampled one.
//this is explained here: https://atyuwen.github.io/posts/normal-reconstruction/

vec3 calcNormalFromDepth(in float _depth, in vec2 _uv) {
    vec2 texSize = 1.0 / uResolution;
    ivec2 uv = ivec2(_uv * uResolution);

    if (abs(_depth) >= 1.0) {
        return vec3(0.0);
    }

    vec3 posEye = uvToEyePos(_depth, _uv);

    //find best depth along x...
    float dr = texelFetch(tDepth, uv + ivec2(1, 0), 0).x;
    float dr2 = texelFetch(tDepth, uv + ivec2(2, 0), 0).x;
    float dl = texelFetch(tDepth, uv - ivec2(1, 0), 0).x;
    float dl2 = texelFetch(tDepth, uv - ivec2(2, 0), 0).x;

    vec3 ddx = uvToEyePos(dr, _uv + vec2(texSize.x, 0.0)) - posEye;
    vec3 ddx2 = posEye - uvToEyePos(dl, _uv - vec2(texSize.x, 0.0));

    float horizontalEdgeRight = abs((2.0*dr - dr2) - _depth);
    float horizontalEdgeLeft = abs((2.0*dl - dl2) - _depth);
    vec3 deltaX = horizontalEdgeRight < horizontalEdgeLeft ? ddx : ddx2;

    //find best depth along y...
    float dt = texelFetch(tDepth, uv + ivec2(0, 1), 0).x;
    float dt2 = texelFetch(tDepth, uv + ivec2(0, 2), 0).x;
    float db = texelFetch(tDepth, uv - ivec2(0, 1), 0).x;
    float db2 = texelFetch(tDepth, uv - ivec2(0, 2), 0).x;

    vec3 ddy = uvToEyePos(dt, _uv + vec2(0.0, texSize.y)) - posEye;
    vec3 ddy2 = posEye - uvToEyePos(db, _uv - vec2(0.0, texSize.y));

    float verticalEdgeTop = abs((2.0 * dt - dt2) - _depth);
    float verticalEdgeBottom = abs((2.0 * db - db2) - _depth);

    vec3 deltaY = verticalEdgeTop < verticalEdgeBottom ? ddy : ddy2;

    return normalize(cross(deltaX, deltaY));
}
{@}deNoiseSSAO.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform sampler2D tDepth;
uniform vec2 uDirection;
uniform float uDepthSigma;

uniform float uSpatialSigma;
uniform float uNormalSigma;


#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    gl_Position = vec4(position, 1.0);
    vUv = uv;
}

#!SHADER: Fragment
#define BILATERAL_BLUR

#define PI 3.14159265359
#define TAU 3.14159265359 * 2.0

float gaussianWeight(in float sigma, in float x) {
    float sigma2 = sigma * sigma;
    return exp(-(x * x) / (2.0 * sigma2));
}

void main() {

    float result = 0.0;
    vec2 snapUv = (floor(vUv * resolution.xy) + 0.5) / resolution.xy;
    vec2 aoDepthP = texelFetch(tMap, ivec2(snapUv * resolution.xy), 0).xy;
    vec3 normP = texelFetch(tDepth, ivec2(snapUv * resolution.xy), 0).xyz;

    #ifdef BILATERAL_BLUR

    if (abs(aoDepthP.y) >= (1000.0 - 0.1)) {
        gl_FragColor = vec4(aoDepthP, 0.0, 1.0);
        return;
    }

    vec2 blurDirection = uDirection * (1.0 / resolution.xy);
    float wsum = 0.0;
    float filterRadius = 5.0;
    float spatialWeight = 0.0;
    float normWeight = 0.0;
    float rangeWeight = 0.0;

    for(float x=-filterRadius; x<=filterRadius; x+=1.0) {

        vec2 offset = blurDirection * x;
        vec2 coord = snapUv + offset;
        vec2 aoDepthQ = texelFetch(tMap, ivec2(coord * resolution.xy), 0).xy;
        vec3 normQ = texelFetch(tDepth, ivec2(coord * resolution.xy), 0).xyz;

        spatialWeight = gaussianWeight(uSpatialSigma, abs(x));
        rangeWeight = gaussianWeight(uDepthSigma, abs(aoDepthQ.y - aoDepthP.y));
//        normWeight = gaussianWeight(uNormalSigma, 1.0 - dot(normP, normQ));
        normWeight =  max(0.0, dot(normP, normQ));
        result += aoDepthQ.x * spatialWeight * rangeWeight * normWeight;
        wsum += spatialWeight * rangeWeight * normWeight;

    }

    if(wsum > 0.0) {
        result /= wsum;
    } else {
        result = aoDepthP.x;
    }

    gl_FragColor = vec4(result, aoDepthP.y, 0.0, 1.0);

    #else

    float weight = 0.0;

    for(float i = -2.0; i < 2.0; i++) {
        for(float j = -2.0; j < 2.0; j++) {
            vec2 coord = vUv + (vec2(j, i) * (1.0/resolution.xy));
            result += texture2D(tMap, coord).x;
        }
    }

    result /= 16.0;
    gl_FragColor = vec4(result, aoDepthP.y, 0.0, 1.0);
    #endif
}
{@}depthDownNormalCalc.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tDepth;
uniform sampler2D tNormals;
uniform vec2 uResolution;
uniform vec2 uCameraNearFar;
uniform vec3 uFrustum;

uniform mat4 uInverseProjectionMatrix;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    gl_Position = vec4(position, 1.0);
    vUv = uv;
}

#!SHADER: Fragment
#require(depthvalue.fs)
//    #define USE_CHECKERBOARD_DEPTH

//if we trivialy accept differences between depths, there can be cases
//where the shortest difference does not belong to the same edge, and because of that
//a second depth is used to extrapolate the nearest depth value.
//points that are on the same surface should (based on the diagram) more or less
//end up at the same depth as the sampled one.
//this is explained here: https://atyuwen.github.io/posts/normal-reconstruction/

vec3 calcNormalFromDepth(in float _depth, in vec2 _uv) {
    vec2 texSize = 1.0 / uResolution;
    ivec2 uv = ivec2(_uv * uResolution);

    if (abs(_depth) >= 1.0) {
        return vec3(0.0);
    }

    vec3 posEye = eyePosFromDepth(_depth, 0.1, 1000.0, _uv * uResolution, false);

    //find best depth along x...
    float dr = texelFetch(tDepth, uv + ivec2(1, 0), 0).x;
    float dr2 = texelFetch(tDepth, uv + ivec2(2, 0), 0).x;
    float dl = texelFetch(tDepth, uv - ivec2(1, 0), 0).x;
    float dl2 = texelFetch(tDepth, uv - ivec2(2, 0), 0).x;

    vec3 ddx = eyePosFromDepth(dr, 0.1, 1000.0, (_uv + vec2(texSize.x, 0.0))*uResolution, false) - posEye;
    vec3 ddx2 = posEye - eyePosFromDepth(dl, 0.1, 1000.0, (_uv - vec2(texSize.x, 0.0)) * uResolution, false);

    float horizontalEdgeRight = abs((2.0*dr - dr2) - _depth);
    float horizontalEdgeLeft = abs((2.0*dl - dl2) - _depth);
    vec3 deltaX = horizontalEdgeRight < horizontalEdgeLeft ? ddx : ddx2;

    //find best depth along y...
    float dt = texelFetch(tDepth, uv + ivec2(0, 1), 0).x;
    float dt2 = texelFetch(tDepth, uv + ivec2(0, 2), 0).x;
    float db = texelFetch(tDepth, uv - ivec2(0, 1), 0).x;
    float db2 = texelFetch(tDepth, uv - ivec2(0, 2), 0).x;

    vec3 ddy = eyePosFromDepth(dt, 0.1, 1000.0, (_uv + vec2(0.0, texSize.y)) * uResolution, false) - posEye;
    vec3 ddy2 = posEye - eyePosFromDepth(db, 0.1, 1000.0, (_uv - vec2(0.0, texSize.y)) * uResolution, false);

    float verticalEdgeTop = abs((2.0 * dt - dt2) - _depth);
    float verticalEdgeBottom = abs((2.0 * db - db2) - _depth);

    vec3 deltaY = verticalEdgeTop < verticalEdgeBottom ? ddy : ddy2;

    return normalize(cross(deltaX, deltaY));
}

void main() {

    vec2 snapUV = (floor(vUv * uResolution) + 0.5) / uResolution;
    vec2 texSize = 1.0 / uResolution;

    vec2 desiredCoord = vec2(0.0);

    vec2 bl = snapUV;
    vec2 br = snapUV + vec2(texSize.x, 0.0);
    vec2 tl = snapUV + vec2(0.0, texSize.y);
    vec2 tr = snapUV + vec2(texSize);

    ivec2 fullResCoord = ivec2(vUv * uResolution);
    float bld = texelFetch(tDepth, fullResCoord, 0).x;
    float brd = texelFetch(tDepth, fullResCoord + ivec2(1, 0), 0).x;
    float tld = texelFetch(tDepth, fullResCoord + ivec2(0, 1), 0).x;
    float trd = texelFetch(tDepth, fullResCoord + ivec2(1, 1), 0).x;

    float depth;
    float maxDepth = max(max(bld, brd), max(tld, trd));

    #ifdef USE_CHECKERBOARD_DEPTH
        float minDepth = min(min(bld, brd), min(tld, trd));
        depth = mix(maxDepth, minDepth, float(int(gl_FragCoord.x) & 1 * int(gl_FragCoord.y) & 1));
    #else
        depth = maxDepth;
    #endif

    int index = 0;
    float[] samples = float[4](bld, brd, tld, trd);
    vec2[] coords = vec2[4](bl, br, tl, tr);
    for(int i = 0; i < 4; ++i) {
        if (samples[i] == depth) {
            index = i;
            break;
        }
    }
    vec3 normal = calcNormalFromDepth(samples[index], coords[index]);
//    vec3 normal = calcNormalFromDepth(samples[0], coords[0]);
    gl_FragColor = vec4(normal, getEyeZ(samples[index], 0.1, 1000.0));

}
{@}ssaoplus.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tNormal;
uniform sampler2D tRotations;
uniform sampler2D tBlueNoise;
uniform vec3[24] uSampleOffsets;
uniform vec3 uFrustum;

uniform float uSampleRadius;
uniform float uBias;
uniform float uIntensity;
uniform float uContrast;
uniform float uProjectionScale;

uniform float uTau;
uniform float uQuality;
uniform mat4 uInverseProjectionMatrix;

uniform vec2 uCameraNearFar;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    gl_Position = vec4(position, 1.0);
    vUv = uv;
}

#!SHADER: Fragment
#require(depthvalue.fs)
#require(tridither.glsl)

//#define USE_BLUE_NOISE
//#define USE_PROJECTED_OFFSET
#define PI 3.14159265359
#define TAU 3.14159265359 * 2.0

float alchemyHash(in vec2 c) {
    ivec2 iC = ivec2(c);
    return float(30 * iC.x ^ iC.y + iC.x * iC.y * 10);
}

vec2 getSampleOffset(in float i, in vec2 coord, in float r, float omega) {
    float alpha = (i + 0.5) * (1.0/uQuality);
    float hPrime = r * alpha;
    float turn = floor(uTau);
    float theta = alpha * (TAU * turn) + omega;
    return vec2(cos(theta), sin(theta)) * hPrime;
}

//sources:
//https://casual-effects.com/research/McGuire2011AlchemyAO/VV11AlchemyAO.pdf
//https://casual-effects.com/research/McGuire2012SAO/index.html
//https://learnopengl.com/Advanced-Lighting/SSAO

void main() {
    //vec2 coord = (floor(vUv * resolution.xy) + 0.5) / resolution.xy;
    vec2 coord = gl_FragCoord.xy;
    vec4 normalDepth = texelFetch(tNormal, ivec2(coord + 0.5), 0);
    vec3 normal = normalDepth.xyz;
    float depth = normalDepth.w;

    if (abs(depth) >= (uCameraNearFar.y - uCameraNearFar.x)) {
        gl_FragColor = vec4(1.0, depth, 0.0, 1.0);
        return;
    }

    vec3 viewPos = eyePosFromDepth(depth, uCameraNearFar.x, uCameraNearFar.y, coord, true);

    vec3 rVec;
    #ifdef USE_BLUE_NOISE
        rVec = vec3(2.0 * texture2D(tBlueNoise, gl_FragCoord.xy / 64.0) - 1.0) * vec3(1.0, 1.0, 0.0);
    #else
        rVec = normalize(texture2D(tRotations, gl_FragCoord.xy / 4.0).xyz);
    #endif

    #ifdef USE_PROJECTED_OFFSET

        vec3 tangent = normalize(rVec - (normal * dot(rVec, normal)));
        vec3 bitangent = cross(normal, tangent);
        mat3 tbn = mat3(tangent, bitangent, normal);

    #endif

    float occluded = 0.0;

    float quality = uQuality;
    float sampleRadius = -uSampleRadius * uProjectionScale / viewPos.z;
    float radius2 = uSampleRadius * uSampleRadius;
    float omega = alchemyHash(coord);

    for (float i = 0.0; i < quality; i++) {

        #ifdef USE_PROJECTED_OFFSET

            vec3 sampleDirection = tbn * uSampleOffsets[int(i)];
            vec3 samplePos = viewPos + sampleDirection * sampleRadius;
            vec4 offset = projectionMatrix * vec4(samplePos, 1.0);
            offset.xyz /= offset.w;
            offset.xyz = offset.xyz * 0.5 + 0.5;
            offset.xy = (floor(offset.xy * resolution.xy) + 0.5) / resolution.xy;

            vec3 sampledPos = uvToEyePos(texelFetch(tNormal, ivec2(offset.xy * resolution.xy), 0).w, offset.xy);

        #else

            vec2 sampleOffset = getSampleOffset(i, coord, sampleRadius, omega);
            vec2 c = coord + sampleOffset;
            vec3 sampledPos = eyePosFromDepth(texelFetch(tNormal, ivec2(c+0.5), 0).w, uCameraNearFar.x, uCameraNearFar.y, c, true);

        #endif

        vec3 delta = sampledPos - viewPos;
        float nDotv = dot(delta, normal);
        float eps = 0.01;
        float denom = dot(delta, delta);

        float f = max(radius2 - denom, 0.0);
        //float bias = viewPos.z * uBias * 0.01;
        float bias = uBias * 0.01;
        occluded += max(0.0, (nDotv - bias) / (denom + eps)) * f * f * f;
    }

    float tmp = radius2 * uSampleRadius;
    occluded /= tmp * tmp;

    float a = pow(max(0.0, 1.0 - (((2.0 * uIntensity) / quality) * occluded)), uContrast);
//    gl_FragColor = vec4(a, getDepthValue(depth, uCameraNearFar.x, uCameraNearFar.y), 0.0 , 1.0);
//    a = dither1(a, gl_FragCoord.xy, time);
    gl_FragColor = vec4(a, depth, 0.0 , 1.0);

}

{@}upSampleSSAO.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tMap;
uniform sampler2D tDepth;
uniform vec2 uDownSampledDepthResolution;
uniform vec2 uCameraNearFar;
uniform float uSigma;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    gl_Position = vec4(position, 1.0);
    vUv = uv;
}

#!SHADER: Fragment
#require(depthvalue.fs)
//#define BILTERIAL_UPSAMPLE


float gaussianWeight(in float sigma, in float x) {
    float sigma2 = sigma * sigma;
    return exp(-(x * x) / (2.0 * sigma2));
}

void main() {
    vec2 depthCoord = floor(vUv * uDownSampledDepthResolution)/uDownSampledDepthResolution;
    vec2 desiredCoord = vec2(0.0);
    vec2 texSizeDepth = vec2(1.0 / uDownSampledDepthResolution.xy);
    vec2 texSize = vec2(1.0 / resolution.xy);

    float col = 0.0;

    vec2[4] coords;
    coords[0] = depthCoord;
    coords[1] = depthCoord + vec2(texSizeDepth.x, 0.0);
    coords[2] = depthCoord + vec2(0.0, texSizeDepth.y);
    coords[3] = depthCoord + vec2(texSizeDepth);

    vec2 fullResDepthCoord = floor(vUv * resolution.xy)/resolution.xy;
    float currentDepth = getEyeZ(texelFetch(tDepth, ivec2(gl_FragCoord.xy), 0).x, uCameraNearFar.x, uCameraNearFar.y);

    float[4] distances;
    distances[0] = abs(currentDepth - texelFetch(tMap, ivec2(coords[0]), 0).y);
    distances[1] = abs(currentDepth - texelFetch(tMap, ivec2(coords[1]), 0).y);
    distances[2] = abs(currentDepth - texelFetch(tMap, ivec2(coords[2]), 0).y);
    distances[3] = abs(currentDepth - texelFetch(tMap, ivec2(coords[3]), 0).y);

    #ifdef BILTERIAL_UPSAMPLE

    vec2 bfCoord = vUv * uDownSampledDepthResolution - 0.5;
    vec2 fCoord = fract(bfCoord);
    bfCoord = (floor(bfCoord) + 0.5) / uDownSampledDepthResolution;

    float a = texture2D(tMap, bfCoord).x;
    float b = texture2D(tMap, bfCoord + vec2(texSizeDepth.x, 0.0)).x;
    float c = texture2D(tMap, bfCoord + vec2(0.0, texSizeDepth.y)).x;
    float d = texture2D(tMap, bfCoord + texSizeDepth).x;

    float weightA = gaussianWeight(uSigma, distances[0]);
    float weightB = gaussianWeight(uSigma, distances[1]);
    float weightC = gaussianWeight(uSigma, distances[2]);
    float weightD = gaussianWeight(uSigma, distances[3]);

    col = mix(mix(a * weightA, b * weightB, fCoord.x), mix(c * weightC, d * weightD, fCoord.x), fCoord.y);

    #else

    //bilinearly sample SSAO texture if all depth samples are more or less on the same surface
    float depthThreshold = 0.0001;

    if( distances[0] < depthThreshold &&
    distances[1] < depthThreshold &&
    distances[2] < depthThreshold &&
    distances[3] < depthThreshold
    ) {

        vec2 bfCoord = vUv * uDownSampledDepthResolution - 0.5;
        vec2 fCoord = fract(bfCoord);
        bfCoord = (floor(bfCoord) + 0.5) / uDownSampledDepthResolution;

        float a = texture2D(tMap, bfCoord).x;
        float b = texture2D(tMap, bfCoord + vec2(texSizeDepth.x, 0.0)).x;
        float c = texture2D(tMap, bfCoord + vec2(0.0, texSizeDepth.y)).x;
        float d = texture2D(tMap, bfCoord + texSizeDepth).x;

        col = mix(mix(a, b, fCoord.x), mix(c, d, fCoord.x), fCoord.y);

    } else {

        float minDist = distances[0];
        desiredCoord = coords[0];

        if(distances[1] < minDist) {
            minDist = distances[1];
            desiredCoord = coords[1];
        }

        if(distances[2] < minDist) {
            minDist = distances[2];
            desiredCoord = coords[2];
        }

        if(distances[3] < minDist) {
            minDist = distances[3];
            desiredCoord = coords[3];
        }

        col = texture2D(tMap, desiredCoord).x;

    }

    #endif

    gl_FragColor = vec4(col, 0.0, 0.0, 1.0);
}

{@}worldposdebug.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tDepth;
uniform vec3 uFrustum;
uniform vec2 uCameraNearFar;

#!VARYINGS
varying vec3 vRay;
varying vec2 vUv;

#!SHADER: Vertex
void main() {
    gl_Position = vec4(position, 1.0);
    //vRay = (inverse(mat3(viewMatrix)) * vec3(position.xy, -1.0) * uFrustum);
//    vec4 r = inverse(projectionMatrix) * vec4(position.xy, 1.0, 1.0);
//    r /= r.w;
//    vRay = r.xyz;
    //vRay = (viewMatrix[0].xyz * uFrustum.x * position.x) + (viewMatrix[1].xyz * uFrustum.y * position.y) + (viewMatrix[3].xyz * uCameraNearFar.y);
    vRay = mat3(viewMatrix) * vec3(position.xy, -1.0) * uFrustum;
    vUv = uv;
}

#!SHADER: Fragment
#require(depthvalue.fs)

vec3 uvToEye(in sampler2D depth, in vec2 uv) {
    vec4 mvPos = inverse(projectionMatrix) * vec4(2.0 * uv - 1.0, 2.0 * texture2D(depth, uv).x - 1.0, 1.0);
    mvPos /= mvPos.w;
    return mvPos.xyz;
}

vec3 uvToEye(in float depth, in vec2 uv) {
    vec4 mvPos = inverse(projectionMatrix) * vec4(2.0 * uv - 1.0, 2.0 * depth - 1.0, 1.0);
    mvPos /= mvPos.w;
    return mvPos.xyz;
}

float LinearizeDepth(float depth, float near, float far)
{
    float z = depth * 2.0 - 1.0; // back to NDC
    return (2.0 * near * far) / (far + near - z * (far - near));
}

void main() {

//    float linearDepth = getDepthValue(texelFetch(tDepth, ivec2(gl_FragCoord.xy + 0.5), 0).x, uCameraNearFar.x, uCameraNearFar.y);
    float linearDepth = LinearizeDepth(texelFetch(tDepth, ivec2(gl_FragCoord.xy + 0.5), 0).x, uCameraNearFar.x, uCameraNearFar.y);
    //vec3 worldPos = (vec3(2.0 * vUv - 1.0, -1.0) * uFrustum * linearDepth);
    float x = (1.0 - projectionMatrix[2][0]) / projectionMatrix[0][0] - (2.0 * (gl_FragCoord.x + 0.5) / (resolution.x * projectionMatrix[0][0]));
    float y = (1.0 + projectionMatrix[2][1]) / projectionMatrix[1][1] - (2.0 * (gl_FragCoord.y + 0.5) / (resolution.y * projectionMatrix[1][1]));


    gl_FragColor = vec4(vec2(x,y)*-linearDepth, -linearDepth, 1.0);
//    gl_FragColor = vec4(uvToEye(tDepth, vUv), 1.0);
}
{@}Text3D.glsl{@}#!ATTRIBUTES
attribute vec3 animation;

#!UNIFORMS
uniform sampler2D tMap;
uniform vec3 uColor;
uniform float uAlpha;
uniform float uOpacity;
uniform vec3 uTranslate;
uniform vec3 uRotate;
uniform float uTransition;
uniform float uWordCount;
uniform float uLineCount;
uniform float uLetterCount;
uniform float uByWord;
uniform float uByLine;
uniform float uPadding;
uniform vec3 uBoundingMin;
uniform vec3 uBoundingMax;
uniform float uScrollDelta;
uniform vec2 uMouse;
uniform sampler2D tFluid;
uniform sampler2D tFluidMask;

#!VARYINGS
varying float vTrans;
varying vec2 vUv;
varying vec3 vPos;
varying vec3 vWorldPos;

#!SHADER: Vertex

#require(range.glsl)
#require(eases.glsl)
#require(rotation.glsl)
#require(conditionals.glsl)

void main() {
    vUv = uv;
    vTrans = 1.0;

    vec3 pos = position;

    if (uTransition > 0.0 && uTransition < 1.0) {
        float padding = uPadding;
        float letter = (animation.x + 1.0) / uLetterCount;
        float word = (animation.y + 1.0) / uWordCount;
        float line = (animation.z + 1.0) / uLineCount;

        float letterTrans = rangeTransition(uTransition, letter, padding);
        float wordTrans = rangeTransition(uTransition, word, padding);
        float lineTrans = rangeTransition(uTransition, line, padding);

        vTrans = mix(cubicOut(letterTrans), cubicOut(wordTrans), uByWord);
        vTrans = mix(vTrans, cubicOut(lineTrans), uByLine);

        float invTrans = (1.0 - vTrans);
        vec3 nRotate = normalize(uRotate);
        vec3 axisX = vec3(1.0, 0.0, 0.0);
        vec3 axisY = vec3(0.0, 1.0, 0.0);
        vec3 axisZ = vec3(0.0, 0.0, 1.0);
        vec3 axis = mix(axisX, axisY, when_gt(nRotate.y, nRotate.x));
        axis = mix(axis, axisZ, when_gt(nRotate.z, nRotate.x));
        pos = vec3(vec4(position, 1.0) * rotationMatrix(axis, radians(max(max(uRotate.x, uRotate.y), uRotate.z) * invTrans)));
        pos += uTranslate * invTrans;
    }

    vPos = pos;
	vWorldPos = vec3(modelMatrix * vec4(pos, 1.0));

    gl_Position = projectionMatrix * modelViewMatrix * vec4(pos, 1.0);
}

#!SHADER: Fragment

#require(range.glsl)
#require(msdf.glsl)
#require(simplenoise.glsl)
#require(transformUV.glsl)

vec2 getBoundingUV() {
    vec2 uv;
    uv.x = crange(vPos.x, uBoundingMin.x, uBoundingMax.x, 0.0, 1.0);
    uv.y = crange(vPos.y, uBoundingMin.y, uBoundingMax.y, 0.0, 1.0);
    return uv;
}

void main() {
    vec2 uv = vUv;
    vec2 screenuv = gl_FragCoord.xy / resolution;
    vec2 squareScreenuv = scaleUV(screenuv, vec2(1.0, resolution.x/resolution.y));
    vec2 mouse = scaleUV(vec2(uMouse.x, 1.0-uMouse.y), vec2(1.0, resolution.x/resolution.y));

    mouse += cnoise(screenuv*10.0 + time * 0.2 + length(mouse) * 5.0) * 0.01;

    vec2 fluid = texture2D(tFluid, screenuv).xy;
    float fluidMask = smoothstep(0.0, 1.0, texture2D(tFluidMask, screenuv).r);
    float fluidPush = pow(abs(fluid.x)*0.01, 2.5);
    float fluidEdge = fluidPush * smoothstep(0.0, 0.5, fluidMask) * smoothstep(1.0, 0.8, fluidMask);

    //uv.y -= uScrollDelta * 0.1 * mix(-1.0, 1.0, step(0.05, mod(uv.x, 0.5))) * mod(uv.y, 0.3);
    uv += fluidEdge * 0.1;

    float alpha = msdf(tMap, uv);

    //float noise = 0.5 + smoothstep(-1.0, 1.0, cnoise(vec3(vUv*50.0, time* 0.3))) * 0.5;

    vec4 color = vec4(uColor, alpha * uAlpha * uOpacity * vTrans);

    float mouseLen = (1.0-step(0.1, length(squareScreenuv-mouse)));

    // float lines = sin(screenuv.x * resolution.x * 0.5) * (0.5 + cnoise(screenuv*30.0 + time * 0.2));
    // lines = step(0.2, lines);

    vec2 lineUV = screenuv + fluidPush * 0.1;
    float lines = fract(screenuv.x * 300.0) * fract(screenuv.y * 300.0);
    lines = step(0.7, lines);
    color.a = mix(color.a, lines, fluidEdge);

    #drawbuffer Color gl_FragColor = color;
    #drawbuffer Refraction gl_FragColor = color;
}
{@}TweenUILPathFallbackShader.glsl{@}#!ATTRIBUTES
attribute float speed;

#!UNIFORMS
uniform vec3 uColor;
uniform vec3 uColor2;
uniform float uOpacity;

#!VARYINGS
varying vec3 vColor;

#!SHADER: Vertex

void main() {
    vColor = mix(uColor, uColor2, speed);
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}

#!SHADER: Fragment
void main() {
    gl_FragColor = vec4(vColor, uOpacity);
}
{@}TweenUILPathShader.glsl{@}#!ATTRIBUTES
attribute float speed;

#!UNIFORMS
uniform vec3 uColor2;

#!VARYINGS

#!SHADER: Vertex

void main() {
    vColor = mix(uColor, uColor2, speed);
}

void customDirection() {
    // Use screen space coordinates for final position, so line thickness is
    // independent of camera.
    finalPosition = vec4(currentP.x / aspect, currentP.y, min(0.0, finalPosition.z), 1.0);
}

#!SHADER: Fragment
float tri(float v) {
    return mix(v, 1.0 - v, step(0.5, v)) * 2.0;
}

void main() {
    float signedDist = tri(vUv.y) - 0.5;
    gl_FragColor.a *= clamp(signedDist/fwidth(signedDist) + 0.5, 0.0, 1.0);
}
{@}UnrealBloom.fs{@}uniform sampler2D tUnrealBloom;

vec3 getUnrealBloom(vec2 uv) {
    return texture2D(tUnrealBloom, uv).rgb;
}{@}UnrealBloomComposite.glsl{@}#!ATTRIBUTES

#!UNIFORMS

uniform sampler2D blurTexture1;
uniform float bloomStrength;
uniform float bloomRadius;
uniform vec3 bloomTintColor;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex.vs
void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}

#!SHADER: Fragment.fs

float lerpBloomFactor(const in float factor) {
    float mirrorFactor = 1.2 - factor;
    return mix(factor, mirrorFactor, bloomRadius);
}

void main() {
    gl_FragColor = bloomStrength * (lerpBloomFactor(1.0) * vec4(bloomTintColor, 1.0) * texture2D(blurTexture1, vUv));
}{@}UnrealBloomGaussian.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D colorTexture;
uniform vec2 texSize;
uniform vec2 direction;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex.vs
void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}

#!SHADER: Fragment.fs

float gaussianPdf(in float x, in float sigma) {
    return 0.39894 * exp(-0.5 * x * x / (sigma * sigma)) / sigma;
}

void main() {
    vec2 invSize = 1.0 / texSize;
    float fSigma = float(SIGMA);
    float weightSum = gaussianPdf(0.0, fSigma);
    vec3 diffuseSum = texture2D( colorTexture, vUv).rgb * weightSum;
    for(int i = 1; i < KERNEL_RADIUS; i ++) {
        float x = float(i);
        float w = gaussianPdf(x, fSigma);
        vec2 uvOffset = direction * invSize * x;
        vec3 sample1 = texture2D( colorTexture, vUv + uvOffset).rgb;
        vec3 sample2 = texture2D( colorTexture, vUv - uvOffset).rgb;
        diffuseSum += (sample1 + sample2) * w;
        weightSum += 2.0 * w;
    }
    gl_FragColor = vec4(diffuseSum/weightSum, 1.0);
}{@}UnrealBloomLuminosity.glsl{@}#!ATTRIBUTES

#!UNIFORMS
uniform sampler2D tDiffuse;
uniform vec3 defaultColor;
uniform float defaultOpacity;
uniform float luminosityThreshold;
uniform float smoothWidth;

#!VARYINGS
varying vec2 vUv;

#!SHADER: Vertex.vs
void main() {
    vUv = uv;
    gl_Position = vec4(position, 1.0);
}

#!SHADER: Fragment.fs

#require(luma.fs)

void main() {
    vec4 texel = texture2D(tDiffuse, vUv);
    float v = luma(texel.xyz);
    vec4 outputColor = vec4(defaultColor.rgb, defaultOpacity);
    float alpha = smoothstep(luminosityThreshold, luminosityThreshold + smoothWidth, v);
    gl_FragColor = mix(outputColor, texel, alpha);
}{@}UnrealBloomPass.fs{@}#require(UnrealBloom.fs)

void main() {
    vec4 color = texture2D(tDiffuse, vUv);
    color.rgb += getUnrealBloom(vUv);
    gl_FragColor = color;
}{@}luma.fs{@}float luma(vec3 color) {
  return dot(color, vec3(0.299, 0.587, 0.114));
}

float luma(vec4 color) {
  return dot(color.rgb, vec3(0.299, 0.587, 0.114));
}