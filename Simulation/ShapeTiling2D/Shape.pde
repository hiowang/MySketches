abstract class Shape {
  abstract boolean intersects(Shape other);
  float size, x, y;
  int id;
  abstract boolean allOnScreen();
  Shape(float size, float x, float y) {
    this.size=size;
    this.x=x;
    this.y=y;
    id=shapeID;
    shapeID++;
  }
  abstract boolean containsPoint(float a, float b);
  abstract void display();
}
int shapeID=0;