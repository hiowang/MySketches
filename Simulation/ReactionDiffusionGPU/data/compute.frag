
#define PROCESSING_COLOR_SHADER

uniform float time;
uniform int mousePressed;
uniform float mousePressRad;
uniform vec2 mouse;
uniform vec2 resolution;
uniform sampler2D ppixels;

uniform float Da;
uniform float Db;
uniform float f;
uniform float k;
uniform float dt;

float getA(vec2 pos){
    return texture(ppixels,pos).y;
}
float getB(vec2 pos){
    return texture(ppixels,pos).z;
}

//A = red
//G = green
vec4 getCol(float a,float b){
    return vec4(0.0,a,b,1.0);
}

void main( void ) {
    vec2 position = ( gl_FragCoord.xy / resolution.xy );
//    position.x=floor(position.x);
//    position.y=floor(position.y);
    vec2 pixel = 1.0/resolution;
  
    float corner = 0.05;
    float edge = 0.2;
    float center = -1.0;
    
    float laplaceA =
    +corner * getA(position+pixel*vec2(-1.0,-1.0))
    +edge  * getA(position+pixel*vec2(-1.0, 0.0))
    +corner * getA(position+pixel*vec2(-1.0,+1.0))
    
    +edge  * getA(position+pixel*vec2( 0.0,-1.0))
    +center  * getA(position+pixel*vec2( 0.0, 0.0))
    +edge  * getA(position+pixel*vec2( 0.0,+1.0))
    
    +corner * getA(position+pixel*vec2( 1.0,-1.0))
    +edge  * getA(position+pixel*vec2( 1.0, 0.0))
    +corner * getA(position+pixel*vec2( 1.0,+1.0));
    
    float laplaceB =
    +corner * getB(position+pixel*vec2(-1.0,-1.0))
    +edge  * getB(position+pixel*vec2(-1.0, 0.0))
    +corner * getB(position+pixel*vec2(-1.0,+1.0))
    
    +edge  * getB(position+pixel*vec2( 0.0,-1.0))
    +center  * getB(position+pixel*vec2( 0.0, 0.0))
    +edge  * getB(position+pixel*vec2( 0.0,+1.0))
    
    +corner * getB(position+pixel*vec2( 1.0,-1.0))
    +edge  * getB(position+pixel*vec2( 1.0, 0.0))
    +corner * getB(position+pixel*vec2( 1.0,+1.0));
    
    float a = getA(position);
    float b = getB(position);
    
    float convert = a * b * b;
    
    float da = Da * laplaceA - convert + f * (1.0 - a);
    float db = Db * laplaceB + convert - (k + f) * b;
    
    
    float newA = a + da * dt;
    float newB = b + db * dt;
    
    if(mousePressed!=0&&clamp(mouse.x,position.x-mousePressRad,position.x+mousePressRad)==mouse.x&&
       clamp(mouse.y,position.y-mousePressRad,position.y+mousePressRad)==mouse.y){
        if(mousePressed==1)newB=1.0;
        else if(mousePressed==2)newA=1.0;
    }
    
//    newA = clamp(newA,0.0,1.0);
//    newB = clamp(newB,0.0,1.0);
//    if(newA<0.0)newA=0.0;
//    if(newB<0.0)newB=0.0;
//    if(newA>1.0)newA=1.0;
//    if(newB>1.0)newB=1.0;
    
    gl_FragColor = getCol(newA,newB);
    
}

