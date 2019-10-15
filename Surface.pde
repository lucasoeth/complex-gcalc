class Surface {
  PShape   s; //surface
  int      d; //dimension 
  boolean  roi = true; //real or imaginary   

  Surface(int dim) {
    d = dim;
    createSurface();
  }


  void createSurface() {
    s = createShape(GROUP);

    for (float z=-d; z<d; z++) {
      PShape c; //curve with thickness dz
      c = createShape(GROUP);

      for (float x=-d; x<d; x++) {
        PShape p; //point with thickness dz dx
        float y1, y2, y3, y4; //heights for the corners of the point
        color clr;  //color of the fill

        y1= xsqr(x, z);
        y2= xsqr(x+1, z);
        y3= xsqr(x+1, z+1);
        y4= xsqr(x, z+1);

        clr = getColorFor(y1);
        p = createShape();

        p.beginShape();
        p.fill(clr, 100);  //set fill color and opacity
        p.stroke(clr, 100);  //set outline color and opacity
        p.strokeWeight(1);

        if (y1<dim && y1>-dim && y4<dim && y4>-dim) { //Only add vertex if inside of the square
          p.vertex(x, y1, z);
          p.vertex(x+1, y2, z);
          p.vertex(x+1, y3, z+1);
          p.vertex(x, y4, z+1);
        }

        p.endShape(CLOSE); //connect last vertex with first
        c.addChild(p); //add the points to the curve (many points added up make a curve)
      }

      s.addChild(c); //add curve to surface (many curves added up make a surface)
    }
  }

  color getColorFor(float y) {
    float[][] clrPalette = {{110, 75, 155}, {75, 125, 200}, {85, 160, 175}, {110, 180, 140}, {180, 190, 75}, {225, 160, 60}, {230, 105, 45}, {190, 35, 30}, {80, 25, 20}};
    color clr;
    int r, g, b;
    float scale;

    y = min(y, dim); //y=dim if y>dim
    y = max(y, -dim); //y=-dim if y<-dim
    scale = map(y, -dim, dim, 0, 8); //0 is for lowest and 8 for highest

    if (scale<4) {
      int m = floor(scale); //make scale an int so it can be used in the array
      r = floor(map(scale, m, m+1, clrPalette[m][0], clrPalette[m+1][0]));
      g = floor(map(scale, m, m+1, clrPalette[m][1], clrPalette[m+1][1]));
      b = floor(map(scale, m, m+1, clrPalette[m][2], clrPalette[m+1][2]));
      clr = color(r, g, b);
    } else if (scale>4) {
      int m = ceil(scale); //make scale an int so it can be used in the array
      r = ceil(map(scale, m, m-1, clrPalette[m][0], clrPalette[m-1][0]));
      g = ceil(map(scale, m, m-1, clrPalette[m][1], clrPalette[m-1][1]));
      b = ceil(map(scale, m, m-1, clrPalette[m][2], clrPalette[m-1][2]));
      clr = color(r, g, b);
    } else {
      clr = color(clrPalette[4][0], clrPalette[4][1], clrPalette[4][2]);
    }

    return clr;
  }

  float xsqr(float x, float z) {
    Complex c = new Complex(x, z);
    c = c.Cos(25, dim);


    if (roi) {
      return c.re;
    } else {
      return c.im;
    }
  }

  void draw() {
    shape(s, 0, 0); //draw shape at point 0,0
  }
}
