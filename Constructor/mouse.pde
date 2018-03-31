void mousePressed(){
  if(key=='e'){
    if(pointSelectedForEdge==null){
      pointSelectedForEdge=intersectionPoint();
    }else{
      Point p1=pointSelectedForEdge;
      Point p2=intersectionPoint();
      if(p2!=null){
        if(p1==p2){
          pointSelectedForEdge=null;
          return;
        }
        Edge e=new Edge(EdgeType.Normal,p1,p2,100);
        edges.add(e);
        pointSelectedForEdge=null;
      }
    }
  }
}