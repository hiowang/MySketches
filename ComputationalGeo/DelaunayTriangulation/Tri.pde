class Tri{
  PVector a,b,c;
  Tri(){
  }
  Tri(PVector _1,PVector _2,PVector _3){
    a=_1;
    b=_2;
    c=_3;
  }
  PVector pointAB(){
    return PVector.add(a,b).mult(0.5);
  }
  PVector pointBC(){
    return PVector.add(b,c).mult(0.5);
  }
  PVector pointAC(){
    return PVector.add(a,c).mult(0.5);
  }
  Line lineAB(){
    Line l=new Line();
    l.a=a;
    l.b=b;
    return l;
  }
  Line lineBC(){
    Line l=new Line();
    l.a=b;
    l.b=c;
    return l;
  }
  Line lineAC(){
    Line l=new Line();
    l.a=a;
    l.b=c;
    return l;
  }
  boolean contains (PVector pt){
    boolean b1, b2, b3;

    b1 = sign(pt, a, b) < 0.0f;
    b2 = sign(pt, b, c) < 0.0f;
    b3 = sign(pt, c, a) < 0.0f;

    return ((b1 == b2) && (b2 == b3));
  }
}
void triDraw(Tri t){
  stroke(255,50);
  lineDraw(t.lineAB());
  lineDraw(t.lineBC());
  lineDraw(t.lineAC());
}
float circumRad(Tri tri,PVector center){
  return center.dist(tri.a);
}
PVector circumCenter(Tri tri){
  Line l1=perpBisectorLine(tri.lineAB(),10);
  Line l2=perpBisectorLine(tri.lineBC(),10);
  return lineIntersection(l1,l2);
  
}
float sign (PVector p1, PVector p2, PVector p3){
  return (p1.x - p3.x) * (p2.y - p3.y) - (p2.x - p3.x) * (p1.y - p3.y);
}