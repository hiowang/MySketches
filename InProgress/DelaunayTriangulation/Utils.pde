
boolean contains(ArrayList<Line>list, Line l) {
  for (Line line : list)if (sameLine(line, l))return true;
  return false;
}
int lineListContains(ArrayList<Line>list,Line l){
  int i=0;
  for(Line line:list)if(isLineSame(line,l))i++;
  return i;
}
boolean isLineSame(Line a,Line b){
  return (a.a.equals(b.a)&&a.b.equals(b.b))||(a.b.equals(b.a)&&a.a.equals(b.b));
}
boolean isTriSame(Triangle a,Triangle b){
  ArrayList<PVector>p1=a.getPoints();
  ArrayList<PVector>p2=b.getPoints();
  for(PVector p:p2)if(p1.contains(p))p1.remove(p);
  return p1.size()==0;
}
float theDist(float a1,float a2,float b1,float b2){
  //return abs(a1-b1)+abs(a2-b2);
  return dist(a1,a2,b1,b2);
}
int numContains(ArrayList<Line>list, Line l) {
  int i=0;
  for (Line line : list)if (sameLine(line, l))i++;
  return i;
}
boolean sameLine(Line a, Line b) {
  return (a.a.equals(b.a)&&a.b.equals(b.b))||(a.b.equals(b.a)&&a.a.equals(b.b));
}
void divideTris(PVector point) {
  Triangle badTri=null;
  for (Triangle tri : triangulation) {
    if (tri.contains(point)) {
      badTri=tri;
    }
  }
  if (badTri==null)return;
  triangulation.remove(badTri);
  triangulation.add(new Triangle(point, badTri.p2, badTri.p3));
  triangulation.add(new Triangle(badTri.p1, point, badTri.p3));
  triangulation.add(new Triangle(badTri.p1, badTri.p2, point));
}
PVector uncommon(Triangle a, Triangle b) {
  ArrayList<PVector>pa=a.getPoints();
  ArrayList<PVector>pb=b.getPoints();
  for (PVector p : pa)if (pb.contains(p))pb.remove(p);
  if (pb.size()>0)return pb.get(0);
  return null;
}

boolean isAdjacent(Triangle a, Triangle b) {
  ArrayList<PVector>p1=a.getPoints();
  ArrayList<PVector>p2=b.getPoints();
  for (PVector p : p1)if (p2.contains(p))p2.remove(p);
  return p2.size()==1;
}