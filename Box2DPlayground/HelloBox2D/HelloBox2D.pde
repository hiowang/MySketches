import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
ArrayList<Box>boxes;
Box2DProcessing box2d;
void setup() {
  size(500, 500);
  box2d=new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -10);
  boxes=new ArrayList<Box>();
  boxes.add(new Box(100, 300, 100, 200, true, 0, 0, 0));
}
void draw() {
  background(255);
  box2d.step();
  for (Box b : boxes)b.display();
  //thing.display();
}