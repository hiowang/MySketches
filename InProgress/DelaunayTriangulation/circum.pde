

Circle circum(Triangle t) {
  float midx=0;
  float midy=0;
  float ax=t.a.x;
  float ay=t.a.y;
  float bx=t.b.x;
  float by=t.b.y;
  float cx=t.c.x;
  float cy=t.c.y;

  float c=sq(ax)+sq(ay)-sq(bx)-sq(by);
  float d=c/(2*ay-2*by);
  float f=(-ax+bx)/(ay-by);
  float g=sq(ax)+sq(ay)-sq(cx)-sq(cy);
  float h=g/(2*ay-2*cy);
  float j=-(ax-cx)/(ay-cy);

  midx=(d-h)/(j-f);
  midy=d+f*midx;

  float dist=dist(midx, midy, t.a.x, t.a.y)*2;

  return new Circle(midx, midy, dist);
}