class Complex{
  float theta,r;
  Complex(){
    theta=0;
    r=0;
  }
  Complex(float t,float r){
    theta=modAngle(t);
    this.r=r;
  }
  Complex c_copy(){
    return new Complex(theta,r);
  }
  Complex c_mult(Complex other){
    return new Complex(theta+other.theta,r*other.r);
  }
  Complex c_mult(float f){
    return new Complex(theta,r*f);
  }
  Complex c_div(Complex other){
    return new Complex(theta-other.theta,r/other.r);
  }
  Complex c_power(float f){
    return new Complex(theta*f,pow(r,f));
  }
  Complex c_tan(){
    return c_sin().c_div(c_cos());
  }
  Complex c_ln(){
    return xy(log(r),theta);
  }
  Complex c_power(Complex other){
    return new Complex(theta*other.x(),exp(-theta*other.y()));
  }
  Complex c_add(Complex other){
    return c_add(other.x(),other.y());
  }
  Complex c_add(float a,float b){
    return xy(x()+a,y()+b);
  }
  Complex c_exp(){
    //return
    float x=x();
    float y=y();
    return new Complex(y,exp(x));
    //float ea=exp(x);
    //return xy(ea*cosh(y),ea*sinh(y));
  }
  float x(){
    return r*cos(theta);
  }
  float y(){
    return r*sin(theta);
  }
  Complex c_cos(){
    float x=x();
    float y=y();
    return xy(cos(x)*cosh(y),-sin(x)*sinh(y));
  }
  
  Complex c_sin(){
    float x=x();
    float y=y();
    return xy(sin(x)*cosh(y),cos(x)*sinh(y));
  }
  
}

float cosh(float f){
  return (exp(f)+exp(-f))/2;
}

float sinh(float f){
  return (exp(f)-exp(-f))/2;
}


Complex xy(float x,float y){
  return new Complex(atan2(y,x),sqrt(sq(x)+sq(y)));
}
float modAngle(float t){
  while(t<-PI)t+=TWO_PI;
  while(t>PI)t-=TWO_PI;
  return t;
}