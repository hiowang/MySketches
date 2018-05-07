ArrayList<Planet>planets;

void setup() {
  fullScreen();
  //size(1000,1000);
  planets=new ArrayList<Planet>();
  for (int i=0; i<2000; i++) {
    planets.add(new Planet());
  }
}
ArrayList<Planet>toAdd;
ArrayList<Planet>toRem;
float s=0.1;
void mousePressed() {
  //s/=2;

  for (int i=0; i<1000; i++) {
    planets.add(new Planet());
  }
}
boolean doFlow=false;
void keyPressed(){
  if(key=='f')doFlow=!doFlow;
}
float mi=10000,ma=0;
void draw() {
  background(255);
  toAdd=new ArrayList<Planet>();
  toRem=new ArrayList<Planet>();
  translate(width/2, height/2);
  scale(s);
  for (Planet p : planets) {
    p.display();
    p.update();
  }
  if (doFlow) {
    for (int x=-3000; x<=3000; x+=100) {
      for (int y=-3000; y<=3000; y+=100) {
        Planet custom=new Planet();
        custom.x=x;
        custom.y=y;
        custom.mass=1;
        custom.id=-1;
        custom.stuck=false;
        custom.r=-100;
        custom.update();
        float fx=custom.vx;
        float fy=custom.vy;
        float f=sqrt(sq(fx)+sq(fy));
        fx/=f;
        fy/=f;
        fx*=40;
        fy*=40;
        //if(f<mi)mi=f;
        //if(f>ma)ma=f;
        //fx/=f;
        //fy/=f;
        //f=map(f,0,10,0,0.5);
        //fx*=f;
        //fy*=f;
        stroke(0);
        float s=2;
        line(x,y,fx*s+x,fy*s+y);
        //for(Planet p:planets)f+=forceCalc(p,custom);
        //fill(f*50);
        //rect(x, y, 100, 100);
      }
    }
  }
  planets.removeAll(toRem);
  planets.addAll(toAdd);
}