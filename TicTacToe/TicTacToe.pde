int EMPTY=0;
int X=1;
int O=-1;
class Board{
  int[][] stuff;
  Board(){
    stuff=new int[][]{{0,0,0},{0,0,0},{0,0,0}};
  }
}
Board b;
int cellSize=100;
Network makeRandomNN(){
  int numInputs=12;
  int numOutput=1;
  int numHidden=5;
  int numLayers=1;
  return new Network(numInputs, numLayers, numHidden, numOutput);
}
Network nnX=makeRandomNN();
Network nnO=makeRandomNN();
void setup(){
  size(300,300);
  b=new Board();
}
void keyPressed(){
  if(key==' '){
    b=new Board();
    piece=X;
    nnX=makeRandomNN();
    nnO=makeRandomNN();
  }
}
int doNN(Network network,int[][]board,int numOpen,int whatPieceIsTheNN){
  network.calc(new float[]{board[0][0],board[0][1],board[0][2],board[1][0],board[1][1],board[1][2],board[2][0],board[2][1],board[2][2],whatPieceIsTheNN,-4,4});
  float val=network.out(0);
  val*=numOpen;
  //val=abs(val);
  while(val<0)val+=numOpen;
  while(val>=numOpen)val-=numOpen;
  return (int)val;
}
int piece=X;
void draw(){
  background(255);
  int numOpen=0;
  for(int x=0;x<3;x++){
    for(int y=0;y<3;y++){
      pushMatrix();
      translate(x*cellSize,y*cellSize);
      if(b.stuff[x][y]==X){
        stroke(0);
        line(0,0,cellSize,cellSize);
        line(0,cellSize,cellSize,0);
      }else if(b.stuff[x][y]==O){
        stroke(0);
        noFill();
        ellipse(cellSize/2,cellSize/2,cellSize,cellSize);
      }else{
        numOpen++;
      }
      popMatrix();
    }
  }
  if(frameCount%10!=0)return;
  if(numOpen==0)return;
  if(piece==X)piece=O;
  else piece=X;
  //if(keyPressed&&key==' ')b=new Board();
  Network nn=piece==X?nnX:nnO;
  int num=doNN(nn,b.stuff,numOpen,piece)%numOpen;
  println(num);
  int n=0;
  for(int x=0;x<3;x++){
    for(int y=0;y<3;y++){
      if(b.stuff[x][y]!=EMPTY)continue;
      if(num==n)b.stuff[x][y]=piece;
      n++;
    }
  }
}