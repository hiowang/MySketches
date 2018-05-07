ArrayList<PVector>points;
void doInit(){
  points=new ArrayList<PVector>();
  for(int i=0;i<0;i++){
    points.add(new PVector(random(width),random(height)));
  }
}
void setup(){
  size(500,500);
  doInit();
}
void keyPressed(){
  if(key==' ')doInit();
}
void draw(){
  background(255);
  stroke(0);
  noFill();
  for(int i=0;i<100;i++)points.add(new PVector(random(width),random(height)));
  ellipse(width/2,height/2,width,height);
  float numIn=0;
  float numOut=0;
  for(PVector p:points){
    if(p.dist(new PVector(width/2,height/2))<width/2){
      numIn++;
      fill(0,255,0);
      stroke(0,255,0);
    }
    else{
      numOut++;
      fill(255,0,0);
      stroke(255,0,0);
    }
    ellipse(p.x,p.y,1,1);
  }
  //numIn/numOut=pi*r^2 / (4-pi)*r^2=pi/(4-pi)
  //numIn=pi*width*width/4
  //numIn*=numOut;
  //numIn/= width/numOut;
  //numIn/= width/numOut;
  //numIn*=4;
  float num=numIn+numOut;
  float myPi=4/(numOut/numIn+1);
  //numIn/numOut=pi
  //numIn/=numOut;
  //numIn=
  //numIn/=num/4;
  fill(0);
  stroke(0);
  textAlign(LEFT,TOP);
  textSize(20);
  text("pi="+PI,0,0);
  text("approx pi="+myPi,0,20);
  text("diff="+abs(PI-myPi),0,40);
  text("num="+num,0,60);
  text("numIn="+numIn,0,80);
  text("numOut="+numOut,0,100);
}