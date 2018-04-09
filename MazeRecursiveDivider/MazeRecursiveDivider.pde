import java.util.Stack;

class Edge {
  //PVector start,finish;
  boolean right=true, down=true;//+x,+y;
  //Edge(float a,float b,float c,float d){
  //start=new PVector(a,b);
  //finish=new PVector(c,d);
  //}
}
int cellSize=10;
int gridSize=int(pow(2,4)+2);
//int gridSize=100;
//int cellSize=5;
Edge[][] grid;
void setup() {
  size(500, 500);
  randomSeed(int(random(100000)));
  cellSize=width/gridSize;
  Rect r=new Rect(0,0,gridSize-2,gridSize-2);
  //r.x=1;
  //r.y=1;
  //r.w=gridSize-2;
  //r.h=gridSize-2;
  rects.add(r);
  grid=new Edge[gridSize][gridSize];

  for (int x=0; x<gridSize; x++) {
    for (int y=0; y<gridSize; y++) {
      grid[x][y]=new Edge();
    }
  }
}
//ArrayList<Edge>edges=new ArrayList<Edge>();
ArrayList<PVector> stack=new ArrayList<PVector>();
void myLine(float a, float b, float c, float d) {
  line(a*cellSize, b*cellSize, c*cellSize, d*cellSize);
}
void draw() {
  background(100);
  boolean done=retraced.size()>=gridSize*gridSize;
  //noStroke();
  //int i=0;
  for (PVector p : visited) {
    //fill(255, 0, 0);
    fill(#AA70CE);
    stroke(#AA70CE);
    //color col=color(map(i, 0, visited.size(), 0, 255), 0, 0);
    //fill(col);
    //stroke(col);
    //i++;
    rect(p.x*cellSize, p.y*cellSize, cellSize, cellSize);
  }
  for (PVector p : retraced) {
    fill(#2170CE);
    stroke(#2170CE);
    rect(p.x*cellSize, p.y*cellSize, cellSize, cellSize);
  }
  //for(Rect r:rects){
    //noFill();
    //stroke(200);
    //rect(r.x*cellSize-5,r.y*cellSize-5,r.w*cellSize+10,r.h*cellSize+10);
  //}
  for (int x=0; x<gridSize; x++) {
    for (int y=0; y<gridSize; y++) {
      stroke(255);
      strokeWeight(1);
      if (!grid[x][y].right)myLine(x+1, y, x+1, y+1);//IF no right THEN draw line
      if (!grid[x][y].down)myLine(x, y+1, x+1, y+1); //IF no  down THEN draw line
      strokeWeight(1);
    }
  }
  if(done)return;
  if(frameCount%20==0)update();
}
ArrayList<PVector>visited=new ArrayList<PVector>();
ArrayList<PVector>retraced=new ArrayList<PVector>();
class Rect{
  int x,y,w,h;
  float area(){
    return w*h;
  }
  
  Rect(int a,int b,int c,int d){
    x=a;
    y=b;
    w=c;
    h=d;
  }
}
Rect aToB(int a,int b,int c,int d){
  return new Rect(a,b,c-a,d-b);
}
ArrayList<Rect>rects=new ArrayList<Rect>();
void update() {
  ArrayList<Rect>newRects=new ArrayList<Rect>();
  for(Rect r:rects){
    //for(int x=r.x;x<=r.x+r.w;x++){
    for(int x=r.x+1;x<=r.x+r.w;x++){
      grid[x][r.y].down=false;
      grid[x][r.y+r.h].down=false;
    }
    for(int y=r.y+1;y<=r.y+r.h;y++){
      grid[r.x][y].right=false;
      grid[r.x+r.w][y].right=false;
    }
    int topGap=int(random(r.x,r.x+r.w));
    grid[topGap][r.y].down=true;
    int botGap=int(random(r.x,r.x+r.w));
    grid[botGap][r.y+r.h].down=true;
    
    int lefGap=int(random(r.y,r.y+r.h));
    grid[r.x][lefGap].right=true;
    int rigGap=int(random(r.y,r.y+r.h));
    grid[r.x+r.w][rigGap].right=true;
    if(r.area()>pow(2,2)){
      int cx=int(random(r.x,r.x+r.w));
      int cy=int(random(r.y,r.y+r.h));
      //int cx=r.x+r.w/2;
      //int cy=r.y+r.h/2;
      //int cx=r.x+r.w/2+int(random(-5,5));
      //int cy=r.y+r.h/2+int(random(-5,5));
      //int cx=r.x+nw;
      //int cy=r.y+nh;
      int x=r.x;
      int y=r.y;
      int w=r.w;
      int h=r.h;
      //newRects.add(new Rect(x,y,r.w-cx,r.h-cy));
      //newRects.add(new Rect(x,cy,r.w-cx,r.h-cy));
      newRects.add(aToB(x,y,cx,cy));
      newRects.add(aToB(cx,cy,x+w,y+h));
      newRects.add(aToB(x,cy,cx,y+h));
      newRects.add(aToB(cx,y,x+w,cy));
      
      //newRects.add(new Rect(x,y,nw,nh));
      //newRects.add(new Rect(cx,cy,nw,nh));
      //newRects.add(new Rect(x,cy,nw,nh));
      //newRects.add(new Rect(cx,y,nw,nh));
    }
  }
  rects.clear();
  rects.addAll(newRects);
}