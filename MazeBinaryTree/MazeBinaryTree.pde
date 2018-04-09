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
  background(100);
  for(PVector p:finished){
    fill(150);
    stroke(150);
    rect(p.x*cellSize,p.y*cellSize,cellSize,cellSize);
  }
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
    for(int i=0;i<speed&&!done;i++)update();
  }else{
    if(frameCount%speed==0&&!done)update();
  }
}
boolean done=false;
int x=0,y=0;
ArrayList<PVector>finished=new ArrayList<PVector>();
void update() {
  finished.add(new PVector(x,y));
  x++;
  if(x>=gridW){
    x=0;
    y++;
    if(y>=gridH){
      done=true;
      return;
    }
  }
  if(random(100)<50){
    grid[x][y].right=true;
  }else{
    grid[x][y].down=true;
  }
}