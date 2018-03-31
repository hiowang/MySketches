void setCol(color c){
  fill(c);
  stroke(c);
}
void displayFloor(){
  setCol(color(0));
  line(floorHeight,height-floorHeight,width-floorHeight,height-floorHeight);
}
void removeEdgesWithPoint(Point p){
  for(int i=0;i<edges.size();i++){
    Edge edge=edges.get(i);
    if(edge.a==p||edge.b==p){
      edges.remove(edge);
      removeEdgesWithPoint(p);
    }
  }
}
void displayStats(){
  setCol(color(0));
  textFont(fontNormal);
  textAlign(RIGHT,TOP);
  text("is simulating: "+(isSimulating?"yes":"no"),width-2,2+textDiff*0);
  text("gravity: "+gravity,width-2,2+textDiff*1);
  text("selected variable: "+(varMode==null?"none":varMode==VarMode.EdgeK?"edge tension":varMode==VarMode.PointMass?"point mass":varMode==VarMode.EdgeType?"edge type":"edge length"),width-2,2+textDiff*2);
  text("# edges: "+edges.size(),width-2,2+textDiff*3);
  text("# points: "+points.size(),width-2,2+textDiff*4);
  
  String txt="selected variable value: none";
  Edge e=intersectionEdge();
  Point p=intersectionPoint();
  if(varMode==VarMode.EdgeK&&e!=null){
    txt="selected edge tension: "+nf(e.k,1,2);
  }
  if(varMode==VarMode.PointMass&&p!=null){
    txt="selected point mass: "+nf(p.mass,3,2);
  }
  if(varMode==VarMode.EdgeType&&e!=null){
    txt="selected edge type: "+e.stringType();
  }
  if(varMode==VarMode.EdgeLength&&e!=null){
    txt="selected edge length: "+nf(e.origDist,4,0);
  }
  text(txt,width-2,2+textDiff*6);
}
void displayTitle(){
  setCol(colTitle);
  textFont(fontLarge);
  textAlign(LEFT,TOP);
  text("constructor v"+versionNumberFormatted,2,2+textDiff*0);
}
void displayInfo(){
  textAlign(LEFT,BOTTOM);
  setCol(color(0));
  textFont(fontNormal);
  text("current file: "+currentFile,0,height);
}
void displayControls(){
  textAlign(LEFT,TOP);
  setCol(color(0));
  textFont(fontNormal);
  text("' ' - pause/unpause simulation",2,2+textDiff*2);
  text("'p' - make point",2,2+textDiff*3);
  text("'e' - make edge",2,2+textDiff*4);
  text("'d' - remove point/edge",2,2+textDiff*5);
  text("'k' - select edge tension variable",2,2+textDiff*6);
  text("'m' - select point mass variable",2,2+textDiff*7);
  text("'f' - toggle fixed point",2,2+textDiff*8);
  text("'t' - select edge type variable",2,2+textDiff*9);
  text("'l' - select edge length variable",2,2+textDiff*10);
  text("'o' - open from file",2,2+textDiff*11);
  text("'s' - save to file",2,2+textDiff*12);
  
  text("'+' - add to selected variable",2,2+textDiff*14);
  text("'-' - subtract from selected variable",2,2+textDiff*15);
}
Edge intersectionEdge(){
  for(Edge e:edges){
    PVector c=e.getCenter();
    if(sqrt(sq(c.x-mouseX)+sq(c.y-mouseY))<EdgeSelectSize)return e;
  }
  return null;
}
Point intersectionPoint(){
  for(Point p:points){
    if(sqrt(sq(p.posx-mouseX)+sq(p.posy-mouseY))<PointSelectSize)return p;
  }
  return null;
}