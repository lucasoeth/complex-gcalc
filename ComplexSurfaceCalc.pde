int dim;
Surface surface;

void setup() {
  size(500, 500, P3D);
  
  dim = width/4;
  surface = new Surface(dim);
}

void draw() {
  background(0);
  translate(width/2, height/2); //makes 0,0,0 in the middle
  scale(1, -1, 1); // so Y is up, which makes more sense in plotting
  rotateY(radians(90)); //rotate around y axis
  
  stroke(255);
  noFill();
  strokeWeight(1);
  box(2*dim);

  surface.draw();
}

void keyPressed() {
  if (keyCode == 32) { //KeyCode for space is 32
    surface.roi = !surface.roi; //Inverse 
    surface.createSurface();
  }
}
