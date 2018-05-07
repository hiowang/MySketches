import java.util.Stack;

class Edge {
  //PVector start,finish;
  boolean right=false, down=false;//+x,+y;
  //Edge(float a,float b,float c,float d){
  //start=new PVector(a,b);
  //finish=new PVector(c,d);
  //}
}
int cellSize;
int gridSize=20;
//int gridSize=100;
//int cellSize=5;
Edge[][] grid;
void setup() {
  size(600, 600);
  cellSize=width/gridSize;
  grid=new Edge[gridSize][gridSize];

  for (int x=0; x<gridSize; x++) {
    for (int y=0; y<gridSize; y++) {
      grid[x][y]=new Edge();
    }
  }
  //current=new PVector(int(gridSize/2), int(gridSize/2));
  current=new PVector(2, 2);
  stack.add(current);
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
  for (int x=0; x<gridSize; x++) {
    for (int y=0; y<gridSize; y++) {
      stroke(255);
      strokeWeight(1);
      //strokeJoin(BEVEL);
      if (!grid[x][y].right)myLine(x+1, y, x+1, y+1);//IF no right THEN draw line
      if (!grid[x][y].down)myLine(x, y+1, x+1, y+1); //IF no  down THEN draw line
      strokeWeight(1);
    }
  }
  if(done)return;
  fill(0, 255, 0);
  stroke(0, 255, 0);
  rect(current.x*cellSize, current.y*cellSize, cellSize, cellSize);
    //for(int i=0;i<1;i++)
    //if(frameCount%5==0)
  {update();}
}
PVector randDir() {
  ArrayList<PVector>valids=new ArrayList<PVector>();
  PVector a=new PVector(current.x-1, current.y);
  PVector b=new PVector(current.x+1, current.y);
  PVector c=new PVector(current.x, current.y-1);
  PVector d=new PVector(current.x, current.y+1);
  if (isValidPos(a))valids.add(new PVector(-1, 0));
  if (isValidPos(b))valids.add(new PVector(1, 0));
  if (isValidPos(c))valids.add(new PVector(0, -1));
  if (isValidPos(d))valids.add(new PVector(0, 1));
  if (valids.size()==0)return null;
  return valids.get(int(random(valids.size())));
}
boolean isValidPos(PVector p) {
  if (visited.contains(p))return false;
  if (p.x<0)return false;
  if (p.y<0)return false;
  if (p.x>gridSize-1)return false;
  if (p.y>gridSize-1)return false;
  return true;
}
//Edge getEdge(PVector a,PVector b){
//}
PVector unfixedRand() {
  int i=int(random(4));
  if (i==0)return new PVector(-1, 0);
  if (i==1)return new PVector(1, 0);
  if (i==2)return new PVector(0, -1);
  return new PVector(0, 1);
}
ArrayList<PVector>visited=new ArrayList<PVector>();
ArrayList<PVector>retraced=new ArrayList<PVector>();
PVector current;
void update() {
  int ix=int(current.x);
  int iy=int(current.y);

  PVector dir=randDir();
  //while(dir==null){
  if (dir==null) {
    dir=randDir();
    retraced.add(current.copy());
    current=stack.get(stack.size()-1).copy();
    stack.remove(stack.size()-1);
    return;
  }
  stack.add(current.copy());
  current.add(dir);

  visited.add(current.copy());
  if (dir.x==-1) {
    grid[ix-1][iy].right=true;
  }
  if (dir.x==1) {
    grid[ix][iy].right=true;
  }
  if (dir.y==-1) {
    grid[ix][iy-1].down=true;
  }
  if (dir.y==1) {
    grid[ix][iy].down=true;
  }
}
//void update() {
//  visited.add(current);
//  PVector dir=randDir();
//  while (dir==null&&stack.size()>0) {
//    current=stack.get(0);
//    stack.remove(0);
//    dir=randDir();
//    //return;
//  }
//  stack.add(0,current);




//  int ix=int(current.x);
//  int iy=int(current.y);
//  current.add(dir);
//  if (dir.x==-1) {
//    grid[ix-1][iy].right=true;
//  }
//  if (dir.x==1) {
//    grid[ix][iy].right=true;
//  }
//  if (dir.y==-1) {
//    grid[ix][iy-1].down=true;
//  }
//  if (dir.y==1) {
//    grid[ix][iy].down=true;
//  }
//}