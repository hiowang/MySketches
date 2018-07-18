class Cell {
  int type;
  float health;
  int pred=0;
}
color colForType(int t, float f) {
  if (t==0)return color(0);
  return color(red(cols[t-1])*f, green(cols[t-1])*f, blue(cols[t-1])*f);
}
int randType() {
  return int(random(numTypes))+1;
}
color[]cols;
int numTypes=5;
Cell[][]grid;
int cellSize;
int gridSize;
void settings() {
  gridSize=100;
  cellSize=1000/gridSize;
  size(cellSize*gridSize, cellSize*gridSize);
}
void doCols() {
  cols=new color[numTypes];
  for (int i=0; i<numTypes; i++) {
    colorMode(HSB, 100);
    cols[i]=color(map(i, 0, numTypes+1, 0, 90), 30, 100);
    //cols[i]=color(random(100),10,random(25)+75);
    colorMode(RGB, 255);
  }
}
void setup() {
  doCols();
  grid=new Cell[gridSize][gridSize];
  for (int x=0; x<gridSize; x++) {
    for (int y=0; y<gridSize; y++) {
      grid[x][y]=new Cell();
      grid[x][y].health=10;
      grid[x][y].type=0;
      //if(random(100)<10)
      grid[x][y].type=randType();
    }
  }
  for (int i=0; i<0; i++) {
    setRandType(1);
    setRandType(2);
    setRandType(3);
  }
}
int mouseType=0;
void keyPressed() {
  if (key=='1')mouseType=1;
  if (key=='2')mouseType=2;
  if (key=='3')mouseType=3;
  if (key=='4')mouseType=0;
  if (key=='h')showHealth=!showHealth;
  if (key=='c')doCols();
}
void mouseDragged() {
  int mx=int(mouseX/cellSize);
  int my=int(mouseY/cellSize);
  grid[mx][my].type=constrain(mouseType, 0, numTypes);
  grid[mx][my].health=30;
}
void setRandType(int t) {
  grid[int(random(gridSize))][int(random(gridSize))].type=t;
}
void draw() {
  background(255);
  for (int x=0; x<gridSize; x++) {
    for (int y=0; y<gridSize; y++) {
      int t=grid[x][y].type;
      if (showHealth)fill(colForType(t, grid[x][y].health/10));
      else fill(colForType(t, 1));
      noStroke();
      rect(x*cellSize, y*cellSize, cellSize, cellSize);
    }
  }
  for (int i=0; i<10; i++)iterate();
  surface.setTitle("TriColorCA, frameRate="+nf(frameRate, 2, 3));
}  
float dh=1.0/10;
float r=1.0;

void remakeCell(int x, int y, int t) {
  grid[x][y].type=t;
  grid[x][y].health=10;
}
boolean showHealth=false;
boolean canAbeatB(int a, int b) {
  if (b==0)return true;
  //if(random(100)<1)println(a);  
  //return a==b+1;
  //return a==((b+1)%numTypes);
  //if(a==0)return b==1;
  //if
  //if(a==1)return b==2;
  //if(a==2)return b==3;
  //if(a==3)return b==1;
  //return a>b;
  //if(a==1)return b==2;
  //if(a==2)return b==3;
  //if(a==3)return b==1;
  //println(a+" "+(a==numTypes?1:b));
  if (a==numTypes)return b==1;
  return a+1==b;
  //return a>b+1;
  //return false;
}
void iterate() {


  for (int x=0; x<gridSize; x++) {
    for (int y=0; y<gridSize; y++) {

      Cell cell=grid[x][y];
      int type=cell.type;
      if (type==0)continue;
      float health=cell.health;
      if (x>0&&random(1)<r) {
        if (canAbeatB(type, grid[x-1][y].type)) {
          grid[x-1][y].health-=dh;
          grid[x-1][y].pred=type;
        }
      }
      if (y>0&&random(1)<r) {
        if (canAbeatB(type, grid[x][y-1].type)) {
          grid[x][y-1].health-=dh;
          grid[x][y-1].pred=type;
        }
      }
      if (x<gridSize-1&&random(1)<r) {
        if (canAbeatB(type, grid[x+1][y].type)) {
          grid[x+1][y].health-=dh;
          grid[x+1][y].pred=type;
        }
      }
      if (y<gridSize-1&&random(1)<r) {
        if (canAbeatB(type, grid[x][y+1].type)) {
          grid[x][y+1].health-=dh;
          grid[x][y+1].pred=type;
        }
      }
    }
  }
  for (int x=0; x<gridSize; x++) {
    for (int y=0; y<gridSize; y++) {
      if (grid[x][y].health<0) {
        grid[x][y].type=grid[x][y].pred;
        grid[x][y].health=10;
      }
    }
  }
}