class LSystem {
  ArrayList<Rule> rules;
  String start;
  String current;
  ArrayList<DrawRule>drules;
  boolean useSpecificScale=false;
  float specificScale=0;
  LSystem() {
    rules = new ArrayList<Rule>();
    drules=new ArrayList<DrawRule>();
  }
  void init() {
    current=start;
  }
  void iterate() {
    String newStr="";
    for (char c : current.toCharArray()) {
      boolean found=false;
      for (Rule r : rules) {
        if (found)continue;
        if (r.in==c) {
          newStr+=r.out;
          found=true;
        }
      }
      if (!found)newStr+=c;
    }
    current=newStr;
    //moveDist*=0.75;
    if (useSpecificScale)moveDist*=specificScale;
    else moveDist*=0.75;
  }
  void addDrule(char c, char o) {
    DrawRule drule=new DrawRule();
    drule.in=c;
    drule.out=o;
    drules.add(drule);
  }
  void addRule(char c, String s) {
    Rule r=new Rule();
    r.in=c;
    r.out=s;
    rules.add(r);
  }
  float turnAngle;
  float moveDist;
  char turnLeft='+';
  char turnRight='-';
  char moveForward='F';
  char moveBack='B';
  char pushMat='[';
  char popMat=']';
  void display() {
    pushMatrix();
    stroke(0, 50);
    for (char c : current.toCharArray()) {
      for (DrawRule drule : drules) {
        if (drule.in==c)c=drule.out;
      }
      if (c==pushMat) {
        pushMatrix();
      }
      if (c==popMat) {
        popMatrix();
      }
      if (c==turnLeft) {
        rotate(-radians(turnAngle));
      }
      if (c==turnRight) {
        rotate(radians(turnAngle));
      }
      if (c==moveBack) {
        line(0, 0, 0, moveDist);
        translate(0, moveDist);
      }
      if (c==moveForward) {
        line(0, 0, 0, -moveDist);
        translate(0, -moveDist);
      }
    }
    popMatrix();
  }
}
class DrawRule {
  char in;
  char out;
}
class Rule {
  char in;
  String out;
}
LSystem lsys;
void setup() {
  size(500, 500);
  doInit(0);
}
void keyPressed() {
  String str="1234567890qwertyu";
  char[]chrs=str.toCharArray();
  for (int i=0; i<chrs.length; i++) {
    if (key==chrs[i]) {
      doInit(i);
      lsys.iterate();
      lsys.iterate();
      lsys.iterate();
    }
  }
  if (key==' ') {
    //addRules(curI);
    doInit(curI);
  }
  if (key=='n') {
    lsys.iterate();
  }
}
int curI=0;
void addRules(int i) {
  curI=i;
  if (i==0)addRulesHighwayDragon();
  if (i==1)addRulesLeaf1();
  if (i==2)addRulesLeaf2();
  if (i==3)addRulesWeed();
  if (i==4)addRulesFractalPlant();
  if (i==5)addRulesKochCurve();
  if (i==6)addRulesTriangleCurved();
  if (i==7)addRulesTriangleStraight();
  if (i==8)addRulesKochSnowflake();
  if (i==9)addRulesPleasantError();
  if (i==10)addRulesCarpet();
  if (i==11)addRulesSpaceFiller();
  if (i==12)addRulesMedianCurve();
  if (i==13)addRulesLace();
  if (i==14)addRulesCrossCurves();
  if (i==15)addRulesPenrose();
  if (i==16)addRulesMoore();
}
void doInit(int i) {
  lsys=new LSystem();
  addRules(i);
  lsys.init();
}
void addRulesMoore() {
  lsys.start="LFL+F+LFL";
  lsys.addDrule('L','F');
  lsys.addDrule('R','F');
  lsys.addRule('L', "−RF+LFL+FR−");
  lsys.addRule('R', "+LF−RFR−FL+");
  lsys.turnAngle=90;
  lsys.moveDist=20;
  //lsys.useSpecificScale=true;
  //lsys.specificScale=0.5;
}
void addRulesPenrose() {
  lsys.start="[7]++[7]++[7]++[7]++[7]";
  lsys.addDrule('1', 'F');
  lsys.addDrule('6', 'F');
  lsys.addDrule('7', 'F');
  lsys.addDrule('8', 'F');
  lsys.addDrule('9', 'F');
  lsys.addRule('6', "81++91----71[-81----61]++");
  lsys.addRule('7', "+81--91[---61--71]+");
  lsys.addRule('8', "-61++71[+++81++91]-");
  lsys.addRule('9', "--81++++61[+91++++71]--71");
  lsys.addRule('1', "");
  lsys.turnAngle=36;
  lsys.moveDist=30;
}
void addRulesCrossCurves() {
  lsys.start="XYXYXYX+XYXYXYX+XYXYXYX+XYXYXYX";
  lsys.addRule('F', "");
  lsys.addRule('X', "FX+FX+FXFY-FY-");
  lsys.addRule('Y', "+FX+FXFY-FY-FY");
  lsys.turnAngle=90;
  lsys.moveDist=5;
}
void addRulesLace() {
  lsys.start="W";
  lsys.addRule('W', "+++X--F--ZFX+");
  lsys.addRule('X', "---W++F++YFW-");
  lsys.addRule('Y', "+ZFX--F--Z+++");
  lsys.addRule('Z', "-YFW++F++Y---");
  lsys.turnAngle=30;
  lsys.moveDist=30;
}
void addRulesMedianCurve() {
  lsys.start="L--F--L--F";
  lsys.addDrule('L', 'F');
  lsys.addDrule('R', 'F');
  lsys.addRule('L', "+R-F-R+");
  lsys.addRule('R', "-L+F+L-");
  lsys.turnAngle=45;
  lsys.moveDist=30;
}
void addRulesSpaceFiller() {
  lsys.start="X";
  lsys.addRule('X', "-YF+XFX+FY-");
  lsys.addRule('Y', "+XF-YFY-FX+");
  lsys.turnAngle=90;
  lsys.moveDist=30;
}
void addRulesCarpet() {
  lsys.start="F";
  lsys.addDrule('G', 'F');
  lsys.addRule('F', "F+F-F-F-G+F+F+F-F");
  lsys.addRule('G', "GGG");
  lsys.turnAngle=90;
  lsys.moveDist=5;
}
void addRulesPleasantError() {
  lsys.start="F-F-F-F-F";
  lsys.addRule('F', "F-F++F+F-F-F");
  lsys.turnAngle=72;
  lsys.moveDist=5;
}
void addRulesKochSnowflake() {
  lsys.start="F++F++F";
  lsys.addRule('F', "F-F++F-F");
  //lsys.addRule('X',"FF");
  lsys.turnAngle=60;
  lsys.moveDist=10;
}
void addRulesTriangleStraight() {
  lsys.start="F-G-G";
  lsys.addDrule('G', 'F');
  lsys.addRule('F', "F-G+F+G-F");
  lsys.addRule('G', "GG");
  lsys.turnAngle=120;
  lsys.moveDist=10;
}
void addRulesTriangleCurved() {
  lsys.start="A";
  lsys.addDrule('A', 'F');
  lsys.addDrule('B', 'F');
  lsys.addRule('A', "B-A-B");
  lsys.addRule('B', "A+B+A");
  lsys.turnAngle=60;
  lsys.moveDist=10;
}
void addRulesKochCurve() {
  lsys.start="-F";
  lsys.addRule('F', "F+F-F-F+F");
  lsys.turnAngle=90;
  lsys.moveDist=1;
}
void addRulesFractalPlant() {
  lsys.start="X";
  lsys.addRule('X', "C0F-[C2[X]+C3X]+C1F[C3+FX]-X");
  lsys.addRule('F', "FF");
  lsys.turnAngle=25;
  lsys.moveDist=4;
}
void addRulesWeed() {
  lsys.start="F";
  lsys.addRule('F', "C0FF[C1-F++F][C2+F--F]C3++F--F");
  lsys.turnAngle=27;
  lsys.moveDist=1;
}
void addRulesLeaf2() {
  lsys.start="FX";
  lsys.addRule('F', "C0FF-[C1-F+F]+[C2+F-F]");
  lsys.addRule('X', "C0FF+[C1+F]+[C3-F]");
  lsys.turnAngle=25;
  lsys.moveDist=5;
}
void addRulesLeaf1() {
  lsys.start="F";
  lsys.addRule('F', "C0FF-[C1-F+F+F]+[C2+F-F-F]");
  lsys.turnAngle=22;
  lsys.moveDist=5;
}
void addRulesHighwayDragon() {
  lsys.start="FX";
  lsys.addRule('X', "X+YF+");
  lsys.addRule('Y', "-FX-Y");
  lsys.turnAngle=90;
  lsys.moveDist=80;
}
void draw() {
  background(255);
  translate(width/2, height/2);
  lsys.display();
}