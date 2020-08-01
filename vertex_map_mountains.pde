//procedural terrain generator;

PVector orientation;
PVector velocity;
int columns;
int rows;
int scale = 20;
int w = 5000;
int h = 5000;
float flyingX = 0;
float flyingY = 0;
float flyingZ = 0;

float[][] terrain;
float steepness = 0.01;// 0.01,0.02,0.005,0.013, 100
boolean move = true;

void setup() {
  //size(1200, 900, P3D);
  fullScreen(P3D);
  noCursor();
  columns = w / scale;
  rows = h / scale;
  orientation = new PVector(PI/3, 0, 0);
  velocity = new PVector(0, 0, 0);
  terrain = new float[columns][rows];
}

void draw() {

  if (keyPressed) {
    if (key == 'w') {
      //flyingZ-=50;
      //
      orientation.x+=0.05;
      //flyingZ += 10;

      //      orientation.x+=0.05;
    } else if (key == 'd') {
      //flyingZ+=50;
      orientation.z-=0.05;
    } else if (key == 'a') {
      orientation.z+=0.05;
    } else if (key == 's') {
      orientation.x -= 0.05;
      // flyingZ -= 10;
    } else if (key == 'q') {
      orientation.x =HALF_PI;
    }
    if (key == 'k') {
      //flyingZ-=50;
      //
      flyingY+=0.05;

      //      orientation.x+=0.05;
    } else if (key == 'j') {
      //flyingZ+=50;
      flyingX-=0.05;
    } else if (key == 'l') {
      flyingX+=0.05;
    } else if (key =='i') {
      flyingY-=0.05;
    } else if (key == 'u') {
      //flyingZ+=50;
      flyingZ-=15;
    } else if (key == 'o') {
      flyingZ+=15;
    } else if (key == 'p') {
      exit();
    }
  }
  //flyingY-=0.02;
  float yoff = flyingY;
  for (int y = 0; y < rows; y++) {
    float xoff = flyingX;
    for (int x = 0; x < columns; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -1000, 2000);
      xoff += steepness;
    }

    yoff += steepness;
  }

  lights();
  background(60, 110, 255);
  text("frame rate: "+frameRate, 20, 80);
  text("altitude: " + ((flyingZ*-4.25)+250), 20, 60);
  text("wasd to look around, ijkl to move, q to reset rotation, u and o to move up and down", 20, 40);
  text("press p or esc to quit", 20, 20);
  noStroke();
  stroke(0, 200, 130);
  fill(0, 200, 130);
  translate(width / 2, height / 2 + 10);
  rotateX(orientation.x);
  rotateY(orientation.y);
  rotateZ(orientation.z);

  translate(-w / 2, -h / 2);
  //  rotateX(orientation.x);
  //rotateY(orientation.y);
  //rotateZ(orientation.z);
  for (int y = 0; y < rows - 1; y++) {
    beginShape(TRIANGLE_STRIP);

    for (int x = 0; x < columns; x++) {

      float t = terrain[x][y];
      noStroke(); 
      if (t < 30) {
        fill(255, 255, 0);
      } else if (t > 30 && t < 200) {
        fill(0, 200, 0);
      } else if (t > 200 && t < 500) {
        fill(0, 155, 0);
      } else if (t > 500 && t < 650) {
        fill(100);
      } else if (t > 650 ) {
        fill(240);
      }
      //fill(map(terrain[x][y], -1000, 2000, -122, 255));
      vertex((x * scale)+flyingX, (y * scale)+flyingY, terrain[x][y]+flyingZ);
      vertex((x * scale)+flyingX, ((y + 1) * scale)+flyingY, terrain[x][y+1]+flyingZ);
    }
    endShape();
  }
  translate(w/2, h/2, flyingZ-30);
  translate(flyingX, 0, 0);
  fill(0, 0, 255, 150);
  box(w, h, -0.5);
  fill(0);
  textSize(12);
  stroke(0);
  rotateX(-orientation.x);
  rotateY(-orientation.y);
  rotateZ(-orientation.z);
}
