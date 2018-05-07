void setup() {
  //size(500,500);
  fullScreen();
  //size(d, 1000);
  background(230,230,250);
}
void draw() {
  fill(230, 230, 250, 50);
  noStroke();
  rect(0, 0, width, height);
  for (int i=0; i<map(width,0,500,0,2); i++)drops.add(new Drop(random(0, width), -100));
  for (Drop d : drops)d.update();
  removeExtras();
}
void removeExtras() {
  for (Drop d : drops)if (d.posy>height) {
    drops.remove(d);
    removeExtras();
    return;
  }
}
ArrayList<Drop>drops=new ArrayList<Drop>();
class Drop {
  float posx, posy;
  float vely;
  float velx;
  float len;
  float z;
  float thick;
  Drop(float posx, float posy) {
    len=random(20, 30);
    z=random(0.5, 1);
    thick=map(len, 20, 50, 0, 2);
    thick*=z;
    len*=z;
    this.posx=posx;
    this.posy=posy;
    this.vely=random(2, 8);
    vely*=z;
    velx=0;
  }
  void update() {
    //vely=map(;
    velx+=map(noise(frameCount*0.01, posx*0.01,posy*0.01),0,1,-1,1)*z*0.01;
    posx+=velx;
    posy+=vely;
    stroke(138, 43, 226);
    strokeWeight(thick);
    line(posx, posy, posx, posy+len);
  }
}