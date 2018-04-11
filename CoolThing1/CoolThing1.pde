void setup() {
  size(500, 500);

  //endShape(CLOSE);
}
float rot=0;
void draw() {
  background(0);
  noFill();
  stroke(255);
  rot+=0.01;
  float cur=0;
  float ang=0;
  float r=0;
  int n=100;
  translate(width/2, height/2);
  strokeWeight(0.01);
  for (int i=0; i<n; i++) {
    myShape(0, 0, 2, 2,float(i)/n);
    scale(1.1);
    rotate(TWO_PI/n+rot/(i*i+1));
  }
}
void myShape(float x,float y,float w,float h,float f){
  colorMode(HSB,100);
  stroke(f*mouseX/5,mouseY/5,(mouseX+mouseY)/2/5);
  colorMode(RGB,255);
  ellipseMode(CENTER);
  rectMode(CENTER);
  ellipse(x,y,w,h);
  rect(x,y,w,h);
}