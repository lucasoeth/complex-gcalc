int dim;
Surface surface;
float rotY = 0;
float rotAngle;

void setup() {
  size(500, 500, P3D);

  dim = width/4;
  rotAngle = width/2;
  surface = new Surface(TAU, 3, 2);
}

void draw() {
  background(0);
  camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  translate(width/2, height/2); //makes 0,0,0 in the middle
  scale(1, -1, 1); // so Y is up, which makes more sense in plotting

  //rotateY(rotY);

  stroke(255);
  noFill();
  strokeWeight(1);
  box(2*dim);

  surface.draw();
}

void keyPressed() {
  if (keyCode == 32) { //KeyCode for space is 32
    if (surface.roi == 0) {
      surface.roi = 1;
    } else {
      surface.roi = 0;
    }
  }
}

void mouseDragged() {
  rotY += map(mouseX-pmouseX, 0, width, 0, PI);
  rotAngle += mouseY-pmouseY;
}
