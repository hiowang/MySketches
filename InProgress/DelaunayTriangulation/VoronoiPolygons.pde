void calcVoronoiPolygons(){
  voronoi.clear();
  //Polygon poly=new Polygon();
  //for(Triangle t1:triangulation){
  //  for(Triangle t2:triangulation){
  //    if(t1.id==t2.id)continue;
  //    if(!isAdjacent(t1,t2))continue;
  //    PVector a=t1.center();
  //    PVector b=t2.center();
  //    poly.lines.add(new Line(a,b));
  //  }
  //}
  //voronoi.add(poly);
  for(PVector p:points){
    Polygon poly=new Polygon();
    poly.lines=new ArrayList<Line>();
    for(Triangle t1:triangulation){
      ArrayList<PVector>p1=t1.getPoints();
      if(!p1.contains(p))continue;
      for(Triangle t2:triangulation){
        
        
        if(t1.id<=t2.id)continue;
        ArrayList<PVector>p2=t2.getPoints();
        if(!isAdjacent(t1,t2))continue;
        if(!p2.contains(p))continue;
        poly.lines.add(new Line(t1.circum().center,t2.circum().center));
      }
    }
    voronoi.add(poly);
  }
}
boolean isTriOnEdge(Triangle t){
  int n=0;
  for(Triangle t1:triangulation){
    if(t.id==t1.id)continue;
    if(isAdjacent(t1,t))n++;
  }
  return n==2;
}