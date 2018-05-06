//Insipred by: https://www.fal-works.com/creative-coding-posts/generative-something

ArrayList<PVector>points;
void setup(){
  size(1024,1024);
  points=new ArrayList<PVector>();
  background(255);
  for(int i=0;i<5;i++){
    addPoint(random(width),random(height));
  }
}
void addPoint(float x,float y){
  PVector p=new PVector(x,y);
  points.add(p);
}
void mousePressed(){
  addPoint(mouseX,mouseY);
}
void draw(){
  fill(255,20);
  noStroke();
  rect(0,0,width,height);
  
  stroke(255,0,0,10);
  noFill();
  beginShape();
  for(PVector p:points){
    curveVertex(p.x,p.y);
  }
  endShape();
  for(PVector p:points){
    fill(0);
    //ellipse(p.x,p.y,2,2);
  }
  for(int i=0;i<points.size();i++){
    float zoom=0.01;
    float offx=noise(i*100,0+frameCount*zoom)-0.5;
    float offy=noise(i*100,100+frameCount*zoom)-0.5;
    offx*=40;
    offy*=40;
    float x=points.get(i).x+offx;
    float y=points.get(i).y+offy;
    if(x<0)x=width;
    if(y<0)y=height;
    if(x>width)x=0;
    if(y>height)y=0;
    points.set(i,new PVector(x,y));
  }
}