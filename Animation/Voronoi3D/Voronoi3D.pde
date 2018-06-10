
void setup() {
  size(500,500);
  //fullScreen();
  for(int x=0;x<1000;x++){
    points.add(new PVector(random(width),random(height),random(5000)));
  }
}

float z=0;
float shortestDist,d;
float s=10;
//PShaders
void draw() {
  background(0);
  z+=2;
  for(int x=0;x<width/s;x++){
    for(int y=0;y<height/s;y++){
      PVector cur = new PVector(x*s,y*s,z);
      shortestDist = 10000;
      float secondDist=10000;
      for(PVector p : points) {
        float newd=theDist(cur,p);
        shortestDist=min(shortestDist,newd);
      }
      for(PVector p:points){
        float d=theDist(cur,p);
        if(d<secondDist&&d>shortestDist)secondDist=d;
      }
      
      colorMode(HSB,100);
      if(key=='a')fill(secondDist%100,100,100);
      else fill(shortestDist%100,100,100);
      colorMode(RGB,255);
      //if(abs(shortestDist-secondDist)<=5){
        //fill(#F5B70C);
      //}
      noStroke();
      rect(x*s,y*s,s,s);
    }
  }
  if(z>5000)z=0;
}
float theDist(PVector p1,PVector p2){
  //return abs(p1.x-p2.x)+abs(p1.y-p2.y)+abs(p1.z-p2.z);
  return p1.dist(p2);
}
ArrayList<PVector> points = new ArrayList<PVector>();