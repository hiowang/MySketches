class Tri{
  PVector a,b,c;
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
}
void triDraw(Tri t){
  stroke(0);
  line(t.a.x,t.a.y,t.b.x,t.b.y);
  line(t.b.x,t.b.y,t.c.x,t.c.y);
  line(t.c.x,t.c.y,t.a.x,t.a.y);
}
float circumRad(Tri tri,PVector center){
  return center.dist(tri.a);
}
PVector circumCenter(Tri tri){
  Line l1=perpBisectorLine(tri.lineAB(),10);
  Line l2=perpBisectorLine(tri.lineBC(),10);
  return lineIntersection(l1,l2);
  
}