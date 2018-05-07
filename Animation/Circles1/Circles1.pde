class Circle {
  float rad;
  float amp1, amp2;
  float off1=0, off2=0;
  Circle() {
    off1=random(TWO_PI);
    off2=random(TWO_PI);
  }
  //PVector getPoint(float t, PVector center) {
  //return new PVector(rad*cos(amp*t+off1)+center.x, rad*sin(amp*t+off2)+center.y);
  //}
}

int numCircles=10;
float radMi=10, radMa=50;
float ampRange=0.01;
float ampScale=1;

float rand() {
  return ((int)random(100))/100.0;
}
float rand(float a, float b) {
  return a+rand()*(b-a);
}
boolean drawDebug=true;
boolean drawScaffolding=true;
Circle[]circles;
void setup() {
  //size(750, 750);
  //size(1000,1000);
  fullScreen();
  smooth();
  doSetup();
  background(0);
}
void doSetup() {
  circles=new Circle[numCircles];
  int f=60;
  for (int i=0; i<circles.length; i++) {
    circles[i]=new Circle();
    //circles[i].rad=(numCircles-i)*10+10;
    //circles[i].amp1=(numCircles-i)*0.001+0.001;
    //circles[i].off1=0;
    circles[i].rad=rand(radMi, radMa);
    circles[i].amp1=rand(-ampRange, ampRange)*ampScale;
    //circles[i].rad=f;
    //f-=10;
    //circles[i].amp1=0.001;
  }
  iters=0;
  points=new ArrayList<PVector>();
}
int iters;
ArrayList<PVector>points;
void draw() {
  background(0);
  noFill();
  stroke(255);
  noCursor();
  beginShape();
  //vertex(width/2,height/2);
  //for(PVector p:points){
  //  fill(255);
  //  stroke(255);
  //  //ellipse(p.x-1,p.y-1,2,2);
  //  curveVertex(p.x,p.y);
  //  //bezierVertex(p.x,p.y,0,0,0,0);
  //}
  for (int i=0; i<points.size(); i++) {
    PVector p=points.get(i);
    PVector last;
    if (i>=1)last=points.get(i-1);
    else last=p;
    PVector next;
    if (i>=points.size()-1)next=p;
    else next=points.get(i+1);
    PVector nnext;
    if (i>=points.size()-2)nnext=next;
    else nnext=points.get(i+2);
    curve(last.x, last.y, p.x, p.y, next.x, next.y, nnext.x, nnext.y);
  }
  endShape();
  for (int x=0; x<5; x++) {
    iters++;
    //if(iters%5!=0)continue;
    PVector v=new PVector(width/2, height/2);
    //v.x+=cos(0.1*iters)*100;
    //v.y+=sin(0.1*iters)*100;
    //v.x+=cos(0.01*iters)*25;
    //v.y+=sin(0.01*iters)*25;
    //v.x+=cos(0.05*iters)*10;
    //v.y+=sin(0.05*iters)*10;
    //v.x+=cos(0.005*iters)*5;
    //v.y+=sin(0.005*iters)*5;
    //beginShape();
    PVector lastV=v.copy();
    for (Circle c : circles) {
      noFill();
      stroke(150);
      //if (drawScaffolding)ellipse(v.x, v.y, c.rad*2, c.rad*2);
      lastV=v.copy();
      v.x=c.rad*cos(iters*c.amp1+c.off1)+v.x;
      v.y=c.rad*sin(iters*c.amp1+c.off1)+v.y;
      stroke(255);
      if (drawScaffolding)line(v.x, v.y, lastV.x, lastV.y);
      fill(255, 0, 0);
      stroke(255, 0, 0);
      //if (drawScaffolding) ellipse(v.x-3, v.y-3, 6, 6);
      //v.x=c.rad*cos(iters*c.amp1+c.off1)+v.x;
      //v.y=c.rad*sin(iters*c.amp2+c.off2)+v.y;
    }
    //endShape();
    if (iters%30==0)points.add(v);
    fill(0, 255, 0);
    stroke(0, 255, 0);
    if (drawScaffolding)ellipse(v.x-3, v.y-3, 6, 6);
  }
  if (drawDebug) {
    fill(255);
    stroke(255);
    textAlign(LEFT);
    text("Framerate: "+frameRate, 0, 10);
    text("Iterations: "+iters, 0, 20);
    text("Num circles: "+numCircles,0,30);
  }
}
void keyPressed() {
  if (key=='s') {
    drawScaffolding=!drawScaffolding;
  }
  if (key=='d') {
    drawDebug=!drawDebug;
  }
  if (key==' ') {
    doSetup();
  }
  if(key=='h'){
    noCursor();
  }
}