import processing.video.*;

Capture cap;
void settings(){
  size(640,480);
}
void setup(){
  cap=new Capture(this,320,240);
  cap.start();
}
void draw(){
  if(cap.available()){
    //background(0,0,0);
    colorMode(RGB,255);
    cap.read();
    cap.loadPixels();
    float minr=255,maxr=0;
    float ming=255,maxg=0;
    float minb=255,maxb=0;
    for(int x=0;x<320;x++){
      for(int y=0;y<240;y++){
        color c=cap.get(x,y);
        float r=hue(c);
        float g=saturation(c);
        float b=brightness(c);
        if(r<minr)minr=r;
        if(r>maxr)maxr=r;
        if(g<ming)ming=g;
        if(g>maxg)maxg=g;
        if(b<minb)minb=b;
        if(b>maxb)maxb=b;
      }
    }
    PGraphics mapped=createGraphics(320,240);
    //mapped.loadPixels();
    mapped.beginDraw();
    for(int x=0;x<320;x++){
      for(int y=0;y<240;y++){
        color c=cap.get(x,y);
        float r=hue(c);
        float g=saturation(c);
        float b=brightness(c);
        float s1=1;
        float s2=1;
        float s3=1;
        r=map(r,minr*s1,maxr*s1,0,255);
        g=map(g,ming*s2,maxg*s2,0,255);
        b=map(b,minb*s3,maxb*s3,0,255);
        mapped.set(x,y,color(r,g,b,40));
      }
    }
    mapped.endDraw();
    image(mapped,0,0,width,height);
  }
}