int[][]board;
int boardW=4;
int boardH=4;
int cellSize;
int cellOffset=2;
//{text,bg}
color[]col0=new color[]{#756e66, #eee4da};
color[]col2=new color[]{#756e66, #eee4da};
color[]col4=new color[]{#756E66, #ede0c8};
color[]col8=new color[]{#f9f6f2, #f2b179};
color[]col16=new color[]{#f9f6f2, #f59563};
color[]col32=new color[]{#f9f6f2, #f67c5f};
color[]col64=new color[]{#f9f6f2, #f65e3b};
color[]col128=new color[]{#f9f6f2, #edcf72};
color[]col256=new color[]{#f9f6f2, #edcc61};
color[]col512=new color[]{#f9f6f2, #edc850};
color[]col1024=new color[]{#f9f6f2, #edc53f};
color[]col2048=new color[]{#f9f6f2, #edc22e};
//For movements
//To avoid "folding up" many tiles in a row
//Only go through once
//For goLeft():
/*
for(int x=0;x<4;x++){
 for(int y=0;y<4;y++){
 if is0 then continue
 if left is empty move over
 if left is same double left and remove this
 }
 }
 The point is the direction of the iterations for the x-loop
 */
void setup() {
  size(400, 500);
  doSetup();
}
void doSetup(){
  cellSize=400/boardW;
  board=new int[boardW][boardH];
  //PFont font=loadFont("Monospaced-50.vlw");
  PFont font=loadFont("AgencyFB-Reg-48.vlw");
  textFont(font, 50);
  //board[0][0]=8;
  //board[1][0]=4;
  //board[2][0]=2;
  //board[3][0]=2;
  placeRandom();
  placeRandom();
  won=false;
  lost=false;
  score=0;
}
boolean checkWin() {
  for (int x=0; x<4; x++) {
    for (int y=0; y<4; y++) {
      if (board[x][y]==256)return true;
    }
  }
  return false;
}
boolean won=false;
boolean lost=false;
boolean checkLoss() {
  for (int x=0; x<boardW; x++) {
    for (int y=0; y<boardH; y++) {
      int xmi=-1, xpl=-1, ymi=-1, ypl=-1;
      if (x>0)xmi=board[x-1][y];
      if (y>0)ymi=board[x][y-1];
      if (x<boardW-1)xpl=board[x+1][y];
      if (y<boardH-1)ypl=board[x][y+1];
      int cur=board[x][y];
      if (xmi==0)return false;
      if (xpl==0)return false;
      if (ymi==0)return false;
      if (ypl==0)return false;
      if (cur==xmi)return false;
      if (cur==xpl)return false;
      if (cur==ymi)return false;
      if (cur==ypl)return false;
    }
  }
  return true;
}
void placeRandom() {
  ArrayList<PVector>open=new ArrayList<PVector>();
  for (int x=0; x<boardW; x++) {
    for (int y=0; y<boardH; y++) {
      if (board[x][y]==0)open.add(new PVector(x, y));
    }
  }
  if (open.size()==0) {
    println("End game");
    //exit();
    fill(255);
    textSize(50);
    text("End game", width/2, height/2);
    noLoop();
  } else {
    PVector p=open.get((int)(random(0, open.size())));
    board[(int)p.x][(int)p.y]=random(1)<0.1?4:2;
  }
}
void keyPressed() {
  if(won||lost){
    doSetup();
    return;
  }
  //if (key==' ')placeRandom();
  if (keyCode==LEFT) {
    hasDoneSomething=false;
    moved=new ArrayList<PVector>();
    goLeft();
    if (hasDoneSomething)placeRandom();
  }
  if (keyCode==RIGHT) {
    hasDoneSomething=false;
    moved=new ArrayList<PVector>();
    goRight();
    if (hasDoneSomething)placeRandom();
  }
  if (keyCode==UP) {
    hasDoneSomething=false;
    moved=new ArrayList<PVector>();
    goUp();
    if (hasDoneSomething)placeRandom();
  }
  if (keyCode==DOWN) {
    hasDoneSomething=false;
    moved=new ArrayList<PVector>();
    goDown();
    if (hasDoneSomething)placeRandom();
  }
}
ArrayList<PVector>moved=new ArrayList<PVector>();
boolean hasDoneSomething=false;
void goLeft() {
  for (int x=1; x<boardW; x++) {
    for (int y=0; y<boardH; y++) {
      if (board[x][y]==0)continue;
      if (board[x-1][y]==0) {
        hasDoneSomething=true;
        board[x-1][y]=board[x][y];
        board[x][y]=0;
        goLeft();
        return;
      }
      if (board[x-1][y]==board[x][y]) {
        if (moved.contains(new PVector(x, y))) {
          continue;
        }
        moved.add(new PVector(x-1, y));
        hasDoneSomething=true;
        board[x-1][y]*=2;
        board[x][y]=0;
        score+=board[x-1][y];
        goLeft();
        return;
      }
    }
  }
}
void goUp() {
  for (int x=0; x<boardW; x++) {
    for (int y=1; y<boardH; y++) {
      if (board[x][y]==0)continue;
      if (board[x][y-1]==0) {
        hasDoneSomething=true;
        board[x][y-1]=board[x][y];
        board[x][y]=0;
        goUp();
        return;
      }
      if (board[x][y-1]==board[x][y]) {
        if (moved.contains(new PVector(x, y))) {
          continue;
        }
        moved.add(new PVector(x, y-1));
        hasDoneSomething=true;
        board[x][y-1]*=2;
        board[x][y]=0;
        score+=board[x][y-1];
        goUp();
        return;
      }
    }
  }
}
void goDown () {
  for (int x=0; x<boardW; x++) {
    for (int y=0; y<boardH-1; y++) {
      if (board[x][y]==0)continue;
      if (board[x][y+1]==0) {
        hasDoneSomething=true;
        board[x][y+1]=board[x][y];
        board[x][y]=0;
        goDown();
        return;
      }
      if (board[x][y]==board[x][y+1]) {
        if (moved.contains(new PVector(x, y))) {
          continue;
        }
        moved.add(new PVector(x, y+1));
        hasDoneSomething=true;
        board[x][y+1]*=2;
        score+=board[x][y+1];
        board[x][y]=0;
        goDown();
        return;
      }
    }
  }
}
void goRight() {
  for (int x=0; x<boardW-1; x++) {
    for (int y=0; y<boardH; y++) {
      if (board[x][y]==0)continue;
      if (board[x+1][y]==0) {
        hasDoneSomething=true;
        board[x+1][y]=board[x][y];
        board[x][y]=0;
        goRight();
        return;
      }
      if (board[x+1][y]==board[x][y]) {
        if (moved.contains(new PVector(x, y))) {
          continue;
        }
        hasDoneSomething=true;
        moved.add(new PVector(x+1, y)); 
        board[x+1][y]*=2;
        score+=board[x+1][y];
        board[x][y]=0;
        goRight();
        return;
      }
    }
  }
}
int score=0;
void draw() {
  background(150);
  fill(255);
  stroke(255);
  textSize(50);
  text("Score: " + score, width/2, 40);
  won=checkWin();
  lost=checkLoss();
  for (int x=0; x<boardW; x++) {
    for (int y=0; y<boardH; y++) {
      int val=board[x][y];
      color[]col=new color[]{color(255), color(255)};
      if (val==2)col=col2;
      if (val==4)col=col4;
      if (val==8)col=col8;
      if (val==16)col=col16;
      if (val==32)col=col32;
      if (val==64)col=col64;
      if (val==128)col=col128;
      if (val==256)col=col256;
      if (val==512)col=col512;
      if (val==1024)col=col1024;
      if (val==2048)col=col2048;
      fill(col[1]);
      stroke(col[1]);
      rect(cellOffset+x*cellSize, cellOffset+y*cellSize+100, cellSize-cellOffset*2, cellSize-cellOffset*2);
      textAlign(CENTER, CENTER);
      textSize(30);
      fill(col[0]);
      stroke(col[0]);
      text(val, x*cellSize+cellSize/2, y*cellSize+cellSize/2+100);
    }
  }
  if (won) {
    textSize(100);
    fill(0);
    stroke(0);
    text("You won!\nScore: "+score, width/2, height/2);
    textSize(20);
    text("Press the ANY key to start a new game",width/2,height/2+130);
  }
  if (lost) {
    textSize(100);
    fill(0);
    stroke(0);
    text("You lost!\nScore: "+score, width/2, height/2);
    textSize(20);
    text("Press the ANY key to start a new game",width/2,height/2+130);
  }
}