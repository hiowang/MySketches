size(500, 500);
background(255);
beginShape();
vertex(0, height);
double lastY=0;
float dx=10;
float fullX=40;
for (float x=0; x<width; x+=dx) {
  double realX=map(x, 0, width, 0, fullX);
  double y=0;
  for (double i=1; i<=realX; i++) {
    double term=1;
    for (double j=1; j<=i; j++)term/=j;
    y+=term;
  }
  //y++;
  lastY=y;
  //stroke(0);
  //point(x,map(y,0,2,height,0));
  curveVertex(x, map((float)y, 0, 2.718, height, 0));
  //line(x,
}
println(lastY);
vertex(width, map((float)lastY, 0, 2.718, height, 0));
endShape();