class Polygon {
  PVector center;
  ArrayList<Line>lines=new ArrayList<Line>();
  void display(color c) {
    stroke(c);
    noFill();
    //beginShape();
    for (Line l : lines)line(l.a.x, l.a.y, l.b.x, l.b.y);
    //endShape(CLOSE);
  }
  void sortPoints() {
    int n=lines.size();
    //if(n<=4)return;
    PVector[]points=new PVector[n];
    float[]angles=new float[n];
    
    ArrayList<PVector>list=new ArrayList<PVector>();
    for(Line l:lines){
      if(!list.contains(l.a))list.add(l.a);
      if(!list.contains(l.b))list.add(l.b);
    }
    for(int i=0;i<list.size();i++){
      points[i]=list.get(i).copy().sub(center);
      angles[i]=points[i].heading();
    }
    

    for(int i=0;i<n;i++){
      for(int j=0;j<n;j++){
        if(i==j)continue;
        if(angles[i]<=angles[j]){
          angles=swap(angles,i,j);
          points=swap(points,i,j);
        }
      }
    }

    lines.clear();
    for (int i=0; i<points.length-1; i++) {
      PVector a = points[i].copy().add(center);
      PVector b = points[i+1].copy().add(center);
      lines.add(new Line(a,b));
      //lines.add(new Line(points[i].copy().add(center), points[i+1].copy().add(center)));
    }
    lines.add(new Line(points[points.length-1].copy().add(center),points[0].copy().add(center)));
  }
}
float[] swap(float[]arr,int i,int j){
  float temp=arr[i];
  arr[i]=arr[j];
  arr[j]=temp;
  return arr;
}
PVector[] swap(PVector[]arr,int i,int j){
  PVector temp=arr[i];
  arr[i]=arr[j];
  arr[j]=temp;
  return arr;
}