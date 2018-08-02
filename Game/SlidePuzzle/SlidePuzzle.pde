int[][]vals;
int[][]origGrid;
int sizeX=7;
int sizeY=7;
int gridPixelW=500;
int gridPixelH=500;

int spaceX, spaceY;

boolean isGood() {
  for (int x=0; x<sizeX; x++) {
    for (int y=0; y<sizeY; y++) {
      if (vals[x][y]!=x*sizeX+y&&vals[x][y]!=-1)return false;
    }
  }
  return true;
}
int cellX, cellY;
void settings() {
  size(gridPixelW*2+200, gridPixelH);
}
void setup() {
  cellX=gridPixelW/sizeX;
  cellY=gridPixelH/sizeY;
  vals=new int[sizeX][sizeY];
  origGrid=new int[sizeX][sizeY];
  spaceX=0;
  spaceY=0;
  int i=1;
  for (int x=0; x<sizeX; x++) {
    for (int y=0; y<sizeY; y++) {
      vals[x][y]=i;
      if (x==spaceX&&y==spaceY)vals[x][y]=-1;
      else i++;
      origGrid[x][y]=vals[x][y];
    }
  }
}
void keyPressed() {
  if (key=='d')left();
  if (key=='a')right();
  if (key=='s')up();
  if (key=='w')down();
  if (key==' ')shuffleGrid();
}
void left() {
  if (spaceX>0) {
    swap(spaceX, spaceY, spaceX-1, spaceY);
  }
}
void right() {
  if (spaceX<sizeX-1) {
    swap(spaceX, spaceY, spaceX+1, spaceY);
  }
}
void up() {
  if (spaceY>0) {
    swap(spaceX, spaceY, spaceX, spaceY-1);
  }
}
void down() {
  if (spaceY<sizeY-1) {
    swap(spaceX, spaceY, spaceX, spaceY+1);
  }
}
void swap(int a, int b, int c, int d) {
  int temp=vals[a][b];
  vals[a][b]=vals[c][d];
  vals[c][d]=temp;
}
void shuffleGrid() {
  for (int i=0; i<1000; i++) {
    //swap(int(random(sizeX)),int(random(sizeY)),spaceX,spaceY);
    ArrayList<PVector>places=new ArrayList<PVector>();
    if (spaceX>0)places.add(new PVector(spaceX-1, spaceY));
    if (spaceY>0)places.add(new PVector(spaceX, spaceY-1));
    if (spaceX<sizeX-1)places.add(new PVector(spaceX+1, spaceY));
    if (spaceY<sizeY-1)places.add(new PVector(spaceX, spaceY+1));
    PVector p=places.get(int(random(places.size())));
    swap(int(p.x), int(p.y), spaceX, spaceY);
    findSpace();
  }
}
void findSpace() {
  for (int x=0; x<sizeX; x++) {
    for (int y=0; y<sizeY; y++) {
      if (vals[x][y]==-1) {
        spaceX=x;
        spaceY=y;
      }
    }
  }
}
void drawGrid(int[][]grid, int xoff, int yoff) {
  translate(xoff, yoff);
  for (int x=0; x<sizeX; x++) {
    for (int y=0; y<sizeY; y++) {
      if (grid[x][y]==-1)continue;
      colorMode(HSB, 100);
      fill(map(grid[x][y], 0, sizeX*sizeX+sizeY, 0, 100), 40, 100);
      colorMode(RGB, 255);
      stroke(255);
      strokeWeight(5);
      rect(x*cellX, y*cellY, cellX, cellY);
      strokeWeight(1);
      fill(0);
      stroke(0);
      textSize(40);
      textAlign(CENTER, CENTER);
      text(""+grid[x][y], x*cellX+cellX/2, y*cellY+cellY/2);
    }
  }
  translate(-xoff, -yoff);
}
void draw() {
  background(255);
  findSpace();
  drawGrid(vals, 0, 0);
  drawGrid(origGrid, 700, 0);
}