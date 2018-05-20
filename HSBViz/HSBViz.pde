void setup() {
  size(1000, 720);
}
float theX=0;
float dx=4;
float diff=5;
float angDiff=radians(360/200);
void draw() {
  theX++;

  background(255);
  float hue=map(theX, 0, 450, 0, 100)%100;
  float sat=100;
  float bright=100;
  color col;
  colorMode(HSB, 100);
  col=color(hue, sat, bright);
  for (int x=0; x<450; x+=dx) {
    float h=map(x, 0, 450, 0, 100);
    stroke(color(h, sat, bright));
    if (abs(h-hue)<diff/2)stroke(0);
    line(x, 0, x, 360);
  }

  colorMode(RGB, 255);
  float r=red(col);
  float g=green(col);
  float b=blue(col);
  for (int x=550; x<1000; x+=dx) {
    float val=map(x, 550, 1000, 0, 255);
    color colR=color(r, g, b);
    color colG=color(r, g, b);
    color colB=color(r, g, b);

    stroke(colR);
    if (abs(val-r)<diff)stroke(0);
    line(x, 10+360, x, 110+360);

    stroke(colB);
    if (abs(val-g)<diff)stroke(0);
    line(x, 130+360, x, 230+360);

    stroke(colG);
    if (abs(val-b)<diff)stroke(0);
    line(x, 250+360, x, 350+360);
  }
  colorMode(RGB, 255);
  stroke(color(255, 0, 0));
  colorMode(HSB, 100);
  beginShape();
  for (int x=0; x<450; x+=dx) {
    float val=map(x, 0, 450, 0, 100);
    float theR=red(color(val, bright, sat));
    vertex(x, map(theR, 0, 100, 470, 370));
  }
  endShape();
  colorMode(RGB, 255);
  stroke(color(0, 255, 0));
  colorMode(HSB, 100);
  beginShape();
  for (int x=0; x<450; x+=dx) {
    float val=map(x, 0, 450, 0, 100);
    float theG=green(color(val, bright, sat));
    vertex(x, map(theG, 0, 100, 590, 490));
  }
  endShape();
  colorMode(RGB, 255);
  stroke(color(0, 0, 255));
  colorMode(HSB, 100);
  beginShape();
  for (int x=0; x<450; x+=dx) {
    float val=map(x, 0, 450, 0, 100);
    float theB=blue(color(val, bright, sat));
    vertex(x, map(theB, 0, 100, 710, 610));
  }
  endShape();

  float rad=150;
  float inRad=50;
  float x=775;
  float y=180;
  for (float ang=0; ang<TWO_PI; ang+=angDiff) {
    float val=map(ang, 0, TWO_PI, 0, 100);
    strokeWeight(5);
    stroke(color(val, sat, bright));
    if (abs(val-hue)<2)stroke(0);
      line(inRad*cos(ang)+x, inRad*sin(ang)+y, rad*cos(ang)+x, rad*sin(ang)+y);
  }

  colorMode(RGB, 255);
  surface.setTitle("HSBViz, frameRate="+nf(frameRate, 2, 3));
  //in bottom right, do hsb circle
}