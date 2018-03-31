//TODO: have all features implemented BEFORE json is implemented
JSONObject edgeToJSON(Edge e){
  JSONObject obj=new JSONObject();
  obj.setInt("a",points.indexOf(e.a));
  obj.setInt("b",points.indexOf(e.b));
  obj.setFloat("dist",e.dist);
  obj.setFloat("origDist",e.origDist);
  obj.setInt("type",e.type.ordinal());
  obj.setFloat("period",e.period);
  obj.setFloat("k",e.k);
  return obj;
}
Edge edgeFromJSON(JSONObject obj){
  Edge e=new Edge(null,null,null,-1);
  e.a=points.get(obj.getInt("a"));
  e.b=points.get(obj.getInt("b"));
  e.dist=obj.getFloat("dist");
  e.origDist=obj.getFloat("origDist");
  e.type=EdgeType.values()[obj.getInt("type")];
  e.period=obj.getFloat("period");
  e.k=obj.getFloat("k");
  return e;
}

class Edge{
  Point a;
  Point b;
  float dist,origDist;
  EdgeType type;
  float period;
  float k;
  Edge(EdgeType et,Point a,Point b,float dist){
    type=et;
    this.dist=dist;
    origDist=dist;
    period=0.1;
    if(type==EdgeType.Normal)k=defUnFixedK;
    if(type==EdgeType.MuscleJerky)k=defMuscleK;
    if(type==EdgeType.MuscleSmooth)k=defMuscleK;
    this.a=a;
    this.b=b;
    //a.isInEdge=true;
    //b.isInEdge=true;
  }
  void display(){
    //a.display();
    //b.display();
    color col=color(0);
    if(type==EdgeType.MuscleSmooth)col=colEdgeMuscleSmooth;
    if(type==EdgeType.MuscleJerky)col=colEdgeMuscleJerky;
    stroke(col);
    line(a.posx,a.posy,b.posx,b.posy);
    setCol(color(map(k,minEdgeK,maxEdgeK,0,200),0,0));
    PVector center=getCenter();
    ellipse(center.x,center.y,EdgeHandleSize,EdgeHandleSize);
  }
  void checkDistRange(){
    if(origDist<minEdgeDist)origDist=minEdgeDist;
    if(origDist>maxEdgeDist)origDist=maxEdgeDist;
  }
  void constrainK(){
    if(k<minEdgeK)k=minEdgeK;
    if(k>maxEdgeK)k=maxEdgeK;
  }
  PVector getCenter(){
    return new PVector(a.posx+b.posx,a.posy+b.posy).mult(0.5);
  }
  String stringType(){
    if(type==EdgeType.Normal)return "normal";
    if(type==EdgeType.MuscleJerky) return "jerky muscle";
    if(type==EdgeType.MuscleSmooth)return "smooth muscle";
    return "none";
  }
  void update(){
    float ka=k/(a.mass/b.mass + 1);
    float kb=k-ka;
    float dx=a.posx-b.posx;
    float dy=a.posy-b.posy;
    float dmag=sqrt(sq(dx)+sq(dy));
    if(type==EdgeType.MuscleJerky)dist=origDist*(abs(cos(frameCount*period))+1)/2;
    else if(type==EdgeType.MuscleSmooth)dist=origDist*(cos(frameCount*period)+3)/4;
    else dist=origDist;
    if(dmag<1)return;
    float d=(dmag-dist)/dist;
    if(!a.fixed){
      a.update();
      a.posx-=dx*ka*d/2;
      a.posy-=dy*ka*d/2;
    }
    if(!b.fixed){
      b.update();
      b.posx+=dx*kb*d/2;
      b.posy+=dy*kb*d/2;
    }
  }
}
enum EdgeType{
  Normal,
  MuscleJerky,
  MuscleSmooth
}
  