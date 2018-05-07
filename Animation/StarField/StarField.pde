
ArrayList<Line>lines;
void setup() {
  size(500,500);
  lines=new ArrayList<Line>();
  for (int i=0; i<20; i++) {
    lines.add(new Line(rand(), rand()));
  }
}
float rand() {
  return (float)Math.random()*900-450;
  //if(Math.random()<0.5)return random(-200,-100);
  //return random(100,200);
}
void draw() {
  background(0);
  for (int i=0; i<30; i++) {
    lines.add(new Line(rand(), rand()));
  }
  for (Line l : lines) {
    pushMatrix();
    translate(width/2, height/2);
    l.doStuff();
    popMatrix();
  }
  removeExtraLines();
}
void removeExtraLines() {
  for (Line l : lines) {
    if (sqrt(sq(l.offx)+sq(l.offy))>500) {
      lines.remove(l);
      removeExtraLines();
      return;
    }
  }
}
float speed=300;
class Line {
  PVector start;
  float offx, offy;
  Line(float x, float y) {
    start=new PVector(x, y);
    //offx=offy=0.1;
    //offx=start.x>1?1:-1;
    //offy=start.y>1?1:-1;
    offx=start.x;
    offy=start.y;
  }
  void doStuff() {
    stroke(200);
    fill(255);
    //ellipse(start.x+offx, start.y+offy, 5, 5);
    line(start.x+offx/2,start.y+offy/2,start.x+offx,start.y+offy);
    offx*=1.10;
    offy*=1.10;
  }
}