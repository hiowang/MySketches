
void setup() {
  //animated=true;
  size(500, 500);
}
void draw() {
  background(0);
  float mil=millis()%1000;
  float sec=second()%60;
  float min=minute()%60;
  float hour=hour()%24;
  fill(255);
  textAlign(LEFT, TOP);
  stroke(255);
  text("Time: "+(nf(hour(), 2, 0)+":"+nf(minute(), 2, 0)+":"+nf(second(), 2, 0)+":"+nf(millis()%1000, 3, 0)), 2, 2);
  translate(width/2, height/2);


  noFill();
  strokeWeight(20);

  stroke(255, 0, 0);
  float milRads=map(mil, 0, 1000, 0, TWO_PI);
  arc(0, 0, 100, 100, milRads-0.5, milRads);

  stroke(255, 100, 150);
  float secRads=map(sec, 0, 60, 0, TWO_PI);
  arc(0, 0, 150, 150, secRads-1, secRads);

  stroke(150, 100, 255);
  float minRads=map(min, 0, 60, 0, TWO_PI);
  arc(0, 0, 200, 200, minRads-1.5, minRads);

  stroke(150, 255, 100);
  float hourRads=map(hour, 0, 24, 0, TWO_PI);
  arc(0, 0, 250, 250, hourRads-2, hourRads);
}