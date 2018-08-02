boolean[][] collMap;
boolean[][] dots;
boolean[][] powerPellets;

boolean debugCollision=true;
boolean debugGrid=false;
boolean debugGhostTargets=true;
boolean debugGhostPaths=false;

boolean scatterMode=true;

int ghostX;
int ghostY;

int lives=3;

int chaseCount=0;

int cellSize=20;
int gridW=28;
int gridH=31;

float dotSize=3*cellSize/30;

color dotColor=color(255);
color pacmanColor=#FFFF50;

Pacman player;

Blinky blinky;
Pinky pinky;
Clyde clyde;
Inky inky;

String levelName;

void loadEnts() {
  player=new Pacman();
  //player.offX=0;
  //player.offY=0;
  //player.gridX=13;
  //player.gridY=23;
  blinky=new Blinky();
  pinky=new Pinky();
  clyde=new Clyde();
  inky=new Inky();
}

void loadLevel(String lvlName, boolean doDots) {
  levelName=lvlName;
  loadEnts();
  loadEntityMap();
  if (doDots)loadCollDotsMap();
}

void settings() {
  size(gridW*cellSize, gridH*cellSize);
}
void arrow(int x1, int y1, int x2, int y2) {
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -10, -10);
  line(0, 0, 10, -10);
  popMatrix();
} 

void setup() {
  loadLevel("1", true);
}
boolean dotsGone() {
  for (int x=0; x<gridW; x++)for (int y=0; y<gridH; y++)if (dots[x][y])return false;
  return true;
}
void killPacman(String reason){
  println("pacman died because of "+reason);
  lives--;
  loadLevel(levelName,false);
}
void draw() {
  if (lives<0)return;
  if (dotsGone())loadCollDotsMap();
  background(0);
  translate(0, height-gridH*cellSize);
  if (scatterMode) {
    if (chaseCount>200) {
      scatterMode=false;
      chaseCount=0;
    }
  } else {
    if (chaseCount>1000) {
      scatterMode=true;
      chaseCount=0;
    }
  }
  chaseCount++;
  if(player.on(blinky)){
    if(blinky.scared){
      blinky.die();
    }else if(!blinky.dead){
      killPacman("blinky");
    }
  }
  if(player.on(inky)){
    if(inky.scared){
      inky.die();
    }else if(!inky.dead){
      killPacman("inky");
    }
  }
  if(player.on(pinky)){
    if(pinky.scared){
      pinky.die();
    }else if(!pinky.dead){
      killPacman("pinky");
    }
  }
  if(player.on(clyde)){
    if(clyde.scared){
      clyde.die();
    }else if(!clyde.dead){
      killPacman("clyde");
    }
  }
  displayDots();
  displayPowerPellets();

  player.display();
  player.update();
  blinky.display();
  blinky.update();
  pinky.display();
  pinky.update();
  clyde.display();
  clyde.update();
  inky.display();
  inky.update();

  if (debugCollision)debugCollision();
  if (debugGrid)debugGrid();

  translate(0, -height+gridH*cellSize);
}
void displayPowerPellets() {
  noStroke();
  ellipseMode(CORNER);
  fill(255);
  for (int x=0; x<gridW; x++) {
    for (int y=0; y<gridH; y++) {
      int dotSize=15;
      if (powerPellets[x][y])ellipse(x*cellSize+cellSize/2-dotSize/2, y*cellSize+cellSize/2-dotSize/2, dotSize, dotSize);
    }
  }
}

void displayDots() {
  noStroke();
  ellipseMode(CORNER);
  fill(dotColor);
  for (int x=0; x<gridW; x++) {
    for (int y=0; y<gridH; y++) {
      //if(dots[x][y])ellipse(x*cellSize+cellSize/2,y*cellSize+cellSize/2,dotSize,dotSize);
      if (dots[x][y])rect(x*cellSize+cellSize/2-dotSize/2, y*cellSize+cellSize/2-dotSize/2, dotSize, dotSize);
    }
  }
}