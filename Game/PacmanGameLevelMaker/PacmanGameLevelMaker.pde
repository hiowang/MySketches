boolean[][]collMap;
int gridW=28;
int gridH=31;
boolean[][]junctions;
boolean[][]dots;
boolean getCollision(int x, int y) {
  if (x<0||y<0||x>=gridW||y>=gridH)return true;
  return collMap[x][y];
}
int gX=0, gY=0, pX=0, pY=0;
int cellSize=20;
void settings() {
  size(cellSize*gridW, cellSize*gridH);
}
void setup() {
  collMap=new boolean[gridW][gridH];
  dots=new boolean[gridW][gridH];
  junctions=new boolean[gridW][gridH];
  for (int x=0; x<gridW; x++) {
    for (int y=0; y<gridH; y++) {
      collMap[x][y]=false;
      if (x==0||y==0||x==gridW-1||y==gridH-1)collMap[x][y]=true;
      junctions[x][y]=false;
      dots[x][y]=false;
    }
  }
}
void draw() {
  background(0);
  fill(255, 0, 0);
  noStroke();
  rect(gX*cellSize, gY*cellSize, cellSize, cellSize);
  fill(#FFFF50);
  rect(pX*cellSize, pY*cellSize, cellSize, cellSize);
  debugCollision();
  debugGrid();
  debugJunctions();
  displayDots();
}
void displayDots() {
  noStroke();
  ellipseMode(CORNER);
  fill(255);
  for (int x=0; x<gridW; x++) {
    for (int y=0; y<gridH; y++) {
      int dotSize=5;
      if (dots[x][y])rect(x*cellSize+cellSize/2-dotSize/2, y*cellSize+cellSize/2-dotSize/2, dotSize, dotSize);
    }
  }
}
void debugJunctions() {
  for (int x=0; x<gridW; x++) {
    for (int y=0; y<gridH; y++) {
      if (!junctions[x][y])continue;
      fill(255, 50);
      noStroke();
      rect(x*cellSize, y*cellSize, cellSize, cellSize);
    }
  }
}
String lvlName="3";
void saveFiles() {
  PrintWriter mapEntity=createWriter(lvlName+"-map-entity.txt");
  PrintWriter mapJunctions=createWriter(lvlName+"-map-junctions.txt");
  PrintWriter mapCollisionDots=createWriter(lvlName+"-map-collision-dots.txt");

  for (int y=0; y<gridH; y++) {
    for (int x=0; x<gridW; x++) {
      if(pX==x&&pY==y)mapEntity.print("P");
      else if(gX==x&&gY==y)mapEntity.print("G");
      else mapEntity.print(" ");
      
      if(junctions[x][y])mapJunctions.print("J");
      else mapJunctions.print(" ");
      
      if(collMap[x][y])mapCollisionDots.print("#");
      else if(dots[x][y])mapCollisionDots.print(".");
      else mapCollisionDots.print(" ");
    }
    mapEntity.println();
    mapJunctions.println();
    mapCollisionDots.println();
  }

  mapEntity.flush();
  mapJunctions.flush();
  mapCollisionDots.flush();
  mapEntity.close();
  mapJunctions.close();
  mapCollisionDots.close();
}
int pressX, pressY;
boolean pressed=false;
void mouseDragged() {
  //if (!keyPressed)return;
  int mx=mouseX/cellSize;
  int my=mouseY/cellSize;
  if (mx<0||my<0||mx>=gridW||my>=gridH)return;
  if (key=='c')collMap[mx][my]=true;
  if (key=='e')collMap[mx][my]=false;
}
void mousePressed() {
  int mx=mouseX/cellSize;
  int my=mouseY/cellSize;
  if (mx<0||my<0||mx>=gridW||my>=gridH)return;
  if (key=='c')collMap[mx][my]=true;
  if (key=='e')collMap[mx][my]=false;
  if (key=='j')junctions[mx][my]=!junctions[mx][my];
}
void keyReleased() {
  println("keyReleased "+key);
  int mx=mouseX/cellSize;
  int my=mouseY/cellSize;
  if (mx<0||my<0||mx>=gridW||my>=gridH)return;
  if (key=='g') {
    gX=mx;
    gY=my;
  }
  if (key=='1') {
    pX=mx;
    pY=my;
  }
  if (key=='s') {
    saveFiles();
  }
  if (key=='m') {
    for (int x=gridW/2; x<gridW; x++) {
      for (int y=0; y<gridH; y++) {
        collMap[x][y]=collMap[gridW-x-1][y];
      }
    }
  }
  if (key=='p') {
    if (!pressed) {
      pressX=mx;
      pressY=my;
      pressed=true;
      println("1 "+mx+" "+my);
    } else {
      pressed=false;
      println("2 +"+mx+" "+my);
      for (int x=pressX; x<=mx; x++) {
        for (int y=pressY; y<=my; y++) {
          collMap[x][y]=true;
        }
      }
    }
  }
  if (key=='d') {
    for (int x=0; x<gridW; x++) {
      for (int y=0; y<gridH; y++) {
        dots[x][y]=!collMap[x][y];
      }
    }
  }
}

void debugGrid() {
  for (int x=0; x<28; x++) {
    for (int y=0; y<31; y++) {
      noFill();
      stroke(255, 20);
      rect(x*cellSize, y*cellSize, cellSize, cellSize);
    }
  }
}
void debugCollision() {
  for (int x=0; x<28; x++) {
    for (int y=0; y<31; y++) {
      if (collMap[x][y]) {
        fill(#810072);
        noStroke();
        rect(x*cellSize, y*cellSize, cellSize, cellSize);
        //float r=15;
        boolean cur=true;
        boolean xmi=getCollision(x-1, y);
        boolean xpl=getCollision(x+1, y);
        boolean ymi=getCollision(x, y-1);
        boolean ypl=getCollision(x, y+1);
        boolean mimi=getCollision(x-1, y-1);
        boolean mipl=getCollision(x-1, y+1);
        boolean plmi=getCollision(x+1, y-1);
        boolean plpl=getCollision(x+1, y+1);
        stroke(0, 0, 255);
        strokeWeight(3);
        noFill();
        ellipseMode(CENTER);
        translate(x*cellSize, y*cellSize);

        if (xmi&&!xpl&&ymi&&ypl)line(cellSize/2, 0, cellSize/2, cellSize);
        if (!xmi&&xpl&&ymi&&ypl)line(cellSize/2, 0, cellSize/2, cellSize);
        if (ymi&&!ypl&&xmi&&xpl)line(0, cellSize/2, cellSize, cellSize/2);
        if (!ymi&&ypl&&xmi&&xpl)line(0, cellSize/2, cellSize, cellSize/2);
        if (!ymi&&!xpl&&!plmi&&xmi&&ypl&&mipl)arc(0, cellSize, cellSize, cellSize, radians(270), radians(360));
        if (!ymi&&!xmi&&xpl&&ypl&&!plmi&&!mimi&&!plmi&&plpl)arc(cellSize, cellSize, cellSize, cellSize, radians(180), radians(270));
        if (ymi&&xmi&&!ypl&&!xpl&&mimi&&!mipl&&!plmi&&!plpl)arc(0, 0, cellSize, cellSize, radians(0), radians(90));
        if (ymi&&xpl&&!ypl&&!xmi&&!mimi&&plmi&&!plpl&&!mipl)arc(cellSize, 0, cellSize, cellSize, radians(90), radians(180));
        if (ymi&&ypl&&xmi&&xpl&&mimi&&plmi&&plpl&&!mipl)arc(0, cellSize, cellSize, cellSize, radians(270), radians(360));
        if (ymi&&ypl&&xmi&&xpl&&mimi&&plmi&&mipl&&!plpl)arc(cellSize, cellSize, cellSize, cellSize, radians(180), radians(270));
        if (ymi&&ypl&&xmi&&xpl&&mimi&&mipl&&plpl&&!plmi)arc(cellSize, 0, cellSize, cellSize, radians(90), radians(180));
        if (ymi&&ypl&&xmi&&xpl&&!mimi&&mipl&&plmi&&plpl)arc(0, 0, cellSize, cellSize, radians(0), radians(90));

        translate(-x*cellSize, -y*cellSize);
        strokeWeight(1);
      }
    }
  }
}