import processing.opengl.*;

int dim = 250;
PVector[] vecs = new PVector[dim]; //plus two becayse we need curve end and control point

 
void setup() {
  size(500,500,P3D);
  for (int i=-dim/2; i<dim/2; i++) {
    vecs[i+dim/2]= new PVector(i,20*sin(i/10),0); //x=i y=x^2 z=0 for now
  }
}
 
void draw() {
  background(0);
  translate(width/2,height/2); //makes 0,0,0 in the middle
  scale(1,-1,1); // so Y is up, which makes more sense in plotting
  //rotateY(radians(frameCount)); //rotate around y axis
  stroke(255);
  noFill();
  strokeWeight(1);
  box(dim);
  
  //for (int i=0; i<dim; i++) {
  // PVector v = vecs[i];
  // if (v.y < dim/2 && v.y > -dim/2) {
  //   stroke(255);
  //   strokeWeight(3);
  //   point(v.x,v.y,v.z);
  // }
  //}
  
  for (int i=1; i<dim-2; i++) {
    PVector vic, vi, ve, vec;
    vic = vecs[i-1];
    vi = vecs[i];
    ve = vecs[i+1];
    vec = vecs[i+2];
    
   if (vi.y < dim/2 && vi.y > -dim/2) {
     stroke(255);
     strokeWeight(3);
     curve(vic.x,vic.y, vic.z, vi.x, vi.y, vi.z, ve.x, ve.y, ve.z, vec.x, vec.y, vec.z);
   }
  }
}
