float[][]grid;
class Line{
  float cx,cy,slope;
  boolean b;
  Line(){
    cx=random(width);
    cy=random(height);
    slope=tan(random(TWO_PI));
    b=(random(100)<50);
  }
  boolean onTop(float x,float y){
    if(b)return slope*(cx-x)>cy-y;
    else return slope*(cx-x)<cy-y;
  }
}
ArrayList<Line>lines;
void setup() {
  //fullScreen();
  size(1000, 1000);
  //size(500,500);
  //pixelDensity(2);
  background(255/2);
  lines=new ArrayList<Line>();
  grid=new float[width][height];
  for(int x=0;x<width;x++){
    for(int y=0;y<height;y++){
      grid[x][y]=0.5;
    }
  }
  addLines(10);
  reevalLines();
}
void reevalLines(){
  for(int x=0;x<width;x++){
    for(int y=0;y<height;y++){
      for(Line l:lines){
        if(l.onTop(x,y))grid[x][y]+=r;
        else grid[x][y]-=r;
      }
    }
  }
  lines.clear();
}
void display(){
  //background(255,0,0);
  for(int x=0;x<width;x++){
    for(int y=0;y<height;y++){
      colorMode(HSB,100);
      set(x,y,color(grid[x][y]*100,100,100));
      colorMode(RGB,255);
    }
  }
}
  
float r=0.01;
boolean doIt=true;
void keyPressed(){
  if(key==' ')doIt=!doIt;
  if(key=='n')normalizeValues();
}
void addLines(int n){
  for(int i=0;i<n;i++){
    lines.add(new Line());
  }
}
void normalizeValues(){
  //lines.clear
  float min=100000;
  float max=-100000;
  for(int x=0;x<width;x++){
    for(int y=0;y<height;y++){
      float val=grid[x][y];
      if(val<min)min=val;
      if(val>max)max=val;
    }
  }
  println(min+" "+max);
  for(int x=0;x<width;x++){
    for(int y=0;y<height;y++){
      grid[x][y]=map(grid[x][y],min,max,0,1);
    }
  }
}
void mousePressed() {
  background(255/2);
}
void draw() {
  if(doIt){
    addLines(10);
    reevalLines();
    //normalizeValues();
  }
  display();
}