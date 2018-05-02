class Polygon{
  ArrayList<Line>lines=new ArrayList<Line>();
  void display(color c){
    stroke(c);
    noFill();
    beginShape();
    for(Line l:lines)vertex(l.a.x,l.a.y);
    endShape(CLOSE);
  }
}