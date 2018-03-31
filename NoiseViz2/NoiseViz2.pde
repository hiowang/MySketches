void setup(){
  size(500,500);
  background(255);
}
float noiseZoom=0.01;
float noiseChange=0.1;
float perlin(float x,float y){
  return noise(noiseZoom*x,noiseZoom*y,noiseChange*frameCount);
}
void draw(){
  fill(255,75);
  stroke(255,75);
  rect(0,0,width,height);
  float s=10;
  for(int x=0;x<width/s;x++){
    for(int y=0;y<height/s;y++){
      float val=perlin(x*s,y*s);
      val*=TWO_PI;
      float lineLength=s;
      stroke(0);
      line(x*s,y*s,x*s+cos(val)*lineLength,y*s+sin(val)*lineLength);
    }
  }
}