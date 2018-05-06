import shiffman.box2d.*;

import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2d;
ArrayList<Enemy>enemies;
Player player;

void setup(){
  size(1024,1024);
  box2d=new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0,0);
  
  player=new Player();
  enemies=new ArrayList<Enemy>();
  enemies.add(new Enemy());
  background(255);
}

boolean isA=false,isD=false,isW=false,isS=false,isSpace=false;

void keyPressed(){
  handleKeys();
}

void keyReleased(){
  handleKeys();
}

void handleKeys(){
  if(key=='a')isA=!isA;
  if(key=='d')isD=!isD;
  if(key=='w')isW=!isW;
  if(key=='s')isS=!isS;
  if(key==' ')isSpace=!isSpace;
}

void draw(){
  surface.setTitle("ShooterGame2D, frameRate="+nf(frameRate,3,2));
  println("A: "+isA+" D: "+isD+" W: "+isW+" S: "+isS+" _: "+isSpace);
  //background(255);
  fill(255,100);
  rect(-1,-1,width+2,height+2);
  box2d.step();
  player.display();
  player.update();
  for(Enemy e:enemies){
    e.display();
    e.update();
  }
}