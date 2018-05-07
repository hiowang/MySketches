void initTris(){
  rem1=new PVector(-width,-height);
  rem2=new PVector(width*2,0);
  rem3=new PVector(0,height*2);
  triangulation=new ArrayList<Triangle>();
  triangulation.add(new Triangle(rem1,rem2,rem3));
  ensureAddedPoint(new PVector(0,0));
  ensureAddedPoint(new PVector(width,0));
  ensureAddedPoint(new PVector(0,height));
  ensureAddedPoint(new PVector(width,height));
}
void ensureAddedPoint(PVector p){
  if(points.size()<10)return;
  if(!points.contains(p))addPoint(p);
}

PVector rem1,rem2,rem3;
void doCalculationsForPoint(PVector point){
  ArrayList<Triangle>badTris=new ArrayList<Triangle>();
  for(Triangle t:triangulation){
    if(t.circum().contains(point))badTris.add(t);
  }
  triangulation.remove(badTris);
  
  Polygon poly=new Polygon();
  ArrayList<Line>allLines=new ArrayList<Line>();
  for(Triangle t:badTris)allLines.addAll(t.getLines());
  
  for(Triangle t:badTris){
    ArrayList<Line>lines=t.getLines();
    for(Line l:lines){
      if(lineListContains(allLines,l)==1)poly.lines.add(l);
    }
  }
  
  for(Line l:poly.lines){
    triangulation.add(new Triangle(l.a,l.b,point));
  }
  
  triangulation.removeAll(badTris);
  
}