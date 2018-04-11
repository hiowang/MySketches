
void setup() {
  //animated=true;
  size(500, 500);
}
void draw() {
  background(0);
  float mil=System.currentTimeMillis()%1000;
  float sec=second()%60;
  float min=minute()%60;
  float hour=hour()%24;
  float day=day();
  float month=month();
  float year=year();
  fill(255);
  textAlign(LEFT, TOP);
  stroke(255);
  text("Time: "+(nf(hour(), 2, 0)+":"+nf(minute(), 2, 0)+":"+nf(second(), 2, 0)+":"+nf(System.currentTimeMillis()%1000, 3, 0)), 2, 2);
  translate(width/2, height/2);
  float n=1;
  mil*=n;
  sec*=n;
  min*=n;
  hour*=n;
  day*=n;
  month*=n;
  year*=n;

  noFill();
  strokeWeight(20);

  stroke(255, 0, 0);
  float milRads=map(mil, 0, 1000, 0, TWO_PI);
  arc(0, 0, 100, 100, milRads-0.5, milRads);

  stroke(255, 100, 150);
  float secRads=map(sec+mil/1000, 0, 59, 0, TWO_PI);
  arc(0, 0, 150, 150, secRads-1, secRads);

  stroke(150, 100, 255);
  float minRads=map(min+(sec+mil/1000)/60, 0, 59, 0, TWO_PI);
  arc(0, 0, 200, 200, minRads-1.5, minRads);

  stroke(150, 255, 100);
  float hourRads=map(hour+(min+(sec+mil/1000)/60)/60, 0, 24, 0, TWO_PI);
  arc(0, 0, 250, 250, hourRads-2, hourRads);
  
  stroke(255,150,100);
  float dayRads=map(day+(hour+(min+(sec+mil/1000)/60)/60)/24,1,31,0,TWO_PI);
  arc(0,0,300,300,dayRads-2,dayRads);
  
  stroke(150,100,255);
  float monRads=map(month+(day+(hour+(min+(sec+mil/1000)/60)/60)/24)/31,1,12,0,TWO_PI);
  arc(0,0,350,350,monRads-2,monRads);
  
  stroke(100,150,255);
  float yearRads=map(year+(month+(day+(hour+(min+(sec+mil/1000)/60)/60)/24)/31)/12,2000,3000,0,TWO_PI);
  arc(0,0,400,400,yearRads-2,yearRads);
}