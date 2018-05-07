class Tree {
  ArrayList<Branch>work=new ArrayList<Branch>(), finished=new ArrayList<Branch>();
  Tree() {  
    work.add(new Branch(new PVector(0, 200, 0), new PVector(0, 0, 0), 255));
    minNum=random(3, 10);
    maxNum=random(5, 25);
    while (minNum>=maxNum) {
      minNum=random(3, 10);
      maxNum=random(5, 15);
    }
  }
  void display() {
    for (Branch b : finished)b.display();
  }
  float minNum, maxNum;
  void iterate() {
    ArrayList<Branch>newBranches=new ArrayList<Branch>();
    for (Branch b : work) {
      newBranches.addAll(b.makeNew(minNum,maxNum));
    }
    finished.addAll(work);
    work.clear();
    work.addAll(newBranches);
  }
}