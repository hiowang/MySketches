class Tree {
  ArrayList<Branch>work=new ArrayList<Branch>(), finished=new ArrayList<Branch>();
  Tree() {  
    work.add(new Branch(new PVector(0, 0, 0), new PVector(0, -200, 0), 255));
  }
  void display(){
    for(Branch b:finished)b.display();
  }
  void iterate() {
    ArrayList<Branch>newBranches=new ArrayList<Branch>();
    for (Branch b : work) {
      newBranches.addAll(b.makeNew());
    }
    finished.addAll(work);
    work.clear();
    work.addAll(newBranches);
  }
}