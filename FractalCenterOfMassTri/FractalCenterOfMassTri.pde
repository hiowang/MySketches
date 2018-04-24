class Tri {
  PVector a, b, c;
  Tri(PVector a, PVector b, PVector c) {
    this.a=a;
    this.b=b;
    this.c=c;
  }
  ArrayList<Tri>makeNew() {
    ArrayList<Tri>list=new ArrayList<Tri>();
    PVector p=new PVector(a.x/3+b.x/3+c.x/3,a.y/3+b.y/3+c.y/3);
    PVector ab=avg(a,b);
    PVector bc=avg(b,c);
    PVector ac=avg(a,c);
    //list.add(new Tri(a,b,ab));
    //list.add(new Tri(a,ac,c));
    //list.add(new Tri(bc,b,c));
    
    list.add(new Tri(ab,ac,a));
    list.add(new Tri(ab,bc,b));
    list.add(new Tri(bc,ac,c));
    
    //list.add(new Tri(a, b, p));
    //list.add(new Tri(a, p, c));
    //list.add(new Tri(p, b, c));
    
    //list.add(new Tri(a,ab,p));
    //list.add(new Tri(ab,b,p));
    //list.add(new Tri(a,ac,p));
    
    //list.add(new Tri(c,ac,p));
    //list.add(new Tri(b,bc,p));
    //list.add(new Tri(c,bc,p));
    return list;
  }
  void display(color col) {
    stroke(col);
    noFill();
    beginShape();
    vertex(a.x, a.y);
    vertex(b.x, b.y);
    vertex(c.x, c.y);
    endShape(CLOSE);
  }
}
PVector avg(PVector a,PVector b){
  return PVector.add(a,b).mult(0.5);
}
ArrayList<Tri>work=new ArrayList<Tri>(), finished=new ArrayList<Tri>();
void setup() {
  size(600, 500);
  work.add(new Tri(new PVector(width/2, 50), new PVector(width-10, height-10), new PVector(10, height-10)));
  //work.add(new Tri(new PVector(0,0),new PVector(width,0),new PVector(0,height)));
  //work.add(new Tri(new PVector(width,height),new PVector(width,0),new PVector(0,height)));
}
boolean workFirst=false;
void keyPressed() {
  if (key=='w')workFirst=!workFirst;
}
color workCol=color(255,20);
color finCol=color(0,20);
void draw() {
  background(255);
  if (workFirst) {
    for (Tri t : work) {
      t.display(workCol);
    }
  }
  for (Tri t : finished) {
    t.display(finCol);
  }
  if (!workFirst) {
    for (Tri t : work) {
      t.display(workCol);
    }
  }
}
void mousePressed() {
  ArrayList<Tri>list=new ArrayList<Tri>();
  for (Tri t : work)list.addAll(t.makeNew());
  finished.addAll(work);
  work.clear();
  work.addAll(list);
}