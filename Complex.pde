class Complex {
  private float re, im;

  Complex(float r, float i) {
    re = r;
    im = i;
  }

  Complex Sin(float A, float T) {
    T = TAU/T; //2pi/x=Period => x=2pi/Period
    re = A*sin(T*re)*Math.cosh(T*im/2);
    im = A*cos(T*re)*Math.sinh(T*im/3.5);
    return new Complex(re,im);
  }
  
  Complex Cos(float A, float T) {
    T = TAU/T; //2pi/x=Period => x=2pi/Period
    re = A*sin(T*re)*Math.cosh(T*im/2);
    im = -A*cos(T*re)*Math.sinh(T*im/3.5);
    return new Complex(re,im);
  }
  
}

static class Math {
  static float cosh(float num) {
    return (exp(num)+exp(-num))/2;  //(e^x+e^-x)/2
  }
  static float sinh(float num) {
    return (exp(num)-exp(-num))/2;  //(e^x-e^-x)/2
  }
}
