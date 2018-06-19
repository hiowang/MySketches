
#ifdef GL_ES
precision highp float;
#endif

#define PROCESSING_COLOR_SHADER

//uniform float time;
//uniform vec2 mouse;
uniform vec2 resolution;
uniform sampler2D ppixels;

uniform float slope;
uniform float cx;
uniform float cy;
uniform float diff;
uniform float maxDist;

vec4 live = vec4(0.5,1.0,0.7,1.);
vec4 dead = vec4(0.,0.,0.,1.);
vec4 blue = vec4(0.,0.,1.,1.);

void main( void ) {
    vec2 position = ( gl_FragCoord.xy / resolution.xy );
    vec2 pixel = 1./resolution;
    vec4 me = texture2D(ppixels, position);
    float f=me.x;
    float x=position.x;
    float y=position.y;
    if(length(vec2(cx,cy)-position)<maxDist){
        if( slope*(x-cx)+cy<y)f+=diff;
        else f-=diff;
    }
    
    if(f<0.0)f=0.0;
    if(f>1.0)f=1.0;
    gl_FragColor=vec4(f,f,f,1.0);
}
