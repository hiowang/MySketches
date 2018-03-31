import processing.video.*;

Capture vid;
void setup(){
  size(640,480);
  vid=new Capture(this,640,480);
  vid.start();
}
int ind(int x,int y){
  return (vid.width-x-1)+y*vid.width;
}
void draw(){
  background(0);
  if(vid.available()){
    vid.read();
  }
  vid.loadPixels();
  float d=5;
  for(int x=0;x<width;x+=d){
    for(int y=0;y<height;y+=d){
      color col=vid.pixels[ind(x,y)];
      //color col=color(255);
      //col*=noise(x*0.001,y*0.001);
      float v=1-abs(-noise(x*0.001,y*0.001,frameCount*0.01)+0.5)*2;
      //This looks like a smoke effect, to change copy and go to VidViz2
      col=color(red(col)*v,green(col)*v,blue(col)*v);
      colorMode(HSB);
      col=color(hue(col),saturation(col),brightness(col));
      colorMode(RGB);
      fill(col);
      stroke(col);
      rect(x,y,d,d);
    }
  }
}