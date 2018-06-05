void drawInterpolation() {
  float d=3;
  for (int x=0; x<width; x+=d) {
    if (x%10==0)println(x+" / "+width);
    for (int y=0; y<height; y+=d) {
      Tri tri=null;
      PVector p=new PVector(x, y);
      for (Tri t : tris)if (t.contains(p)&&!isBadTri(t))tri=t;
      if (tri!=null) {
        float w1, w2, w3, x1, x2, x3, y1, y2, y3;
        x1=tri.a.x;
        x2=tri.b.x;
        x3=tri.c.x;
        y1=tri.a.y;
        y2=tri.b.y;
        y3=tri.c.y;
        float px=p.x;
        float py=p.y;
        float bot=(y2-y3)*(x1-x3)+(x3-x2)*(y1-y3);
        w1=( (y2-y3)*(px-x3)+(x3-x2)*(py-y3) ) / bot;
        w2=( (y3-y1)*(px-x3)+(x1-x3)*(py-y3) ) / bot;
        w3=1-w1-w2;
        //color col=color(255*w1,255*w2,255*w3);

        color col1=cols.get(points.indexOf(tri.a));
        color col2=cols.get(points.indexOf(tri.b));
        color col3=cols.get(points.indexOf(tri.c));
        //col1=color(255,0,0);
        //col2=color(0,255,0);
        //col3=color(0,0,255);
        color col=color(red(col1)*w1+red(col2)*w2+red(col3)*w3, green(col1)*w1+green(col2)*w2+green(col3)*w3, blue(col1)*w1+blue(col2)*w2+blue(col3)*w3);
        fill(col);
        noStroke();
        rect(x, y, d, d);
      }
    }
  }
}