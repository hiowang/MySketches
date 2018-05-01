size(512,512);
color dirt=#835207;
color stone=#ADADAD;

noStroke();
fill(255,0);
rect(0,0,512,512);
fill(255/2);
rect(0,0,512,128);
save("textures/grass-side-overlay.png");

fill(dirt);
rect(0,0,512,512);
fill(255/2);
rect(0,0,512,128);
save("textures/grass-side.png");

fill(255/2);
rect(0,0,512,512);
save("textures/grass-top.png");

fill(dirt);
rect(0,0,512,512);
save("textures/dirt.png");

fill(stone);
rect(0,0,512,512);
save("textures/stone.png");