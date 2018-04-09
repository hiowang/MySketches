import java.util.Stack;

class Edge {
  //PVector start,finish;
  boolean right=false, down=false;//+x,+y;
  //Edge(float a,float b,float c,float d){
  //start=new PVector(a,b);
  //finish=new PVector(c,d);
  //}
}
int speed=1;
boolean perFrame=true;
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
  //for(int x=0;x<gridW;x++){
  //grid[x][0].right=true;
  //}
  C.add(new PVector(int(random(gridW)), int(random(gridH))));
  //active.add(new PVector(gridW-1,0));
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
  if (done)return;
  background(100);
  for (PVector p : C) {
    fill(#AA70CE);
    stroke(#AA70CE);
    rect(p.x*cellSize, p.y*cellSize, cellSize, cellSize);
  }
  for (PVector p : finished) {
    fill(150);
    stroke(150);
    rect(p.x*cellSize, p.y*cellSize, cellSize, cellSize);
  }
  PVector p=C.get(C.size()-1);
    fill(#AA70CE);
    stroke(#AA70CE);
    rect(p.x*cellSize, p.y*cellSize, cellSize, cellSize);
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
  if (perFrame) {
    for (int i=0; i<speed; i++)update();
  } else {
    if (frameCount%speed==0)update();
  }
}
ArrayList<PVector> C=new ArrayList<PVector>();//=C
ArrayList<PVector>finished=new ArrayList<PVector>();
boolean done;
PVector randDir(PVector p) {
  ArrayList<PVector>valids=new ArrayList<PVector>();
  if (isValid(p.x-1, p.y))valids.add(new PVector(-1, 0));
  if (isValid(p.x+1, p.y))valids.add(new PVector(+1, 0));
  if (isValid(p.x, p.y-1))valids.add(new PVector(0, -1));
  if (isValid(p.x, p.y+1))valids.add(new PVector(0, +1));
  if (valids.size()==0)return null;
  return valids.get(int(random(valids.size())));
}
boolean isValid(float x, float y) {
  if (x<1)return false;
  if (y<1)return false;
  if (x>=gridW-1)return false;
  if (y>=gridH-1)return false;
  if (C.contains(new PVector(x, y)))return false;
  return true;
}
void update() {
  if(C.size()==0){
    done=true;
    return;
  }
  PVector rand=C.get(0);
  PVector randDir=randDir(rand);
  if (randDir==null) {
    C.remove(rand);
  } else {
    C.add(PVector.add(rand, randDir));
    finished.add(rand.copy());
    int ix=int(rand.x);
    int iy=int(rand.y);
    rand.add(randDir);
    if (randDir.x==-1) {
      grid[ix-1][iy].right=true;
    }
    if (randDir.x==1) {
      grid[ix][iy].right=true;
    }
    if (randDir.y==-1) {
      grid[ix][iy-1].down=true;
    }
    if (randDir.y==1) {
      grid[ix][iy].down=true;
    }
  }
}