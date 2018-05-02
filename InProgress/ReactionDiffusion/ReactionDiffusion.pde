float[][]valsU,valsV;
int w=200;
int h=200;
int size=3;
void setup(){
  size(600,600);
  valsU=new float[w][h];
  valsV=new float[w][h];
  for(int i=0;i<30;i++){
    int x=int(random(w));
    int y=int(random(h));
    float val=10;
    if(random(100)<50)valsU[x][y]=val;
    else valsV[x][y]=val;
  }
  //valsU[5][5]=1;
  //valsV[10][10]=1;
}
void draw(){
  background(0);
  for(int x=0;x<w;x++){
    for(int y=0;y<h;y++){
      fill(valsU[x][y]*255,valsV[x][y]*255,0);
      noStroke();
      rect(x*size,y*size,size,size);
    }
  }
  update();
}
void mousePressed(){
  
}
void update(){
  float[][]newU=new float[w][h];
  float[][]newV=new float[w][h];
  for(int x=0;x<w;x++){
    for(int y=0;y<h;y++){
    }
  }
  valsV=newV;
  valsU=newU;
}