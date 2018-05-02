void doTriangulation() {
  println("New triangulation: frameCount="+frameCount);
  tris.clear();
  PVector rem1=new PVector(0, 0);
  PVector rem2=new PVector(width, 0);
  PVector rem3=new PVector(0, height);
  PVector rem4=new PVector(width,height);
  //points.add(rem1);
  //points.add(rem2);
  //points.add(rem3);
  tris.add(new Triangle(rem1, rem2, rem3));
  tris.add(new Triangle(rem2, rem3, rem4));
  for (PVector point : points) {
    boyerWatson(point);
    //tris.removeAll(badTris);
  }
  ArrayList<Triangle>rems=new ArrayList<Triangle>();
  for (Triangle t : tris) {
    ArrayList<PVector>p=t.getPoints();
    if (
    p.contains(rem1)||p.contains(rem2)||p.contains(rem3)||p.contains(rem4)||
    !t.isGood())rems.add(t);
  }
  
  tris.removeAll(rems);
}


void boyerWatson(PVector point) {
  ArrayList<Triangle>badTris=new ArrayList<Triangle>();
  for (int i=0; i<tris.size(); i++) {
    if (tris.get(i).circum().contains(point)) {
      badTris.add(tris.get(i));
      //println("BadTRI");
    }
  }
  for(Triangle t:badTris)tris.remove(t);
  ArrayList<Line>polygon=new ArrayList<Line>();
  ArrayList<Line>allLines=new ArrayList<Line>();
  for (Triangle t : badTris) {
    //t.display(color(255, 0, 0, 10));
    ArrayList<Line>lines=t.getLines();
    for (Line l : lines)if (!contains(allLines, l))allLines.add(l);
  }
  for (Triangle t : badTris) {
    ArrayList<Line>lines=t.getLines();
    for (Line l : lines) {
      if (numContains(allLines, l)==1) {
        polygon.add(l);
        //println("polyline "+polygon.size());
      }
    }
  }

  for (Line l : polygon) {
    Triangle newTri=new Triangle(l.a, l.b, point);
    tris.add(newTri);
    //newTri.display(color(0, 255, 0, 50));
  }
}