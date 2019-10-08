
import controlP5.*;

void setup() {
  size(800, 800); 
  frameRate(Velocidad);
  preps();              
}
void draw() { 
  if(numero_Abejas !=numero_Abejas_pasado ||numero_cromosomas != numero_cromosomas_pasado  || mutacion != mutacion_pasado)
  {
    numero_Abejas_pasado = numero_Abejas;
     numero_cromosomas_pasado = numero_cromosomas;
     mutacion_pasado = mutacion;
     N_Generacion = 1;
    test = new Population(numero_Abejas*2);
  }
  frameRate(Velocidad);
  background(10);
  image(img, 360, 0); //colmena
  fill(0, 0, 0); 
  ellipse(goal.x, goal.y, 10, 10);
  
  //obstaculos
  fill(105, 61, 0);
  rect(0, 300, 600, 10);
  rect(200, 500, 600, 10);
  
  if(N_Generacion < limite_generaciones ){
  if (test.allDotsDead() ) {
    //Algoritmo genetico
    test.calculateFitness();
    test.naturalSelection();
    test.mutateDemBabies();
     N_Generacion ++;
  } else {
    test.update();
    test.show();
  }
  
 
  myTextlabelB.setText(""+N_Generacion);
  }
  else
  {
     myTextlabelB.setText("Fin");
  }
  myTextlabelB.draw(this);
  
 
}
