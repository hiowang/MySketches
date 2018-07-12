//AbelianSandpileGPU
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

float num(vec2 p){
    return col(p).x*4.0;
}

void main( void ) {
    vec2 pos = ( gl_FragCoord.xy / resolution.xy );
    vec2 pixel = 1./resolution;
    
    float xmi=num(pos+vec2(-pixel.x,0));
    float xpl=num(pos+vec2( pixel.x,0));
    float ymi=num(pos+vec2(0,-pixel.y));
    float ypl=num(pos+vec2(0, pixel.y));
    float me=num(pos);
    
    if(me>=4.0){
        me-=4.0;
    }
    if(xmi>=4.0){
        me++;
    }
    if(ymi>=4.0){
        me++;
    }
    if(xpl>=4.0){
        me++;
    }
    if(ypl>=4.0){
        me++;
    }
//    if(length(pos-center)<=length(pixel))me=4.0;
    gl_FragColor=vec4(vec3(me/4.0),1.0);
    
}
