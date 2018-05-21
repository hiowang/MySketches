class Follower {
  PVector pos;
  color col;
  int followIndex;
  Follower(float x, float y, int index) {
    x=random(width);
    y=random(height);
    pos=new PVector(x, y);
    colorMode(HSB, 100);
    col=color(random(100), 75, 100, 10);
    colorMode(RGB, 255);
    col=color(100,10);
  }
  void update(PVector target, float speed) {
    if (PVector.dist(pos, target)<1)return;
    PVector dir=PVector.sub(target, pos);
    //dir.mult(0.01);
    dir.setMag(speed);
    pos.add(dir);
  }
  void display() {
    fill(col);
    noStroke();
    //stroke(col);
    //set(round(pos.x),round(pos.y),col);
    float r=1;
    ellipse(pos.x, pos.y, r, r);
  }
}
ArrayList<Follower>followers;
Follower a;
void setup() {
  //size(500,500);
  fullScreen();
  followers=new ArrayList<Follower>();
  a=new Follower(width/2, height/2, 499);
  for (int i=0; i<150; i++) {
    //followers.add(new Follower(0, 0, (i+1)%500));
    followers.add(new Follower(0,0,int(random(150))));
  }

  background(255);
}
void draw() {
  for (int num=0; num<100; num++) {
    float speed=0.25;
    float t=frameCount*0.05;
    //a.update(new PVector(width/2+200*cos(t),height/2+200*sin(t)),5);
    //a.update(new PVector(mouseX,mouseY),5);
    for (int i=1; i<followers.size(); i++) {
      followers.get(i).update(followers.get(i-1).pos, speed);
      followers.get(i).display();
    }
    followers.get(0).update(followers.get(followers.size()-1).pos, speed);
    followers.get(0).display();
  }
}