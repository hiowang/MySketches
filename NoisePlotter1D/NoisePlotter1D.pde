void setup(){
  size(1000,1000);
  osn=new OpenSimplexNoise();
}
void draw(){
  background(100);
  stroke(255);
  //fill(0);
  noFill();
  beginShape();
  for(int x=0;x<width;x+=10){
    vertex(x,height-map(noise(x*0.005,frameCount*0.01),-1,1,0,height));
  }
  endShape();
}
OpenSimplexNoise osn;
float noise(float x, float y) {
  return (float)osn.eval(x, y);
}