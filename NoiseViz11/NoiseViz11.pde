void setup(){
  size(1000,1000);
  background(21,8,50);
  osn=new OpenSimplexNoise();
}
void draw(){
  float d=1;
  for(int x=0;x<width;x+=d){
    for(int y=0;y<height;y+=d){
      float n=noise(x*0.01,y*0.01);
      int i=int(n*100);
      //colorMode(HSB,100);
      //if(i%10==0)fill(n*100,100,100);
      //else fill(0,0,0);
      //if(d!=1)rect(x,y,d,d);
      set(x,y,abs(i)%29<=1?color(n*255+255):0);
    }
  }
}
OpenSimplexNoise osn;
float noise(float x, float y) {
  return (float)osn.eval(x, y);
}