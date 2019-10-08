class Dot {
  PVector pos;
  PVector vel;
  PVector acc;
  Brain brain;
 
 color c ;

  boolean dead = false;
  boolean reachedGoal = false;
  boolean isBest = false;

  float fitness = 0;

  Dot() {
    brain = new Brain(numero_cromosomas);

    pos = new PVector(width/2, height- 10);
    c = color(255,213,3);//bees

    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }


  void show() {
    if (isBest) {
      fill(0, 255, 0);
      ellipse(pos.x, pos.y, 8, 8);
    } else {
      fill(c);
      ellipse(pos.x, pos.y, 4, 4);
    }
  }

  void move() {

    if (brain.directions.length > brain.step) {
      acc = brain.directions[brain.step];
      brain.step++;
    } else {
      dead = true;
    }

    vel.add(acc);
    vel.limit(5);
    pos.add(vel);
  }

  void update() {
    if (!dead && !reachedGoal) {
      move();
      if (pos.x< 2|| pos.y<2 || pos.x>width-2 || pos.y>height -2) {
        dead = true;
      } else if (dist(pos.x, pos.y, goal.x, goal.y) < 5) {
        reachedGoal = true;
      } else if (pos.x < 600 && pos.y < 310 && pos.x > 0 && pos.y > 300) {
        dead = true;
      } else if (pos.x > 200 && pos.y < 510 && pos.x > 200 && pos.y > 500) {
        dead = true;
      }
    }
  }


  void calculateFitness() {
    if (reachedGoal) {//si llegan a la meta el fitness se calcula con el numero de pasos que dieron
      fitness = 1.0/16.0 + 10000.0/(float)(brain.step * brain.step);
    } else {//si no, se calcula con que tan cerca estan de la meta
      float distanceToGoal = dist(pos.x, pos.y, goal.x, goal.y);
      fitness = 1.0/(distanceToGoal * distanceToGoal);
      
    }
  }


  Dot gimmeBaby() {
    Dot baby = new Dot();
    baby.brain = brain.clone();//los hijos tienen el mismo cerebro que sus padres
    return baby;
  }
}
