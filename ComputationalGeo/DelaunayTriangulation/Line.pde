class Line {
  PVector a, b;
  Line(){
  } 
  public boolean equals(Object o){
    if(o instanceof Line){
      Line l=(Line)o;
      return (a.equals(l.a)&&b.equals(l.b))||(a.equals(l.b)&&b.equals(l.a));
    }
    return false;
  }
  float len(){
    return PVector.dist(a,b);
  }

  Line(PVector _1,PVector _2){
    a=_1;
    b=_2;
  }
}
void lineDraw(Line l){
  line(l.a.x,l.a.y,l.b.x,l.b.y);
}
PVector lineIntersection(Line line1,Line line2){
    float x1=line1.a.x;
    float y1=line1.a.y;
    
    float x2=line1.b.x;
    float y2=line1.b.y;
    
    float x3=line2.a.x;
    float y3=line2.a.y;
    
    float x4=line2.b.x;
    float y4=line2.b.y;
    //float x=det2x2( det2x2(x1, y1, x2, y2), det2x2(x1, 1, x2, 1), det2x2(x3, y3, x4, y4), det2x2(x3, 1, x4, 1) )
      /// det2x2( det2x2(x1, 1, x2, 1), det2x2(y1, 1, y1, 1), det2x2(x3, 1, x4, 1), det2x2(y3, 1, y4, 1));
    //float y=det2x2(det2x2(x1, y1, x2, y2), det2x2(y1, 1, y2, 1), det2x2(x3, y3, x4, y4), det2x2(y3, 1, y4, 1))/det2x2(det2x2(x1, 1, x2, 1), det2x2(y1, 1, y2, 1), det2x2(x3, 1, x4, 1), det2x2(y3, 1, y4, 1));
    float x=((x1*y2-y1*x2)*(x3-x4)-(x1-x2)*(x3*y4-y3*x4))/( (x1-x2)*(y3-y4)-(y1-y2)*(x3-x4));
    float y=((x1*y2-y1*x2)*(y3-y4)-(y1-y2)*(x3*y4-y3*x4))/( (x1-x2)*(y3-y4)-(y1-y2)*(x3-x4));
    return new PVector(x, y);
}
Line perpBisectorLine(Line line,float lineLength){
  PVector center=PVector.add(line.a,line.b).mult(0.5);
  Line result=new Line();
  PVector diff=PVector.sub(line.a,center);
  diff.rotate(radians(90));
  diff.setMag(lineLength);
  result.a=center.copy().add(diff);
  result.b=center.copy().sub(diff);
  return result;
}

//a b
//c d
float det2x2(float a, float b, float c, float d) {
  return a*d-b*c;
}