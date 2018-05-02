void doTriangulation(){
  tris.clear();
  tris.add(new Triangle(50,50,450,50,50,450));
  for(PVector point : points){
    Triangle badTri=null;
    for(Triangle tri:tris){
      if(tri.contains(point)){
        badTri=tri;
      }
    }
    if(badTri==null)continue;
    tris.remove(badTri);
    tris.add(new Triangle(point,badTri.p2,badTri.p3));
    tris.add(new Triangle(badTri.p1,point,badTri.p3));
    tris.add(new Triangle(badTri.p1,badTri.p2,point));
  }
}