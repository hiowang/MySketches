final PVector G=new PVector(0.f, 12000*9.8f); // external (gravitational) forces
final float REST_DENS = 1000.f; // rest density
final float GAS_CONST = 2000.f; // const for equation of state
final float H = 20.f; // kernel radius
final float HSQ = H*H; // radius^2 for optimization
final float MASS = 65.f; // assume all particles have the same mass
final float VISC = 250.f; // viscosity constant
final float DT = 0.0005f; // integration timestep

// smoothing kernels defined in Müller and their gradients
final float POLY6 = 315.f/(65.f*PI*pow(H, 9.f));
final float SPIKY_GRAD = -45.f/( PI*pow(H, 6.f));
final float VISC_LAP = 45.f/( PI*pow(H, 6.f));

// simulation parameters
final float EPS = H; // boundary epsilon
final float BOUND_DAMPING = -0.5f;
void computeDensityPressure(){
  for(Particle pi:particles){
    pi.rho=0;
    for(Particle pj:particles){
      PVector rij=PVector.sub(pj.x,pi.x);
      float r2=rij.magSq();
      if(r2<HSQ){
        pi.rho+=MASS*POLY6*pow(HSQ-r2,3);
      }
    }
    pi.p=GAS_CONST*(pi.rho-REST_DENS);
  }
}
void computeForces(){
  for(Particle pi:particles){
    PVector fpress=new PVector(0,0);
    PVector fvisc=new PVector(0,0);
    for(Particle pj:particles){
      if(pi==pj)continue;
      PVector rij=PVector.sub(pj.x,pi.x);
      float r=rij.mag();
      if(r<H){
          fpress.sub(rij.normalize().mult(MASS*(pi.p+pj.p)/(2*pj.rho)*SPIKY_GRAD*pow(H-r,2)));
        fvisc.add(PVector.sub(pj.v,pi.v).mult(VISC*MASS/pj.rho*VISC_LAP*(H-r)));
      }
    }
    PVector fgrav=PVector.mult(G,pi.rho);
    pi.f=fgrav.add(fvisc.add(fpress));
  }
}
void integrate(){
  float e=16;
  for(Particle p:particles){
    p.v.add(p.f.mult(DT/p.rho));
    p.x.add(p.v.mult(DT));
    if(p.x.x<e){
      p.v.x*=BOUND_DAMPING;
      p.x.x=e;
    }
    if(p.x.y<e){
      p.v.y*=BOUND_DAMPING;
      p.x.y=e;
    }
    if(p.x.x>width-e){
      p.v.x*=BOUND_DAMPING;
      p.x.x=width-e;
    }
    if(p.x.y>height-e){
      p.v.y*=BOUND_DAMPING;
      p.x.y=height-e;
    }
  }
}
void stepSim(){
  computeDensityPressure();
  computeForces();
  integrate();
}