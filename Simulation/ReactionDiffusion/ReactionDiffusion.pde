float[][]arrayA;
float[][]arrayB;
float Da;
float Db;
float f;
float k;
float dt;
void initParams(float _1,float _2,float _3,float _4,float _5){
  Da=_1;
  Db=_2;
  f=_3;
  k=_4;
  dt=_5;
}
void setup() {
  size(100, 100,P3D);
  initParams(1.0,0.5,0.055,0.062,1.0);
  //initParams(1.0,0.5,0.0367,0.0649,1.0);
  arrayA=new float[width][height];
  arrayB=new float[width][height];
  for (int x=0; x<width; x++) {
    for (int y=0; y<height; y++) {
      arrayA[x][y]=1;
      arrayB[x][y]=0;
    }
  }
  
}
void draw() {
  background(255);
  for (int x=0; x<width; x++) {
    for (int y=0; y<height; y++) {
      //set(x, y, color(arrayA[x][y]*255, arrayB[x][y]*255, 0));
      set(x, y, color(arrayA[x][y]*255));
    }
  }
  for (int i=0; i<5; i++)update();
}
void mouseDragged() {
  for (int x=-10; x<=10; x++) {
    for (int y=-10; y<=10; y++) {
      if (mouseButton==LEFT)setA(x+mouseX, y+mouseY, 1);
      else setB(x+mouseX, y+mouseY, 1);
    }
  }
}
void setA(int x, int y, float v) {
  if (x>=0&&y>=0&&x<width&&y<height){
    arrayA[x][y]=v;
  }
}
void setB(int x, int y, float v) {
  if (x>=0&&y>=0&&x<width&&y<height){
    arrayB[x][y]=v;
  }
}
float getArr(float[][]arr, int x, int y) {
  if (x>=0&&y>=0&&x<width&&y<height)return arr[x][y];
  return 0.0;
}
//float[][]matrix=new float[][]{ {0.05, 0.2, 0.05}, {0.2, -1.0, 0.2}, {0.05, 0.2, 0.05} };
float evalMatrix(float[][]arr, int x, int y) {
  return 0.05*getArr(arr, x-1, y-1)+0.2*getArr(arr, x, y-1)+0.05*getArr(arr, x+1, y-1)+
    0.2*getArr(arr, x-1, y)-getArr(arr, x, y)+0.2*getArr(arr, x+1, y)+
    0.05*getArr(arr, x-1, y+1)+0.2*getArr(arr, x, y+1)+0.05*getArr(arr, x+1, y+1);
}
void update() {
  float[][]newA=new float[width][height];
  float[][]newB=new float[width][height];
  for (int x=0; x<width; x++) {
    for (int y=0; y<height; y++) {
      newA[x][y]=arrayA[x][y];
      newB[x][y]=arrayB[x][y];
    }
  }
  for (int x=1; x<width-1; x++) {
    for (int y=1; y<height-1; y++) {
      //newA[x][y]=a[x][y]/2-(getA(x-1,y)+getA(x+1,y)+getA(x,y-1)+getA(x,y+1))/4;
      /*
      Δa = C_a * (a * a - b * b) + ∇·∇b
       Δb = C_b * (2 * a * b) - ∇·∇a
       */
      //u=a
      //v=b
      float laplaceA=evalMatrix(arrayA, x, y);
      float laplaceB=evalMatrix(arrayB, x, y);
      float a=arrayA[x][y];
      float b=arrayB[x][y];
      newA[x][y]=a+(Da*laplaceA-a*b*b+f*(1-a))*dt;
      newB[x][y]=b+(Db*laplaceB+a*b*b-(k+f)*b)*dt;
    }
  }
  for (int x=0; x<width; x++) {
    for (int y=0; y<height; y++) {
      if (newA[x][y]<0)newA[x][y]=0;

      if (newB[x][y]<0)newB[x][y]=0;

      if (newA[x][y]>1)newA[x][y]=1;

      if (newB[x][y]>1)newB[x][y]=1;
      arrayA[x][y]=newA[x][y];
      arrayB[x][y]=newB[x][y];
    }
  }
}