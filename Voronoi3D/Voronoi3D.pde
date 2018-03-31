
void setup() {
  //size(500,500);
  fullScreen();
  for(int x=0;x<1000;x++){
    points.add(new PVector(random(width),random(height),random(5000)));
  }
}

float z=0;
float shortestDist,d;
float s=10;
void draw() {
  background(0);
  z+=10;
  for(int x=0;x<width/s;x++){
    for(int y=0;y<height/s;y++){
      PVector cur = new PVector(x*s,y*s,z);
      shortestDist = 10000;
      for(PVector p : points) {
        d=cur.dist(p);
        if(d<shortestDist)shortestDist=d;
      }
      
      fill(shortestDist);
      noStroke();
      rect(x*s,y*s,s,s);
    }
  }
  if(z>5000)z=0;
}

ArrayList<PVector> points = new ArrayList<PVector>();