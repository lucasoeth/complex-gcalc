class Surface {
  PShape[] s = new PShape[2]; //surface [0] real and [1] is imaginary
  int      d; //dimension 
  float    xS,yS,zS; //scale
  int      roi = 0; //real 0 or imaginary 1   

  Surface(float xScale,float yScale,float zScale) {
    d = width/4;
    xS = xScale;
    yS = yScale;
    zS = zScale;
    createSurface();
  }


  void createSurface() {
    s[0] = createShape(GROUP); 
    s[1] = createShape(GROUP);

    for (float z=-d; z<d; z++) { //go from -dim to dim
      PShape cr, ci; //curve real and imaginary
      float sz, szp; //scaled z and scaled z plus one
      
      cr = createShape(GROUP);
      ci = createShape(GROUP);
      sz = map(z,-dim,dim,-zS,zS);
      szp = map(z+1,-dim,dim,-zS,zS);

      for (float x=-d; x<d; x++) {
        PShape pr, pi; //point real and imaginary
        float sx, sxp; //scaled x and scaled x plus one
        Complex[] y = new Complex[4]; //heights for the corners of the point
        color clr;  //color of the fill
        
        sx = map(x,-dim,dim,-xS,xS);
        sxp = map(x+1,-dim,dim,-xS,xS);

        //Get heights
        y[0] = getYFor(sx, sz);
        y[1] = getYFor(sxp, sz);
        y[2] = getYFor(sxp, szp);
        y[3] = getYFor(sx, szp);

        //Create real curve
        clr = getColorFor(y[0].re);
        pr = createShape();
        pr.beginShape();
        pr.fill(clr, 100);  //set fill color and opacity
        pr.stroke(clr, 100);  //set outline color and opacity
        pr.strokeWeight(1);
        if (heightIsInBox(y[0].re, y[3].re, dim)) { //Only add vertex if inside of the square
          pr.vertex(x, y[0].re, z);
          pr.vertex(x+1, y[1].re, z);
          pr.vertex(x+1, y[2].re, z+1);
          pr.vertex(x, y[3].re, z+1);
        }
        pr.endShape(CLOSE); //end the square shape
        cr.addChild(pr); //add the points to the curve (many points added up make a curve)
        
        //Create imaginary curve
        clr = getColorFor(y[0].im);
        pi = createShape();
        pi.beginShape();
        pi.fill(clr, 100);  //set fill color and opacity
        pi.stroke(clr, 100);  //set outline color and opacity
        pi.strokeWeight(1);
        if (heightIsInBox(y[0].im, y[3].im, dim)) { //Only add vertex if inside of the square
          pi.vertex(x, y[0].im, z);
          pi.vertex(x+1, y[1].im, z);
          pi.vertex(x+1, y[2].im, z+1);
          pi.vertex(x, y[3].im, z+1);
        }
        pi.endShape(CLOSE); //end the square shape
        ci.addChild(pi); //add the points to the curve (many points added up make a curve)
        
      }

      s[0].addChild(cr); //add curve to surface (many curves added up make a surface)
      s[1].addChild(ci); //add curve to surface (many curves added up make a surface)
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

  Complex getYFor(float x, float z) {
    Complex c = new Complex(x, z);
    c = c.Cos();
    return c.Scale(yS,d);
  }

  boolean heightIsInBox(float y1, float y2, int dim) {
    if (y1<dim && y1>-dim && y2<dim && y2>-dim) {
      return true;
    } else {
      return false;
    }
  }

  void draw() {
    shape(s[roi], 0, 0); //draw shape at point 0,0
  }
}
