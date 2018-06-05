void drawOutlines(){
  for (Tri t : tris) {
    if(!isBadTri(t))triDraw(t);
  }
}