Population test;
PVector goal  = new PVector(400, 50);
PImage img;
int numero_Abejas = 2000;
int limite_generaciones = 40;
int numero_Abejas_pasado;
int N_Generacion;
float mutacion,mutacion_pasado;
int limite_generaciones_pasado,numero_cromosomas_pasado;
double probabilidad_de_mutacion = .80;
int numero_cromosomas = 1000;
int Velocidad = 500;
Chart myChart;
Textlabel myTextlabelA;
Textlabel myTextlabelB;
Knob myKnobA,myKnobB;
ControlP5 cp5;
void preps()
{ 
  mutacion = 0.01;
  mutacion_pasado = mutacion;
  N_Generacion = 1;
  test = new Population(1000);
  img= loadImage("colmena.png");
  cp5 = new ControlP5(this);
  
  
   
   myChart = cp5.addChart("Grafica Fitness")
               .setPosition(650, 110)
               .setSize(130, 102)
               .setRange(0, .3)
               .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
               .setStrokeWeight(1.5)
               .setColorCaptionLabel(color(255))
               ;

  myChart.addDataSet("incoming");
  myChart.setData("incoming", new float[100]);
   
   
    cp5.addSlider("mutacion")
      .setPosition(100,10)
      .setSize(100,30)
     .setRange(0,1)
     ;
   cp5.addSlider("numero_cromosomas")
      .setPosition(100,50)
      .setSize(100,30)
      .setValue(1000)
      .setRange(10,1500)
     ;
     cp5.addSlider("limite_generaciones")
      .setPosition(100,90)
      .setSize(100,30)
     .setRange(1,50)
     ;
     cp5.addSlider("probabilidad_de_mutacion").setPosition(100,130).
     setSize(100,30).
     setRange(0,1);
     
     
      myKnobA = cp5.addKnob("Velocidad")
               .setRange(1,100)
               .setValue(50)
               .setPosition(100,180)
               .setRadius(30)
               .setDragDirection(Knob.HORIZONTAL)
               ;
  
  numero_Abejas_pasado = numero_Abejas;
  
  
    myKnobB = cp5.addKnob("numero_Abejas")
               .setRange(1,1500)
               .setValue(400)
               .setPosition(190,180)
               .setRadius(30)
               .setDragDirection(Knob.HORIZONTAL)
               ;
  
   myTextlabelA = cp5.addTextlabel("label")
                    .setText("GENERACION:")
                    .setPosition(600,50)
                    .setColorValue(0xffffff00)
                    .setFont(createFont("Console",20))
                    ;
                    
    myTextlabelB = new Textlabel(cp5,"",100,100,400,200);
    myTextlabelB.setPosition(750,50);
    myTextlabelB.setFont(createFont("Console",15));

  
}
