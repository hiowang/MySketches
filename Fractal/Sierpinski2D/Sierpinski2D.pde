class Tri {
  PVector a, b, c;
  Tri(float p1, float p2, float p3, float p4, float p5, float p6) {
    a=new PVector(p1, p2);
    b=new PVector(p3, p4);
    c=new PVector(p5, p6);
  }
  Tri(PVector p1, PVector p2, PVector p3) {
    a=p1.copy();
    b=p2.copy();
    c=p3.copy();
  }
  ArrayList<Tri>makeNew() {
    ArrayList<Tri>list=new ArrayList<Tri>();
    float t_ab=randT();
    float t_bc=randT();
    float t_ac=randT();
    PVector ab=new PVector(lerp(a.x, b.x, t_ab), lerp(a.y, b.y, t_ab));
    PVector bc=new PVector(lerp(b.x, c.x, t_bc), lerp(b.y, c.y, t_bc));
    PVector ac=new PVector(lerp(a.x, c.x, t_ac), lerp(a.y, c.y, t_ac));
    list.add(new Tri(a, ab, ac));
    list.add(new Tri(b, ab, bc));
    list.add(new Tri(c, ac, bc));
    return list;
  }
  float randT() {
    //return random(1);//More skinny triangles
    //return random(0.2,0.8);//nicely sized random triangles
    return random(0.4, 0.6);//slightly distorted sierpinski triangle
    //return 0.5;//Normal Sierpinski triangle
  }
  void display() {
    noFill();
    stroke(0, 20);
    line(a.x, a.y, b.x, b.y);
    line(b.x, b.y, c.x, c.y);
    line(c.x, c.y, a.x, a.y);
  }
}
ArrayList<Tri>work=new ArrayList<Tri>(), finish=new ArrayList<Tri>();

void setup() {
  size(1024, 1024);
  pixelDensity(2);
  work.add(new Tri(width/2, 50, 50, height-50, width-50, height-50));
}
void draw() {
  background(255);
  for (Tri t : finish) {
    t.display();
  }
}
void iterate() {
  ArrayList<Tri>list=new ArrayList<Tri>();
  for (Tri t : work)list.addAll(t.makeNew());
  finish.addAll(work);
  work.clear();
  work.addAll(list);
}
void mousePressed() {
  iterate();
}