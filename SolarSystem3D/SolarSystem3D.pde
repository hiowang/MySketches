ArrayList<Planet>planets;

void setup() {
  //fullScreen(P3D);
  size(1000,1000,P3D);
  planets=new ArrayList<Planet>();
  for (int i=0; i<2000; i++) {
    planets.add(new Planet(2000,100));
  }
}
ArrayList<Planet>toAdd;
ArrayList<Planet>toRem;
float s=2;
void keyPressed(){
}
float rotY=0;
//float mi=10000,ma=0;
void draw() {
  //rot+=0.01;
  if(key=='a')rotY-=0.01;
  if(key=='d')rotY+=0.01;
  background(255);
  camera(1500,-1500,1500,0,0,0,0,1,0);
  rotateY(rotY);
  toAdd=new ArrayList<Planet>();
  toRem=new ArrayList<Planet>();
  //translate(width/2, height/2);
  //scale(s);
  for (Planet p : planets) {
    p.display(s);
    p.update();
  }
  stroke(0);
  line(-1000,0,0,1000,0,0);
  line(0,-1000,0,0,1000,0);
  line(0,0,-1000,0,0,1000);
  rotateY(-rotY);
  //if (doFlow) {
  //  for (int x=-3000; x<=3000; x+=100) {
  //    for (int y=-3000; y<=3000; y+=100) {
  //      Planet custom=new Planet();
  //      custom.x=x;
  //      custom.y=y;
  //      custom.mass=1;
  //      custom.id=-1;
  //      custom.stuck=false;
  //      custom.r=-100;
  //      custom.update();
  //      float fx=custom.vx;
  //      float fy=custom.vy;
  //      float f=sqrt(sq(fx)+sq(fy));
  //      fx/=f;
  //      fy/=f;
  //      fx*=40;
  //      fy*=40;
  //      //if(f<mi)mi=f;
  //      //if(f>ma)ma=f;
  //      //fx/=f;
  //      //fy/=f;
  //      //f=map(f,0,10,0,0.5);
  //      //fx*=f;
  //      //fy*=f;
  //      stroke(0);
  //      float s=2;
  //      line(x,y,fx*s+x,fy*s+y);
  //      //for(Planet p:planets)f+=forceCalc(p,custom);
  //      //fill(f*50);
  //      //rect(x, y, 100, 100);
  //    }
  //  }
  //}
  planets.removeAll(toRem);
  planets.addAll(toAdd);
}