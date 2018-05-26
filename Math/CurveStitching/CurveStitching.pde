void setup(){
  fullScreen();
  points=new ArrayList<PVector>();
  for(int r=200;r<=400;r+=50){
    float n=5;
    for(float theta=0;theta<TWO_PI;theta+=radians(360/n)){
      PVector p=PVector.fromAngle(theta);
      points.add(PVector.mult(p,r).add(new PVector(width/2,height/2)));
    }
  }
}
void mousePressed(){
  points.add(new PVector(mouseX,mouseY));
}
ArrayList<PVector>points;
int num=50;
void curveStitch(PVector center,PVector pa,PVector pb){
  
  stroke(0,1);
  //line(center.x,center.y,p1.x,p1.y);
  //line(center.x,center.y,p2.x,p2.y);
   for(int i=0;i<=num;i++){
    //for(int j=0;j<num;j++){
      float ti=1.0*i/num;
      float tj=1.0*(num-i)/num;
      PVector pi=lerp(center,pa,ti);
      PVector pj=lerp(center,pb,tj);
      line(pi.x,pi.y,pj.x,pj.y);
    //}
  }
}
void draw(){
  background(255);
  PVector center=new PVector(width/2,height/2);
  for(int i=0;i<points.size();i++){
    for(int j=0;j<points.size();j++){
      if(i==j)continue;
      curveStitch(center,points.get(i),points.get(j));
    }
    //PVector last;
    //if(i==0)last=points.get(points.size()-1);
    //else last=points.get(i-1);
    //curveStitch(center,points.get(i),last);
  }
}
PVector lerp(PVector a,PVector b,float t){
  return new PVector(lerp(a.x,b.x,t),lerp(a.y,b.y,t));
}