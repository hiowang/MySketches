void setup(){
  //size(500,500);
  fullScreen();
  for(int x=0;x<width;x++){
    for(int y=0;y<height;y++){
      //colorMode(HSB,100);
      float val=calc(x,y);
      set(x,y,color(val*255));
    }
  }
}
float calc(float x,float y){
  float z=0.0025;
  //x*=z;
  //y*=z;
  //return pow(noise(x,y),noise(x+100,y+100));
  //return sigmoid(x*z-y*z);
  return noise(x*z,y*z);
}
float sigmoid(float a){
  return 1/(1+exp(-a));
}
      