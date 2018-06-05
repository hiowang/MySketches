void drawFlat() {
  for (Tri t : tris) {
    noStroke();
    color ca=img.get(int(map(t.a.x, 0, width, 0, img.width)), int(map(t.a.y, 0, height, 0, img.height)));
    color cb=img.get(int(map(t.b.x, 0, width, 0, img.width)), int(map(t.b.y, 0, height, 0, img.height)));
    color cc=img.get(int(map(t.c.x, 0, width, 0, img.width)), int(map(t.c.y, 0, height, 0, img.height)));
    color c=color(red(ca)/3+red(cb)/3+red(cc)/3, green(ca)/3+green(cb)/3+green(cc)/3, blue(ca)/3+blue(cb)/3+blue(cc)/3);
    fill(c);
    stroke(c);
    beginShape();
    vertex(t.a.x, t.a.y);
    vertex(t.b.x, t.b.y);
    vertex(t.c.x, t.c.y);
    endShape(CLOSE);
  }
}