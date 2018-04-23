void setup() {
  size(1000, 750);
}
void draw() {
  background(255);
  //translate(width/2, 0);
  //doCollatz(wid);
  for(int x=1;x<width;x+=1)doCollatz(x);
  println(frameCount);
  //doCollatz
  //fi
}
void doCollatz(int n){
  stroke(0,4);
  noFill();
  beginShape();
  int y=0;
  curveVertex(n,0);
  while(n!=1){
    curveVertex(n,y);
    y+=10;
    n=collatz(n);
  }
  curveVertex(n,y);
  endShape();
}
boolean hsb=false;
boolean grayPerIters=false;
void keyPressed() {
  if (key=='h') {
    hsb=true;
    grayPerIters=false;
  }
  if (key=='g') {
    hsb=false;
    grayPerIters=true;
  }
  if (key=='n') {
    hsb=grayPerIters=false;
  }
}
int collatz(int n) {
  if (n%2==0)return n/2;
  return 3*n+1;
}