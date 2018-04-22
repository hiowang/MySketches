//https://en.wikipedia.org/wiki/Gift_wrapping_algorithm
ArrayList<PVector>points=new ArrayList<PVector>();
ArrayList<PVector>hull=new ArrayList<PVector>();
void setup(){
  size(500,500);
  points.add(new PVector(width/2,height/2));
}
void calcHull(){
  hull.clear();
  if(points.size()<1)return;
  PVector left=points.get(0);
  for(PVector p:points)if(p.x<left.x)left=p.copy();
  hull.add(left);
  PVector endpoint=points.get(1);
  while(!points.get(0).equals(endpoint)){
    
  }
  /*
  jarvis(S)
   // S is the set of points
   pointOnHull = leftmost point in S // which is guaranteed to be part of the CH(S)
   i = 0
   repeat
      P[i] = pointOnHull
      endpoint = S[0]      // initial endpoint for a candidate edge on the hull
      for j from 1 to |S|
         if (endpoint == pointOnHull) or (S[j] is on left of line from P[i] to endpoint)
            endpoint = S[j]   // found greater left turn, update endpoint
      i = i+1
      pointOnHull = endpoint
   until endpoint == P[0]      // wrapped around to first hull point
  */
  
}
void mousePressed(){
  points.add(new PVector(mouseX,mouseY));
}
void draw(){
  background(255);
  calcHull();
  for(PVector p:points){
    fill(0);
    noStroke();
    if(hull.contains(p))fill(0,255,0);
    ellipse(p.x,p.y,10,10);
  }
  noFill();
  stroke(255,0,0);
  beginShape();
  for(PVector p:hull){
    if(curve)curveVertex(p.x,p.y);
    else vertex(p.x,p.y);
  }
  endShape(CLOSE);
}
boolean curve=false;
void keyPressed(){
  if(key=='c')curve=!curve;
}