void setup() {
  size(1000, 1000);
  background(21, 8, 50);
  doInit();
}
void doInit() {
  osn=new OpenSimplexNoise();
}
void mousePressed() {
  doInit();
}
void draw() {
  smooth();
  colorMode(HSB,100);
  for(int i=0;i<100;i++){
  PVector a=rand();
  PVector b=PVector.add(a,PVector.random2D().mult(10));
  stroke(noise(a.x*0.01,a.y*0.01)*100,100,100);
  line(a.x,a.y,b.x,b.y);
  }
}
PVector rand(){
  return new PVector(random(width),random(height));
}
OpenSimplexNoise osn;
float noise(float x, float y) {
  return (float)osn.eval(x, y);
}