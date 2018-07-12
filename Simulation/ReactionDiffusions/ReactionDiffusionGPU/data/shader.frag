//ReactionDiffusionGPU
#ifdef GL_ES
precision highp float;
#endif

#define PROCESSING_COLOR_SHADER

uniform vec2 resolution;
uniform vec2 mouse;
uniform int frameCount;
uniform vec2 center;
uniform sampler2D ppixels;

vec4 col(vec2 p){
    return texture2D(ppixels,p);
}

float get_a(vec2 p){
    return col(p).x;
}

float get_b(vec2 p){
    return col(p).y;
}

vec4 make_col(float a,float b){
    return vec4(a,b,0.0,1.0);
}


void main( void ) {
    vec2 pos = ( gl_FragCoord.xy / resolution.xy );
    vec2 pixel = 1.0/resolution;
    
    float a=get_a(pos);
    float b=get_b(pos);
    
    vec2 pos_00=pos+vec2(-1.0,-1.0)*pixel;
    vec2 pos_01=pos+vec2(-1.0, 0.0)*pixel;
    vec2 pos_02=pos+vec2(-1.0, 1.0)*pixel;
    vec2 pos_10=pos+vec2( 0.0,-1.0)*pixel;
    vec2 pos_11=pos+vec2( 0.0, 0.0)*pixel;
    vec2 pos_12=pos+vec2( 0.0, 1.0)*pixel;
    vec2 pos_20=pos+vec2( 1.0,-1.0)*pixel;
    vec2 pos_21=pos+vec2( 1.0, 0.0)*pixel;
    vec2 pos_22=pos+vec2( 1.0, 1.0)*pixel;
    
    float laplaceA=
    +0.05*get_a(pos_00)
    +0.2 *get_a(pos_01)
    +0.05*get_a(pos_02)
    +0.2 *get_a(pos_10)
    -1.0 *get_a(pos_11)
    +0.2 *get_a(pos_12)
    +0.05*get_a(pos_20)
    +0.2 *get_a(pos_21)
    +0.05*get_a(pos_22);
    float laplaceB=
    +0.05*get_b(pos_00)
    +0.2 *get_b(pos_01)
    +0.05*get_b(pos_02)
    +0.2 *get_b(pos_10)
    -1.0 *get_b(pos_11)
    +0.2 *get_b(pos_12)
    +0.05*get_b(pos_20)
    +0.2 *get_b(pos_21)
    +0.05*get_b(pos_22);
    
    float D_a=1.0;
    float D_b=0.5;
    float f=0.055;
    float k=0.062;
    float dt=1.0;
    
    float da=D_a*laplaceA-a*b*b+f*(1.0-a);
    float db=D_b*laplaceB+a*b*b-(k+f)*b;
    
    a+=da*dt;
    b+=db*dt;
    
    gl_FragColor=make_col(a,b);
    
}
