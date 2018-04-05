void setup(){
  size(1000,1000);
  background(21,8,50);
  osn=new OpenSimplexNoise((long)(Long.MAX_VALUE*Math.random()));
}
void draw(){
  int d=1;
  for(int x=0;x<width;x+=d){
    for(int y=0;y<height;y+=d){
      float n=noise(x*0.001,y*0.001);
      float xmi=calc(x-1,y);
      float xpl=calc(x+1,y);
      float ymi=calc(x,y-1);
      float ypl=calc(x,y+1);
      colorMode(HSB,100);
      color col=color(n*50+50,100,100);
      if(abs(xmi-n)+abs(xpl-n)+abs(ymi-n)+abs(ypl-n)<0.25)doit(d,x,y,col);
      else doit(d,x,y,0);
      int i=int(n*100);
      //float xmi=ca
    }
  }
}
void doit(int d,int x,int y,color c){
  if(d==1)set(x,y,c);
  else {
    fill(c);
    noStroke();
    rect(x,y,d,d);
  }
}
float calc(float x,float y){
  return noise(x*0.01,y*0.01);
}
OpenSimplexNoise osn;
float noise(float x, float y) {
  return (float)osn.eval(x, y);
}