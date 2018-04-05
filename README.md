# MySketches

#### I am extremely sorry if you cannot find a certain commit/change.  I cannot remember everything I have done as it often is in different sketches.

All my processing sketches.

I try to have `README.md` files in all repositories.
Email me at `mackycheese21@gmail.com` if you want a more detailed `README.md`
for any repository.

Having all of them in 1 repository is easier than having 65 different repositories.

Most of them use this structure:

```processing

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

And for things like the NoiseViz sketches where every pixel is being set per frame, I use this sort of code for the draw loop:
```processing
float density=10;
void draw(){
    for(int x=0;x<width;x+=density){
        for(int y=0;y<height;y+=density){
            color col=getColorForPos(x,y);
            if(density==1)set(x,y,col);
            else {
                fill(col);
                stroke(col);
                rect(x,y,density,density);
            }
        }
    }
}
```
