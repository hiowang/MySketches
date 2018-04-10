void setup() {
  size(500, 500);
}
void draw() {
  background(100);
  fill(255);
  noFill();
  stroke(150);
  stroke(255);
  for (float t=-PI; t<PI; t+=0.01) {
    PVector pos=formula(t).mult(100);
    vertex(width/2+pos.x, height/2+pos.y);
  }
  ArrayList<PVector>list=new ArrayList<PVector>();
  float largestMag=0;
  for (float t=-PI; t<PI; t+=0.01) {
    PVector p=formula(t);
    list.add(p);
    float mag=p.mag();
    if (mag>largestMag)largestMag=mag;
  }
  beginShape();
  for (PVector p : list) {
    p.mult(min(width/2, height/2)-50);
    p.mult(1.0/largestMag);
    vertex(p.x+width/2, p.y+height/2);
  }
  endShape(CLOSE);
  noFill();
  stroke(0);
  //rect(50,50,min(width,height)-100,min(width,height)-100);
  float val=0.1;
  a=lerp(a, ta, val);
  b=lerp(b, tb, val);
  n1=lerp(n1, tn1, val);
  n2=lerp(n2, tn2, val);
  n3=lerp(n3, tn3, val);
  y=lerp(y, ty, val);
  z=lerp(z, tz, val);
  float z=0.01;
  if (frameCount%60==0) {
    ty=random(2, 6);
    tz=random(2, 6);
    tn1=random(1, 8);
    tn2=random(1, 8);
    tn3=random(1, 8);
    ta=random(0, 2);
    tb=random(0, 2);
  }
  //m=noise(frameCount*z);
  //a=noise(frameCount*z+10);
  //b=noise(frameCount*z+20);
  //a=b=1;
  //n1=noise(frameCount*z+30)*4-2;
  //n2=noise(frameCount*z+40)*4-2;
  //n3=noise(frameCount*z+50)*4-2;
  //n1=float(mouseX)/width;
  //n3=float(mouseY)/height;
}
void mousePressed() {
  //y=4;
  //z=6;
  //n1=n2=n3=3;
  //a=b=1;
  //m1=random(0,2);
  //m2=random(0,2);
}
float ty=1, tz=1, tn1=1, tn2=1, tn3=1, ta=1, tb=1;
float y=1;
float z=1;
float n1=1;
float n2=1;
float n3=1;
float a=1;
float b=1;
PVector formula(float t) {
  float r=pow(pow(abs(cos(y*t/4)/a), n2)+pow(abs(sin(z*t/4)/b), n3), -1/n1);
  return new PVector(cos(t)*r, sin(t)*r);
}