ArrayList<PVector>points;
void setup(){
  size(500,500);
  //fullScreen();
  displayDensity(1);
  initPoints();
}
int scale=2;
int numPoints=0;
void initPoints(){
  points=new ArrayList<PVector>();
  for(int i=0;i<numPoints;i++){
    points.add(new PVector(random(width),random(height)));
  }
}
void mousePressed(){
  //initPoints();
  points.add(new PVector(mouseX,mouseY));
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
  float[][]grid=new float[width/scale][height/scale];
  float[][]secgrid=new float[width/scale][height/scale];
  float mi=1000,ma=0;
  for(int x=0;x<width/scale;x++){
    for(int y=0;y<height/scale;y++){
      float rx=x*scale;
      float ry=y*scale;
      PVector here=new PVector(rx,ry);
      float closestDist=10000;
      for(PVector p:points){
        float d=p.dist(here);
        if(d<closestDist)closestDist=d;
      }
      float secclosestDist=2000;
      for(PVector p:points){
        float d=p.dist(here);
        if(d<secclosestDist&&d>closestDist)secclosestDist=d;
      }
      grid[x][y]=-closestDist;
      secgrid[x][y]=-secclosestDist;
      if(grid[x][y]<mi)mi=grid[x][y];
      if(grid[x][y]>ma)ma=grid[x][y];
    }
  }
  rmi=lerp(mi,rmi,0.9);
  rma=lerp(ma,rma,0.9);
  for(int x=0;x<width/scale;x++){
    for(int y=0;y<height/scale;y++){
      int val=(int)map(grid[x][y],rmi,rma,0,255);
      if(abs(grid[x][y]-secgrid[x][y])<2)val=color(255,131,0);
      fill(val);
      noStroke();
      rect(x*scale,y*scale,scale,scale);
    }
  }
  for(PVector p:points){
    fill(255,0,0);
    ellipse(p.x-5,p.y-5,10,10);
  }
}