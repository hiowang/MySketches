class Person {
  float age;
  float strength;
  float repro;
  float reproThresh=1;
  int colID;
  color col;
  int x;
  int y;
  boolean alive;
  //boolean diseased;

  void update() {
    age+=0.0011;
    repro+=0.00225;
    //strength+=random(-0.01,-0.005);
    if(!alive)return;
    //if(random(100)<1)alive=false;
    //if(diseased)if(random(100)<0.1)alive=false;
    if(age>1)alive=false;
    lastAtPos[x][y]=colID;
    int speed=5;
    int i=int(random(4));
    int dx=0;
    int dy=0;
    if (i==0)dx=-speed;
    if (i==1)dx=speed;
    if (i==2)dy=-speed;
    if (i==3)dy=speed;
    if (isLand(x+dx, y+dy)) {
      x+=dx;
      y+=dy;
    }
    for (Person other : people) {
      if(!other.alive)continue;
      if (abs(other.x-x)<10&&abs(other.y-y)<10){
        if (other.colID!=colID) {
          //println("COLLIDE");
          if (other.strength>strength) {
            alive=false;
          }
        }else{
          //if(random(100)<0.01){
            //println(frameCount);
            //alive=false;
            strength-=0.00025;
          //}
          //if(diseased){
            //if(random(100)<10)other.diseased=true;
          //}
        }
      }
    }
    if(repro>reproThresh){
      if(random(100)<10)return;
      //if(diseased)if(random(100)<50)return;
      Person p=new Person();
      p.age=0;
      p.strength=strength+random(-0.1,0.05);
      p.repro=repro*0.1;
      repro=0;
      p.reproThresh=reproThresh;
      p.colID=colID;
      p.col=col;
      p.x=x;
      p.y=y;
      p.alive=true;
      //p.diseased=diseased;
      newPeople.add(p);
    }
    //x+=random(-1,1);
    //y+=random(-1,1);
  }
}