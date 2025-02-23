class Population {
  Dot[] dots;

  float fitnessSum;
  int gen = 1;

  int bestDot = 0; //indice del mejor punto

  int minStep = 1000;

  Population(int size) {
    dots = new Dot[size];
    for (int i = 0; i< size; i++) {
      dots[i] = new Dot();
    }
  }


  void show() {
    for (int i = 1; i< dots.length; i++) {
      dots[i].show();
    }
    dots[0].show();
  }

  void update() {
    for (int i = 0; i< dots.length; i++) {
      if (dots[i].brain.step > minStep) { //Si el punto ha tomado mas pasos para llegar a la meta
        dots[i].dead = true;
      } else {
        dots[i].update();
      }
    }
  }

  void calculateFitness() {
    for (int i = 0; i< dots.length; i++) {
      dots[i].calculateFitness();
    }
  }

  boolean allDotsDead() {
    for (int i = 0; i< dots.length; i++) {
      if (!dots[i].dead && !dots[i].reachedGoal) { 
        return false;
      }
    }
    return true;
  }


  void naturalSelection() {
    Dot[] newDots = new Dot[dots.length];//siguiente generación
    setBestDot();
    calculateFitnessSum();

    //El mejor no se cambia
    newDots[0] = dots[bestDot].gimmeBaby();
    newDots[0].isBest = true;
    for (int i = 1; i< newDots.length; i++) {
      //selecciona al padre dependiendo del fitness
      Dot parent = selectParent();

      //obtiene al hijo
      newDots[i] = parent.gimmeBaby();
    }

    dots = newDots.clone();
    gen ++;
  }

  void calculateFitnessSum() {
    fitnessSum = 0;
    for (int i = 0; i< dots.length; i++) {
      fitnessSum += dots[i].fitness;
    }
  }

  Dot selectParent() {
    float rand = random(fitnessSum);


    float runningSum = 0;

    for (int i = 0; i< dots.length; i++) {
      runningSum+= dots[i].fitness;
      if (runningSum > rand) {
        return dots[i];
      }
    }
    return null;
  }

  //muta el cerebro de los hijos
  void mutateDemBabies() {
    for (int i = 1; i< dots.length; i++) {
      dots[i].brain.mutate();
    }
  }

  void setBestDot() {
    float max = 0;
    int maxIndex = 0;
    for (int i = 0; i< dots.length; i++) {
      if (dots[i].fitness > max) {
        max = dots[i].fitness;
        maxIndex = i;
      }
    }
  myChart.push("incoming",dots[maxIndex].fitness );
    bestDot = maxIndex;
    //si este llega a la meta entonces se selecciona con el numero de pasos que tardo en llegar
    if (dots[bestDot].reachedGoal) {
      minStep = dots[bestDot].brain.step;
      println("step:", minStep);
    }
  }
}
