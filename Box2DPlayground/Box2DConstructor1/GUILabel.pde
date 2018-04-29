class GUILabel extends GUIButton {
  GUILabel(float x, float y, float w, float h, String txt, float txtoffx, float txtoffy) {
    super(x, y, w, h, txt, txtoffx, txtoffy);
  }
  void keyCheck() {
  }
  void display() {
    stroke(strokeNorm);
    fill(normCol);
    rect(x, y, w, h);
    fill(textCol);
    noStroke();
    textAlign(LEFT, TOP);
    text(txt, x+txtoffx, y+txtoffy);
  }
}