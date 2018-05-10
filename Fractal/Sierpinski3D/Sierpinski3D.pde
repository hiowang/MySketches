class Tri {
  PVector a, b, c, d;
  float cr, cg, cb;
  Tri(float p1, float p2, float p3, float p4, float p5, float p6, float p7, float p8, float p9, float p10, float p11, float p12) {
    a=new PVector(p1, p2, p3);
    b=new PVector(p4, p5, p6);
    c=new PVector(p7, p8, p9);
    d=new PVector(p10, p11, p12);
    //cr=cg=cb=0;
    cr=random(255);
    cg=random(255);
    cb=random(255);
  }
  Tri(PVector p1, PVector p2, PVector p3, PVector p4, float _cr, float _cg, float _cb, boolean bool) {
    a=p1.copy();
    b=p2.copy();
    c=p3.copy();
    d=p4.copy();
    float diff;
    if (!bool) {
      diff=0;
    } else {
      diff=p1.dist(p2)/4;
    }
    this.cr=constrain(random(_cr-diff, _cr+diff),0,255);
    this.cg=constrain(random(_cg-diff, _cg+diff),0,255);
    this.cb=constrain(random(_cb-diff, _cb+diff),0,255);
  }
  ArrayList<Tri>makeNew() {
    ArrayList<Tri>list=new ArrayList<Tri>();
    float t_ab=randT();
    float t_bc=randT();
    float t_ac=randT();
    float t_ad=randT();
    float t_bd=randT();
    float t_cd=randT();
    PVector ab=lerp(a, b, t_ab);
    PVector ac=lerp(a, c, t_ac);
    PVector ad=lerp(a, d, t_ad);
    PVector bc=lerp(b, c, t_bc);
    PVector bd=lerp(b, d, t_bd);
    PVector cd=lerp(c, d, t_cd);
    //PVector ab=new PVector(lerp(a.x, b.x, t_ab), lerp(a.y, b.y, t_ab));
    //PVector bc=new PVector(lerp(b.x, c.x, t_bc), lerp(b.y, c.y, t_bc));
    //PVector ac=new PVector(lerp(a.x, c.x, t_ac), lerp(a.y, c.y, t_ac));
    //PVector ad=new PVector(lerp(a.x, d.x, t_ad), lerp(a.y, d.y, t_ad));
    //PVector bd=new PVector(lerp(b.x, d.x, t_bd), lerp(b.y, d.y, t_bd));
    //PVector cd=new PVector(lerp(c.x, d.x, t_cd), lerp(c.y, d.y, t_cd));
    list.add(new Tri(a, ab, ac, ad, cr, cg, cb, true));
    list.add(new Tri(b, ab, bc, bd, cr, cg, cb, true));
    list.add(new Tri(c, ac, bc, cd, cr, cg, cb, true));
    list.add(new Tri(d, ad, bd, cd, cr, cg, cb, true));
    return list;
  }
  float randT() {
    //return random(1);//More skinny triangles
    //return random(0.2,0.8);//nicely sized random triangles
    //return random(0.3,0.7);
    //return random(0.4, 0.6);//slightly distorted sierpinski triangle
    
    return 0.5;//Normal Sierpinski triangle
  }
  void display() {
    noFill();
    //fill(255,0);
    fill(cr,cg,cb);
    //stroke(cr, cg, cb, 20);
    noStroke();
    doShape(a, b, c);
    doShape(a, b, d);
    doShape(a, c, d);
    doShape(b, c, d);
    //line(a,b);
    //line(a,c);
    //line(a,d);
    //line(b,c);
    //line(b,d);
    //line(c,d);
  }
  Tri scaleCoords(float f) {
    return new Tri(a.mult(f), b.mult(f), c.mult(f), d.mult(f), cr, cg, cb, true);
  }
}
void doShape(PVector a, PVector b, PVector c) {
  beginShape();
  vertex(a);
  vertex(b);
  vertex(c);
  endShape(CLOSE);
}
void vertex(PVector v) {
  vertex(v.x, v.y, v.z);
}
PVector lerp(PVector a, PVector b, float t) {
  return new PVector(lerp(a.x, b.x, t), lerp(a.y, b.y, t), lerp(a.z, b.z, t));
}

void line(PVector a, PVector b) {
  line(a.x, a.y, a.z, b.x, b.y, b.z);
}
ArrayList<Tri>work=new ArrayList<Tri>(), finish=new ArrayList<Tri>();

void setup() {
  size(1024, 1024, P3D);
  pixelDensity(2);
  work.add(new Tri(-1, 1, 1, 1, -1, 1, 1, 1, -1, -1, -1, -1).scaleCoords(200));
  //work.add(new Tri(new PVector(-256,-256,
}
float rotX=0, rotY=0;
boolean isA=false, isD=false, isW=false, isS=false;

void keyPressed() {
  if (key=='a')isA=!isA;
  if (key=='d')isD=!isD;
  if (key=='w')isW=!isW;
  if (key=='s')isS=!isS;

  if (key==' ')isA=isD=isW=isS=false;
}
void draw() {
  background(255);
  if (isW)rotX-=0.01;
  if (isS)rotX+=0.01;
  if (isA)rotY-=0.01;
  if (isD)rotY+=0.01;
  camera(600, 600, 600, 0, 0, 0, 0, 1, 0);
  rotateY(rotY);
  rotateX(rotX);
  for (Tri t : finish) {
    t.display();
  }
}
void iterate() {
  ArrayList<Tri>list=new ArrayList<Tri>();
  for (Tri t : work)list.addAll(t.makeNew());
  finish.clear();
  finish.addAll(work);
  work.clear();
  work.addAll(list);
}
void mousePressed() {
  iterate();
}