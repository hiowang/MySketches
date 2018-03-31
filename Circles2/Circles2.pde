class Circle{
  PVector center;
  float rad;
  float alpha=0;
  float lineAlpha=0;
  ArrayList<Circle>children=new ArrayList<Circle>();
  boolean collides(Circle other){
    return center.dist(other.center)<=rad/3+other.rad/3;
  }
  float seed=0;
  Circle(){
    seed=random(1000);
  }
  float z=0.01;
  float s=50;
  void update(){
    center.x+=noise(seed+frameCount*z)*s-s/2;
    center.y+=noise(seed+frameCount*z+10)*s-s/2;
    if(center.x<0)center.x=width;
    if(center.y<0)center.y=height;
    if(center.x>width)center.x=0;
    if(center.y>height)center.y=0;
  }
  void draw(float r){
    if(r<5){
      alpha=1;
      lineAlpha=255;
    }else{
      alpha=r/10;
      lineAlpha=alpha-5;
    }
    alpha=20;
    lineAlpha=1;
    fill(100,100,255,alpha);
    noStroke();
    rect(center.x,center.y,rad,rad);
    //ellipse(center.x,center.y,rad,rad);
  }
}
ArrayList<Circle> circs=new ArrayList<Circle>();
void setup(){
  //size(1000,1000);
  fullScreen();
  doInit();
}
int numIter=4;
int newMi=3;
int newMa=4;
float total;
float estimateLength(){
  //return pow(newMi+newMa-1,numIter);
  float avg=0.5*newMi+0.5*newMa;
  return pow(avg,numIter+2)-1;
}
int num=0;
void doInit(){
  num=0;
  total=estimateLength();
  //background(255);
  circs.clear();
  drawCirc(new PVector(width/2,height/2),500,numIter);
  println("Estimate: "+total);
  println("Actual: "+num);
  
}
PVector offset(PVector p,float r){
  return new PVector(p.x+random(-r/3,r/3),p.y+random(-r/3,r/3));
}
Circle drawCirc(PVector p,float r,int numLeft){
  Circle circ=new Circle();
  circ.center=p;
  circ.rad=r;
  circs.add(circ);
  //circ.draw(r);
  num++;
  println(100*num/total+"%");
  if(numLeft<0)return null;
  for(int i=0;i<random(newMi,newMa);i++)circ.children.add(drawCirc(offset(p,r*2),r/1.5,numLeft-1));
  return circ;
}
void keyPressed(){ 
  if(key==' ')doInit();
}
void draw(){
  background(0);
  for(Circle c:circs){
    //c.update();
  }
  for(Circle c:circs){
    c.draw(c.rad);
    }
    for(Circle c:circs){
      
    for(Circle c1:circs){
      if(c.collides(c1)){
        stroke(255,30);
        strokeWeight(0);
        line(c.center.x,c.center.y,c1.center.x,c1.center.y);
      }
    }
    //for(Circle c1:c.children){
      //if(c1==null)continue;
      //stroke(0,c.lineAlpha*10);
      //line(c.center.x,c.center.y,c1.center.x,c1.center.y);
    //}
  }
}