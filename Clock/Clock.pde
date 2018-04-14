
void setup() {
  //animated=true;
  size(500, 500);
}
void draw() {
  //noStroke();
  //fill(0,5);
  //rect(0,0,width,height);
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

  strokeWeight(1);
  for(int i=0;i<60;i++){
    float ang=radians(6*i);
    if(i%5==0)stroke(100);
    else if(i%10==0)stroke(200);
    else if(i%20==0)stroke(255);
    else if(i==int(sec))stroke(255);
    else stroke(50);
    line(0,0,125*cos(ang),125*sin(ang));
  }

  noFill();
  strokeWeight(20);

  stroke(255, 0, 0);
  float milRads=map(mil, 0, 1000, 0, TWO_PI);
  arc(0, 0, 100, 100, milRads-0.25, milRads+0.25);
  strokeWeight(5);
  line(0,0,50*cos(milRads),50*sin(milRads));
  strokeWeight(20);

  stroke(255, 100, 150);
  float secRads=map(sec+mil/1000, 0, 59, 0, TWO_PI);
  arc(0, 0, 150, 150, secRads-0.5, secRads+0.5);
  strokeWeight(5);
  ellipse(0,0,150,150);
  line(0,0,75*cos(secRads),75*sin(secRads));
  strokeWeight(20);

  stroke(150, 100, 255);
  float minRads=map(min+(sec+mil/1000)/60, 0, 59, 0, TWO_PI);
  arc(0, 0, 200, 200, minRads-0.75, minRads+0.75);
  strokeWeight(5);
  ellipse(0,0,200,200);
  line(0,0,100*cos(minRads),100*sin(minRads));
  strokeWeight(20);

  stroke(150, 255, 100);
  float hourRads=map(hour+(min+(sec+mil/1000)/60)/60, 0, 24, 0, TWO_PI);
  arc(0, 0, 250, 250, hourRads-1, hourRads+1);
  strokeWeight(5);
  ellipse(0,0,250,250);
  line(0,0,125*cos(hourRads),125*sin(hourRads));
  strokeWeight(20);
  
  stroke(255,150,100);
  float dayRads=map(day+(hour+(min+(sec+mil/1000)/60)/60)/24,1,31,0,TWO_PI);
  arc(0,0,350,350,dayRads-1,dayRads+1);
  strokeWeight(5);
  ellipse(0,0,350,350);
  strokeWeight(20);
  
  stroke(150,100,255);
  float monRads=map(month+(day+(hour+(min+(sec+mil/1000)/60)/60)/24)/31,1,12,0,TWO_PI);
  arc(0,0,400,400,monRads-1,monRads+1);
  strokeWeight(5);
  ellipse(0,0,400,400);
  strokeWeight(20);
  
  stroke(100,150,255);
  float yearRads=map(year+(month+(day+(hour+(min+(sec+mil/1000)/60)/60)/24)/31)/12,2000,3000,0,TWO_PI);
  arc(0,0,450,450,yearRads-1,yearRads+1);
  strokeWeight(5);
  ellipse(0,0,450,450);
  strokeWeight(20);
}