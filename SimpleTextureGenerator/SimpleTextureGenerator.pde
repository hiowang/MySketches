size(512, 512);
color dirt=#835207;
color stone=#ADADAD;
color stoneLight=#B4B4B4;
color dirtLight=#8E5909;
color grassLight=color(0,127.5,0);
color grass=color(0,120,0);
color pink=#FF52EE;

noStroke();

fill(dirt);
rect(0, 0, 512, 512);
rect(0, 0, 512, 512);
for (int x=0; x<8; x++) {
  for (int y=0; y<8; y++) {
    if((x+y)%2!=0)continue;
    fill(dirtLight);
    rect(x*64,y*64,64,64);
  }
}

fill(grass);
rect(0, 0, 512, 128);
for (int x=0; x<8; x++) {
  for (int y=0; y<2; y++) {
    if((x+y)%2!=0)continue;
    fill(grassLight);
    rect(x*64,y*64,64,64);
  }
}
save("textures/grass-side.png");

fill(grass);
rect(0, 0, 512, 512);
for (int x=0; x<8; x++) {
  for (int y=0; y<8; y++) {
    if((x+y)%2!=0)continue;
    fill(grassLight);
    rect(x*64,y*64,64,64);
  }
}
save("textures/grass-top.png");

fill(dirt);
rect(0, 0, 512, 512);
rect(0, 0, 512, 512);
for (int x=0; x<8; x++) {
  for (int y=0; y<8; y++) {
    if((x+y)%2!=0)continue;
    fill(dirtLight);
    rect(x*64,y*64,64,64);
  }
}
save("textures/dirt.png");

fill(stone);
rect(0, 0, 512, 512);
rect(0, 0, 512, 512);
for (int x=0; x<8; x++) {
  for (int y=0; y<8; y++) {
    if((x+y)%2!=0)continue;
    fill(stoneLight);
    rect(x*64,y*64,64,64);
  }
}
save("textures/stone.png");