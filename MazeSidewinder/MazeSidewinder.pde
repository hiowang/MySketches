import java.util.Stack;

class Edge {
  //PVector start,finish;
  boolean right=false, down=false;//+x,+y;
  //Edge(float a,float b,float c,float d){
  //start=new PVector(a,b);
  //finish=new PVector(c,d);
  //}
}
int speed=5;
boolean perFrame=false;
int cellSize=40;
int gridW;
int gridH;
//int gridSize=100;
//int cellSize=5;
Edge[][] grid;
void setup() {//#AA70CE,#2170CE
  size(640, 480);
  gridW=width/cellSize;
  gridH=height/cellSize;
  grid=new Edge[gridW][gridH];

  for (int x=0; x<gridW; x++) {
    for (int y=0; y<gridH; y++) {
      grid[x][y]=new Edge();
    }
  }
  for(int x=0;x<gridW;x++){
    grid[x][0].right=true;
    finished.add(new PVector(x,0));
  }
  active.add(new PVector(gridW-1,0));
  //current=new PVector(int(gridSize/2), int(gridSize/2));
  //current=new PVector(2, 2);
  //stack.add(current);
}
//ArrayList<Edge>edges=new ArrayList<Edge>();
ArrayList<PVector> stack=new ArrayList<PVector>();
void myLine(float a, float b, float c, float d) {
  line(a*cellSize, b*cellSize, c*cellSize, d*cellSize);
}
void draw() {
  if(done)return;
  background(100);
  for(PVector p:finished){
    fill(150);
    stroke(150);
    rect(p.x*cellSize,p.y*cellSize,cellSize,cellSize);
  }
  for(PVector p:active){
    fill(#AA70CE);
    stroke(#AA70CE);
    rect(p.x*cellSize,p.y*cellSize,cellSize,cellSize);
  }//#2170CE
  PVector lastActive=active.get(active.size()-1);
  fill(#2170CE);
  stroke(#2170CE);
  rect(lastActive.x*cellSize,lastActive.y*cellSize,cellSize,cellSize);
  for (int x=0; x<gridW; x++) {
    for (int y=0; y<gridH; y++) {
      stroke(255);
      strokeWeight(1);
      //strokeJoin(BEVEL);
      if (!grid[x][y].right)myLine(x+1, y, x+1, y+1);//IF no right THEN draw line
      if (!grid[x][y].down)myLine(x, y+1, x+1, y+1); //IF no  down THEN draw line
      strokeWeight(1);
    }
  }
  fill(0, 255, 0);
  stroke(0, 255, 0);
  if(perFrame){
    for(int i=0;i<speed;i++)update();
  }else{
    if(frameCount%speed==0)update();
  }
}
ArrayList<PVector> active=new ArrayList<PVector>();
ArrayList<PVector>finished=new ArrayList<PVector>();
boolean done;
void update() {
  PVector lastActive=active.get(active.size()-1);
  int ix=int(lastActive.x);
  int iy=int(lastActive.y);
  if(lastActive.y==gridH){
    done=true;
    finished.addAll(active);
    active.clear();
    return;
  }
  if(lastActive.x==gridW-1){
    //grid[ix][gridH-1].down=true;
    if(iy>0)grid[ix][iy-1].down=true;
    finished.addAll(active);
    active.clear();
    active.add(new PVector(0,lastActive.y+1));
    return;
  }
  if(random(100)<50){
    active.add(new PVector(ix+1,iy));
    grid[ix][iy].right=true;
  }else{
    PVector rand=active.get(int(random(active.size())));
    grid[int(rand.x)][int(rand.y)-1].down=true;
    finished.addAll(active);
    active.clear();
    active.add(new PVector(ix+1,iy));
    //grid[ix][iy].down=true;
  }
}