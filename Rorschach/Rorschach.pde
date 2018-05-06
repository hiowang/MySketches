//Inspired by: https://www.fal-works.com/creative-coding-posts/rorschach

ArrayList<PVector>points1=new ArrayList<PVector>();
ArrayList<PVector>points2=new ArrayList<PVector>();
void setup(){
  size(1024,1024);
  for(int i=0;i<30;i++){
    PVector p=new PVector(width/2,random(0,height-0));
    points1.add(p.copy().add(0,0));
    points2.add(p.copy().add(0,0));
    //points1.add(new PVector(width/2,random(100,height-100)));
    //points2.add(new PVector(width/2,random(100,height-100)));
  }
  background(200,200,255);
  frameRate(10000);
}
void draw(){
  noFill();
  stroke(0,0,255,2);
  beginShape();
  //vertex(width/2,0);
  for(PVector p:points1){
    curveVertex(p.x,p.y);
  }
  //vertex(width/2,height);
  endShape();
  float xScale=random(0,1);
  float yScale=2*0.5;
  float zoom=0.01;
  for(int i=0;i<points1.size();i++){
    float x=noise(frameCount*zoom+i*100,0)*xScale;
    float y=(noise(frameCount*zoom+i*100,100)-0.5)*yScale;
    points1.set(i,points1.get(i).add(x,y));
  }
  beginShape();
  //vertex(width/2,0);
  for(PVector p:points2){
    curveVertex(p.x,p.y);
  }
  //vertex(width/2,height);
  endShape();
  
  for(int i=0;i<points2.size();i++){
    float x=-noise(frameCount*zoom+i*100,0)*xScale;
    float y=(noise(frameCount*zoom+i*100,100)-0.5)*yScale;
    points2.set(i,points2.get(i).add(x,y));
  }
}