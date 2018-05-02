int totalID=0;

class Triangle {
  PVector p1, p2, p3;
  int id;
  Triangle(float a, float b, float c, float d, float f, float g) {
    p1=new PVector(a, b);
    p2=new PVector(c, d);
    p3=new PVector(f, g);
    id=totalID++;
  }
  ArrayList<Line>getLines(){
    ArrayList<Line>list=new ArrayList<Line>();
    list.add(new Line(p1,p2));
    list.add(new Line(p2,p3));
    list.add(new Line(p3,p1));
    return list;
  }
  Triangle(PVector a, PVector b, PVector c) {
    p1=a;
    p2=b;
    p3=c;
    id=totalID++;
  }
  
  PVector center(){
    return PVector.add(PVector.add(p1,p2),p3).mult(1.0/3.0);
    //return ;
  }
  
  int numPointsInside(){
    int i=0;
    Circle circum=circum();
    ArrayList<PVector>thePoints=getPoints();
    for(PVector p:points)if(circum.contains(p)&&!thePoints.contains(p))i++;
    return i;
  }
  
  ArrayList<PVector>getPoints(){
    ArrayList<PVector>list=new ArrayList<PVector>();
    list.add(p1);
    list.add(p2);
    list.add(p3);
    return list;
  }
  
  boolean isGood(){
    return numPointsInside()==0;
  }

  boolean contains (PVector pt){
    boolean b1, b2, b3;

    b1 = sign(pt, p1, p2) < 0.0f;
    b2 = sign(pt, p2, p3) < 0.0f;
    b3 = sign(pt, p3, p1) < 0.0f;

    return ((b1 == b2) && (b2 == b3));
  }
  void display(color str) {
    stroke(str);
    noFill();
    //stroke(0,0,0);
    //line(p1.x,p1.y,p2.x,p2.y);
    //stroke(255,0,0);
    //line(p2.x,p2.y,p3.x,p3.y);
    //stroke(0,0,255);
    //line(p3.x,p3.y,p1.x,p1.y);
    beginShape();
    vertex(p1.x, p1.y);
    vertex(p2.x, p2.y);
    vertex(p3.x, p3.y);
    endShape(CLOSE);
  }
  Circle circum() {
    float a=p1.x;
    float b=p1.y;
    float c=p2.x;
    float d=p2.y;
    float f=p3.x;
    float g=p3.y;
    float PA=(1.0/2)*(a*a*d-a*a*g+b*b*d-b*b*g-b*c*c-b*d*d+b*f*f+b*g*g+c*c*g+d*d*g-d*f*f-d*g*g)/(a*d-a*g-b*c+b*f+c*g-d*f);
    float PB=-(1.0/2)*(a*a*c-a*a*f-a*c*c-a*d*d+a*f*f+a*g*g+b*b*c-b*b*f+c*c*f-c*f*f-c*g*g+d*d*f)/(a*d-a*g-b*c+b*f+c*g-d*f);
    Circle cir=new Circle();
    cir.center=new PVector(PA, PB);
    cir.r=dist(a, b, PA, PB);
    return cir;
  }
}
float sign (PVector p1, PVector p2, PVector p3){
  return (p1.x - p3.x) * (p2.y - p3.y) - (p2.x - p3.x) * (p1.y - p3.y);
}