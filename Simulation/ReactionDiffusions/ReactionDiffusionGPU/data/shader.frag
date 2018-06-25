
#ifdef GL_ES
precision highp float;
#endif

#define PROCESSING_COLOR_SHADER

uniform vec2 resolution;
uniform sampler2D ppixels;
uniform vec2 mouse;
uniform bool mousePressed;

float getA(vec2 p){
    if(p.x<0.0||p.y<0.0||p.x>1.0||p.y>1.0)return 0.0;
    return texture2D(ppixels,p).x;
}
float getB(vec2 p){
    if(p.x<0.0||p.y<0.0||p.x>1.0||p.y>1.0)return 0.0;
    return texture2D(ppixels,p).y;
}
vec4 getCol(float a,float b){
    return vec4(a,b,0.0,1.0);
}

bool inrange(float t,float mi,float ma){
    return t>mi&&t<ma;
}

void main( void ) {
    vec2 position = ( gl_FragCoord.xy / resolution.xy );
    vec2 pixel = 1.0/resolution;
//    position*=resolution;
//    position=round(position);
//    position/=resolution;
    vec2 pos00=position+vec2(-1.0,-1.0)*pixel;
    vec2 pos01=position+vec2(-1.0, 0.0)*pixel;
    vec2 pos02=position+vec2(-1.0, 1.0)*pixel;
    vec2 pos10=position+vec2( 0.0,-1.0)*pixel;
    vec2 pos11=position+vec2( 0.0, 0.0)*pixel;
    vec2 pos12=position+vec2( 0.0, 1.0)*pixel;
    vec2 pos20=position+vec2( 1.0,-1.0)*pixel;
    vec2 pos21=position+vec2( 1.0, 0.0)*pixel;
    vec2 pos22=position+vec2( 1.0, 1.0)*pixel;
    
    float Da=1.0;
    float Db=0.5;
    float f=0.055;
    float k=0.062;
    float dt=1.0;
    
    float a=getA(position);
    float b=getB(position);
    float a00=getA(pos00);
    float a01=getA(pos01);
    float a02=getA(pos02);
    float a10=getA(pos10);
    float a11=getA(pos11);
    float a12=getA(pos12);
    float a20=getA(pos20);
    float a21=getA(pos21);
    float a22=getA(pos22);
    
    float b00=getB(pos00);
    float b01=getB(pos01);
    float b02=getB(pos02);
    float b10=getB(pos10);
    float b11=getB(pos11);
    float b12=getB(pos12);
    float b20=getB(pos20);
    float b21=getB(pos21);
    float b22=getB(pos22);
    float diff=0.01;
    if(mousePressed&&inrange(position.x,mouse.x-diff,mouse.x+diff)&&inrange(position.y,mouse.y-diff,mouse.y+diff))b=1.0;
    
    float laplaceA=0.05*(a00+a20+a02+a22)+0.2*(a01+a10+a21+a12)-a11;
    float laplaceB=0.05*(b00+b20+b02+b22)+0.2*(b01+b10+b21+b12)-b11;
    
    float diffA=Da*laplaceA-a*b*b+f*(1.0-a);
    float diffB=Db*laplaceB+a*b*b-(k+f)*b;
    diffA*=dt;
    diffB*=dt;
    a+=diffA;
    b+=diffB;
    if(a<0.0)a=0.0;
    if(a>1.0)a=1.0;
    if(b<0.0)b=0.0;
    if(b>1.0)b=1.0;
    
    
    gl_FragColor=getCol(a,b);

}
