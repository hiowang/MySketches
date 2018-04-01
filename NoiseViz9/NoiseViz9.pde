void setup() {
  size(1000,1000);
  //fullScreen();
  //pixelDensity(2);
}
boolean drawn=false;
float a=0;
void draw(){
  //if(!drawn)drawn=true;
  //else return;
  float d=10;
  float zoom=0.001;
  a+=0.01;
  for (int x=0; x<width; x+=d) {
    for (int y=0; y<height; y+=d) {
      float r=ridgeO(zoom*x+100,zoom*y+100,a)*255;
      float g=ridgeO(zoom*x+0,zoom*y+200,a)*255;
      float b=ridgeO(zoom*x-100,zoom*y+300,a)*255;
      color col=color(r,g,b);
      if(hsb){
        colorMode(HSB,255);
        col=color(r,g,b);
        colorMode(RGB,255);
      }
      //set(x,y,col);
      fill(col);
      stroke(col);
      rect(x,y,d,d);
    }
  }
}
boolean hsb=false;
void keyPressed(){
  if(key=='h'){
    hsb=!hsb;
    drawn=false;
  }
}
float ridgeO(float x,float y,float z){
  return ridge(x,y,z)*0.75+ridge(x*20,y*20,z*5)*0.25;
  //float amp=4;
  //float zoom=1;
  //float tot=0;
  //for(int o=1;o<2;o++){
    //tot+=ridge(x*zoom,y*zoom,z)*amp;
    //amp*=0.5;
    //zoom*=0.1;
  //}
  //return tot/12;
}
float ridge(float x, float y,float z) {
  float n=noise(x,y,z);
  //return 1-2*abs(n-0.5);
  return n;
  //n-=0.5;
  //n=abs(n);
  //n*=2;
  //return n;
}