class Source {
  float f=0, x=0, y=0, r=0,a=250;
  void update() {
    r+=1;
    //f+=0.5;
    a+=0;
    noStroke();
    fill(func(f)*a);
    ellipseMode(CENTER);
    ellipse(x, y, r, r);
  }
}
float func(float f) {
  //return (cos(f)+40)/41;
  //return (cos(f)+1)/2;
  return 0;
}
ArrayList<Source>sources=new ArrayList<Source>();
void setup() {
  size(500, 500);
  background(#009FFF);
}
void mousePressed() {
  Source s=new Source();
  s.x=mouseX;
  s.y=mouseY;
  sources.add(s);
}
void draw() {
  fill(255);
  rect(0, 0, width, height);
  for (Source s : sources) {
    s.update();
  }
}