void keyPressed() {
  if (key==' ') {
    isSimulating=!isSimulating;
    //for(Edge e:edges)e.update();
    varMode=null;
  } else if (key=='p') {
    Point p=new Point(mouseX, mouseY);
    points.add(p);
    varMode=null;
  } else if (key=='d') {
    Point ip=intersectionPoint();
    if (ip!=null) {
      removeEdgesWithPoint(ip);
      points.remove(ip);
    }
    Edge ie=intersectionEdge();
    if (ie!=null) {
      edges.remove(ie);
    }
    varMode=null;
  } else if (key=='f') {
    Point p=intersectionPoint();
    if (p!=null) {
      p.fixed=!p.fixed;
    }
    varMode=null;
  } else if (key=='k') {
    varMode=VarMode.EdgeK;
  } else if (key=='m') {
    varMode=VarMode.PointMass;
  } else if (key=='t') {
    varMode=VarMode.EdgeType;
  } else if (key=='l') {
    varMode=VarMode.EdgeLength;
  } else if (key=='+'||key=='=') {
    if (varMode==VarMode.EdgeK) {
      Edge e=intersectionEdge();
      if (e!=null) {
        e.k+=0.1;
        e.constrainK();
      }
    }
    if (varMode==VarMode.PointMass) {
      Point p=intersectionPoint();
      if (p!=null) {
        p.mass+=5;
        p.constrainMass();
      }
    }
    if (varMode==VarMode.EdgeType) {
      Edge e=intersectionEdge();
      if (e!=null) {
        if (e.type==EdgeType.Normal)e.type=EdgeType.MuscleJerky;
        else if (e.type==EdgeType.MuscleJerky)e.type=EdgeType.MuscleSmooth;
        else if (e.type==EdgeType.MuscleSmooth)e.type=EdgeType.Normal;
      }
    }
    if (varMode==VarMode.EdgeLength) {
      Edge e=intersectionEdge();
      if (e!=null) {
        e.origDist+=10;
        e.checkDistRange();
      }
    }
  } else if (key=='-'||key=='_') {
    if (varMode==VarMode.EdgeK) {
      Edge e=intersectionEdge();
      if (e!=null) {
        e.k-=0.1;
        e.constrainK();
      }
    }
    if (varMode==VarMode.PointMass) {
      Point p=intersectionPoint();
      if (p!=null) {
        p.mass-=5;
        p.constrainMass();
      }
    }
    if (varMode==VarMode.EdgeType) {
      Edge e=intersectionEdge();
      if (e!=null) {
        if (e.type==EdgeType.Normal)e.type=EdgeType.MuscleJerky;
        else if (e.type==EdgeType.MuscleJerky)e.type=EdgeType.MuscleSmooth;
        else if (e.type==EdgeType.MuscleSmooth)e.type=EdgeType.Normal;
      }
    }
    if (varMode==VarMode.EdgeLength) {
      Edge e=intersectionEdge();
      if (e!=null) {
        e.origDist-=10;
        e.checkDistRange();
      }
    }
  }else if(key=='o'){
    varMode=null;
    selectInput("Select a file to open: ","fileSelectedInput",new File(workspaceFile));
  }else if(key=='s'){
    varMode=null;
    selectOutput("Select a file to write to: ","fileSelectedOutput",new File(currentFile));
  }else{
    varMode=null;
  }
}