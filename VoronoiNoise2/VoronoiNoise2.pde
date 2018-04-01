ArrayList<PVector>points;
ArrayList<Integer>cols;
void setup(){
  size(750,750);
  //size(500,500);
  //fullScreen();
  //displayDensity(2);
  pixelDensity(2);
  println("Display density: "+displayDensity());
  initPoints();
}
int scale=1;
int numPoints=10;
void addPoint(float x,float y){
  addPoint(new PVector(x,y));
}
void addPoint(PVector p){
  points.add(p);
  cols.add(randCol());
}
void initPoints(){
  points=new ArrayList<PVector>();
  cols=new ArrayList<Integer>();
  for(int i=0;i<numPoints;i++){
    //addPoint(random(width),random(height));
    //float b=map(i,0,numPoints,0,TWO_PI);
    //addPoint(new PVector(width/2,height/2).add(new PVector(cos(b)*a,sin(b)*a)));
  }
  //for(int i=0;i<10;i++){
  //  points.add(new PVector(i*width/10,height/2));
  //  cols.add(randCol());
  //  points.add(new PVector(width/2,i*height/10));
  //  cols.add(randCol());
  //  points.add(new PVector(i*width/10,i*height/10));
  //  cols.add(randCol());
  //  points.add(new PVector(width-i*width/10,i*height/10));
  //  cols.add(randCol());
  //}
}
void mousePressed(){
//void mouseDragged(){
  //initPoints();
  points.add(new PVector(mouseX,mouseY));
  cols.add(randCol());
}
color randCol(){
  //colorMode(RGB,255);
  //return color(random(255),random(255),random(150));
  colorMode(HSB,100);
  return color(random(100),random(50)+50,100);
}
float z=0.01;
float s=20;
float rmi=100;
float rma=0;
void draw(){
  //for(int i=0;i<points.size();i++){
    //PVector p=new PVector();
    //p.x+=noise(frameCount*z,i*20)-0.5;
    //p.y+=noise(frameCount*z,i*20+10)-0.5;
    //p.x*=s*2;
    //p.y*=s*2;
    //points.set(i,points.get(i).add(p));
  //}
  for(int i=0;i<points.size();i++){
    PVector p=points.get(i);
    if(p.x<0)p.x=width;
    if(p.y<0)p.y=height;
    if(p.x>width)p.x=0;
    if(p.y>height)p.y=0;
    points.set(i,p);
  }
  color[][]grid=new color[width/scale][height/scale];
  //float[][]secgrid=new float[width/scale][height/scale];
  float mi=1000,ma=0;
  for(int x=0;x<width/scale;x++){
    for(int y=0;y<height/scale;y++){
      float rx=x*scale;
      float ry=y*scale;
      PVector here=new PVector(rx,ry);
      float closestDist=10000;
      color col=color(0);
      for(PVector p:points){
        float d=p.dist(here);
        if(d<closestDist){
          closestDist=d;
          col=cols.get(points.indexOf(p));
        }
      }
      grid[x][y]=col;
    }
  }
  rmi=lerp(mi,rmi,0.9);
  rma=lerp(ma,rma,0.9);
  for(int x=0;x<width/scale;x++){
    for(int y=0;y<height/scale;y++){
      color val=grid[x][y];
      color xmi=color(255);
      color xpl=color(255);
      color ymi=color(255);
      color ypl=color(255);
      if(x>0)xmi=grid[x-1][y];
      if(x<width/scale-1)xpl=grid[x+1][y];
      if(y>0)ymi=grid[x][y-1];
      if(y<height/scale-1)ypl=grid[x][y+1];
      if(val!=xmi||val!=xpl||val!=ymi||val!=ypl){
        //colorMode(RGB,255);
        val=color(0);
      }
      //if(abs(grid[x][y]-secgrid[x][y])<2)val=color(255,131,0);
      fill(val);
      noStroke();
      rect(x*scale,y*scale,scale,scale);
    }
  }
  for(PVector p:points){
    colorMode(RGB,255);
    fill(255);
    ellipse(p.x-5,p.y-5,10,10);
  }
}