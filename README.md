# MySketches

All my processing sketches.

Having all of them in 1 repository is easier than having 65 different repositories.

Most of them use this syntax:

```java

void setup(){
    //do something with size,font,renderer...
    doInit();
}
void keyPressed(){
    if(key==' ')doInit();
}
void mousePressed(){
    doUpdate();
}
void doInit(){
    //initialize global variables, blahblahblah
}
void doUpdate(){
    //update simulation/object
}
void draw(){
   //display
}

```
This allows the user to control when the simulation advances and to control when the simulation restarts.
I am trying to let all sketches follow this pattern, but for some it doesn't really matter.
