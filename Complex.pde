class Complex {
  private float re, im, r, p;

  Complex(float real, float imag) {
    re = real;
    im = imag;
    r = sqrt(sq(re)+sq(im));
    p = atan2(im, re);
  }

  Complex Sin() {
    re = sin(re)*Math.cosh(im);
    im = cos(re)*Math.sinh(im);
    return new Complex(re, im);
  }

  Complex Cos() {
    re = sin(re)*Math.cosh(im);
    im = -cos(re)*Math.sinh(im);
    return new Complex(re, im);
  }

  Complex Add(Complex c) {
    re += c.re;
    im += c.im;
    return new Complex(re, im);
  };

  Complex ScalMult(float a) {
    re *= a;
    im *= a;
    return new Complex(re, im);
  }

  Complex Mult(Complex c) {
    re = re*c.re-im*c.im;
    im = re*c.im+im*c.re;
    return new Complex(re, im);
  }

  Complex Div(Complex c) {
    re = (re*c.re+im*c.im)/(sq(c.re)+sq(c.im));
    im = (im*c.re-re*c.im)/(sq(c.re)+sq(c.im));
    return new Complex(re, im);
  }

  Complex Exp(float n) {
    if (n>=1) {
      re = pow(r, n)*cos(n*p);
      im = pow(r, n)*sin(n*p);
    } else {
      re = pow(r, n)*cos((p+TAU)/(1/n));
      im = pow(r, n)*sin((p+TAU)/(1/n));
    }
    return new Complex(re, im);
  }

  Complex Scale(float scale, int dim) {
    re = map(re, -scale, scale, -dim, dim);
    im = map(im, -scale, scale, -dim, dim);
    return new Complex(re, im);
  }
}

static class Math {
  static private float p = 0.0000001; //desired precision
  static float cosh(float num) {
    return (exp(num)+exp(-num))/2;  //(e^x+e^-x)/2
  }
  static float sinh(float num) {
    return (exp(num)-exp(-num))/2;  //(e^x-e^-x)/2
  }
  static float power(float r, float n) {
    if (abs(n)>=1) {
      return pow(r, n);
    } else if (n==0) {
      return 1;
    } else {
      return Math.root(1/n, r);
    }
  }
  static float root(float n, float A) { //nth root algorithm
    if (n<0) {
      return 1/root(abs(n), A, 1);
    } else {
      return root(n, A, 1);
    }
  }

  static float root(float n, float A, float x) {
    float dx;
    dx = (1/n)*((A/Math.power(x, n-1))-x);
    if (abs(dx)<=p) {
      return x+dx;
    } else {
      return root(n, A, x+dx);
    }
  }
}
