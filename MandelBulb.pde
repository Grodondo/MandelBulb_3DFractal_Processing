import peasy.*;

int DIM = 128;
PeasyCam cam;
ArrayList<PVector> mandelBulb = new ArrayList<PVector>();

void setup(){
  size(600, 600, P3D);
  windowMove(1200, 100);
  cam = new PeasyCam(this, 500);

  for(int i = 0; i < DIM; i++){
    for(int j = 0; j < DIM; j++){
      boolean edge = false;
      for(int k = 0; k < DIM; k++){
        
        float x = map(i, 0, DIM, -1, 1);
        float y = map(j, 0, DIM, -1, 1);
        float z = map(k, 0, DIM, -1, 1);

        PVector zeta = new PVector(0, 0, 0);

        int maxiterations = 8;
        int iteration = 0;
        int n = 8;
        while(true){

          Spherical s = spherical(zeta.x, zeta.y, zeta.z);

          float newX =  pow(s.r, n) * sin(s.theta*n) * cos(s.phi*n);
          float newY = pow(s.r, n) * sin(s.theta*n) * sin(s.phi*n);
          float newZ = pow(s.r, n) * cos(s.theta*n);

          zeta.x = newX + x;
          zeta.y = newY + y;
          zeta.z = newZ + z;

          iteration++;

          //Si la distancia del centro hacia el punto (s.r) es mayor a 2, no lo muestro
          if(s.r > 2){
            if(edge) edge = false;
            break;
          } 

          if(iteration > maxiterations){
            if(!edge){
              edge = true;
              mandelBulb.add(new PVector(x*100, y*100, z*100));
            }
            
            break;
          }
        }
        

      } 
    }
  }
}



void draw(){
  background(0);

  for(PVector v : mandelBulb){
    point(v.x, v.y, v.z);
  }
  
  stroke(255);
}

class Spherical {
  float r, theta, phi;

  Spherical(float r, float theta, float phi){
    this.r = r;
    this.theta = theta;
    this.phi = phi;
  }
}

Spherical spherical  (float x, float y, float z){
  float r = sqrt(x*x + y*y + z*z);
  float theta = atan2(sqrt(x*x + y*y), z);
  float phi = atan2(y, x);
  return new Spherical(r, theta, phi);
}
