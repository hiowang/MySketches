class Polygon{
  ArrayList<Line>lines=new ArrayList<Line>();
  void display(color c){
    stroke(c);
    noFill();
    //beginShape();
    for(Line l:lines)line(l.a.x,l.a.y,l.b.x,l.b.y);
    //endShape(CLOSE);
  }
}