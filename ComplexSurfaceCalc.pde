int dim;
Surface surface;
float rotX, rotY, rotZ =0;

void setup() {
  size(500, 500, P3D);

  dim = width/4;
  surface = new Surface(dim);
}

void draw() {
  background(0);
  translate(width/2, height/2); //makes 0,0,0 in the middle
  scale(1, -1, 1); // so Y is up, which makes more sense in plotting
  rotateX(rotX);
  rotateY(rotY);
  rotateZ(rotZ);

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
  rotY += map(mouseX-pmouseX,0,width,0,PI);
  rotX += abs(cos(rotY))*map(mouseY-pmouseY,0,width,0,PI);
  rotZ += sin(rotY)*map(mouseY-pmouseY,0,width,0,PI);
}
