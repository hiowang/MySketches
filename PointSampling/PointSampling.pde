
//The voronoi function is taken from VoronoiNoise2.pde
//This just jitters points until a certain "non-clustered" condition is met.
//The points are non-clustered when each point is more than 50 pixels away from each other point.
//Once the points satisfy the non-cluster condition, the voronoi diagram is drawn
//to vizualize the seperation.
//Press the mouse to generate a new set of points.
//It also draws lines between point less than 2*dist pixels away from eachother to visualize the clustering amount.

ArrayList<PVector>points=new ArrayList<PVector>();
ArrayList<Integer>cols=new ArrayList<Integer>();
void setup(){
  size(500,500);
  //pixelDensity(2);
  //width*=2;
  //height*=2;
  doInit();
}
void doInit(){
  scale=4;
  drawn=false;
  points.clear();
  cols.clear();
  for(int i=0;i<250;i++){//40
    addPoint(new PVector(random(width),random(height)));
  }
  //while(iterate()>10){
    //println(iterate());
  //}
}
void mousePressed(){
  doInit();
}
void addPoint(PVector p){
  points.add(p);
  cols.add(randCol());
}
color randCol(){
  //colorMode(RGB,255);
  //return color(random(255),random(255),random(150));
  colorMode(HSB,100);
  color c=color(random(100),random(50)+50,100);
  colorMode(RGB,255);
  return c;
}
float dist=20;//50
boolean drawn=false;
int lastIters=100000;
void draw(){
  //width*=2;
  //height*=2;
  for(int x=0;x<5;x++)display();
  //width/=2;
  //height/=2;
}
void display(){
  if(drawn)return;
  lastIters=iterate();
  println(lastIters);
  if(lastIters<10){
    scale=1;
    drawn=true;
  }
  
  //if(drawn)return;
  background(0);
  //drawn=true;
  drawVoronoi();
  for(int i1=0;i1<points.size();i1++){
    PVector p1=points.get(i1);
    fill(255);
    ellipse(p1.x,p1.y,5,5);
    noFill();
    stroke(100);
    ellipse(p1.x,p1.y,dist,dist);
    for(int i2=0;i2<points.size();i2++){
      PVector p2=points.get(i2);
      if(p1.dist(p2)<dist*2){
        //stroke(0,200);
        stroke(0,200);
        line(p1.x,p1.y,p2.x,p2.y);
      }
    }
  }
}
int iterate(){
  int num=0;
  for(int i1=0;i1<points.size();i1++){
    PVector p1=points.get(i1);
    for(int i2=0;i2<points.size();i2++){
      if(i1==i2)continue;
      PVector p2=points.get(i2);
      if(p1.dist(p2)<dist){
        points.set(i1,jitter(p1));
        points.set(i2,jitter(p2));
        num++;
      }
    }
  }
  return num;
}
int scale=300;
void drawVoronoi(){
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
      if(scale==1)set(x,y,val);
      else{
        fill(val);
        noStroke();
        rect(x*scale,y*scale,scale,scale);
      }
    }
  }
}
float j=3;
PVector jitter(PVector p){
  p= new PVector(p.x+random(-j,j),p.y+random(-j,j));
  if(p.x<0)p.x=0;
  if(p.y<0)p.y=0;
  if(p.x>width)p.x=width;
  if(p.y>height)p.y=height;
  return p;
}