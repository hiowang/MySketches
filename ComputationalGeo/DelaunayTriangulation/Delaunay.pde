
PVector bigTriA=new PVector(-1000, -1000);
PVector bigTriB=new PVector(10000, -1000);
PVector bigTriC=new PVector(-1000, 10000);

ArrayList<Tri>triangulate(ArrayList<PVector>points) {
  //ArrayList<Tri>list=new ArrayList<Tri>();
  Tri bigTri=new Tri();
  bigTri.a=bigTriA;
  bigTri.b=bigTriB;
  bigTri.c=bigTriC;
  tris.clear();
  tris.add(bigTri);
  for (PVector point : points) {
    delaunayPoint(point);
  }
  return tris;
}
void remBads() {
  ArrayList<Tri>badTris=new ArrayList<Tri>();
  for (Tri t : tris) {
    if (isBadTri(t))badTris.add(t);
  }
  //tris.removeAll(badTris);
}
boolean isBadTri(Tri t) {
  ArrayList<PVector>list=new ArrayList<PVector>();
  list.add(t.a);
  list.add(t.b);
  list.add(t.c);
  return list.contains(bigTriA)||list.contains(bigTriB)||list.contains(bigTriC);
}
void delaunayPoint(PVector point) {
  ArrayList<Tri>badTris=new ArrayList<Tri>();
  for (int i=0; i<tris.size(); i++) {
    Tri tri=tris.get(i);
    PVector center=circumCenter(tri);
    float rad=circumRad(tri, center);
    if (PVector.dist(center, point)<rad) {
      badTris.add(tri);
    }
  }
  //ArrayList<Line>lineList=new ArrayList<Line>();
  ArrayList<Line>allLines=new ArrayList<Line>();
  ArrayList<Tri>newTris=new ArrayList<Tri>();
  for (Tri t : badTris) {
    allLines.add(t.lineAB());
    allLines.add(t.lineBC());
    allLines.add(t.lineAC());
  }
  for (Tri t : badTris) {
    Line ab=t.lineAB();
    Line bc=t.lineBC();
    Line ac=t.lineAC();
    if (numOccur(ab, allLines)==1)newTris.add(new Tri(t.a, t.b, point));
    if (numOccur(bc, allLines)==1)newTris.add(new Tri(t.b, t.c, point));
    if (numOccur(ac, allLines)==1)newTris.add(new Tri(t.a, t.c, point));
  }
  tris.removeAll(badTris);
  tris.addAll(newTris);
}
int numOccur(Line l, ArrayList<Line>list) {
  int n=0;
  for (Line l1 : list)if (l.equals(l1))n++;
  return n;
}