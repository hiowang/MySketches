void draw(){
  background(255);
  displayControls();
  displayTitle();
  displayFloor();
  displayStats();
  displayInfo();
  if(isSimulating)for(Edge e:edges)e.update();
  for(Edge e:edges){
    e.display();
    //if(isSimulating)e.update();
  }
  for(Point p:points){
    p.display();
  }
  Point intersectionP=intersectionPoint();
  if(intersectionP!=null){
    setCol(pointHoverColor);
    ellipse(intersectionP.posx,intersectionP.posy,PointSelectSize*2,PointSelectSize*2);
  }
  Edge intersectionE=intersectionEdge();
  if(intersectionE!=null){
    setCol(edgeHoverColor);
    PVector p=intersectionE.getCenter();
    ellipse(p.x,p.y,EdgeSelectSize*2,EdgeSelectSize*2);
  }
  if(pointSelectedForEdge!=null){
    setCol(pointSelectedForEdgeColor);
    ellipse(pointSelectedForEdge.posx,pointSelectedForEdge.posy,PointSelectSize*2,PointSelectSize*2);
  }
}