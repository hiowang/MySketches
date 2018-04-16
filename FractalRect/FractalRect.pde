class Line {
  PVector a, b;
  Line(float a, float b, float c, float d) {
    this.a=new PVector(a, b);
    this.b=new PVector(c, d);
  }
  void display() {
    stroke(0);
    line(a.x, a.y, b.x, b.y);
  }
  ArrayList<Line>makeNew() {
    ArrayList<Line>list=new ArrayList<Line>();
    float offx=random(-f, f);
    float offy=random(-f, f);
    float cx=a.x/2+b.x/2;
    float cy=a.y/2+b.y/2;
    list.add(new Line(a.x,a.y,cx+offx,cy+offy));
    list.add(new Line(cx+offx,cy+offy,b.x,b.y));
    return list;
  }
}
float f=100;
ArrayList<Line>lines=new ArrayList<Line>();
void setup() {
  size(500, 500);
  lines.add(new Line(100, 100, 400, 100));
  lines.add(new Line(100, 100, 100, 400));
  lines.add(new Line(100, 400, 400, 400));
  lines.add(new Line(400, 100, 400, 400));
}
void draw() {
  background(255);
  for (Line l : lines) {
    l.display();
  }
}
void iterate() {
  ArrayList<Line>newLines=new ArrayList<Line>();
  for (Line l : lines)newLines.addAll(l.makeNew());
  lines.clear();
  lines.addAll(newLines);
  f*=0.4;
}
void keyPressed() {
  if(key==' ')iterate();
}