void setup(){
  size(500,500);
  background(255);
}
float noiseZoom=0.01;
float noiseChange=0.01;
float perlin(float x,float y){
  return noise(noiseZoom*x,noiseZoom*y,noiseChange*frameCount);
}
void draw(){
  fill(255,2);
  stroke(255,2);
  rect(0,0,width,height);
  float s=10;
  for(int x=0;x<width/s;x++){
    for(int y=0;y<height/s;y++){
      float val=perlin(x*s,y*s);
      //val*=TWO_PI;
      float lineLength=10;
      float lineX=0;
      float lineY=0;
      float xmi=perlin(x*s-s,y*s);
      float xpl=perlin(x*s+s,y*s);
      float ymi=perlin(x*s,y*s-s);
      float ypl=perlin(x*s,y*s+s);
      if(xmi<xpl){lineX=-1;}
      if(xmi>xpl){lineX=1;}
      if(ymi<ypl){lineY=-1;}
      if(ymi>ypl){lineY=1;}
      lineX/=2;
      lineY/=2;
      stroke(0);
      colorMode(HSB,100);
      stroke(val*100,100,100);
      colorMode(RGB,255);
      line(x*s,y*s,x*s+lineX*lineLength,y*s+lineY*lineLength);
    }
  }
}