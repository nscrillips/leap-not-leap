//by Nate Phillips
//April 2010

import interfascia.*;

PFont font;

int textYr = year();
int textMo = month();
int textD = day();

int cx, cx2, cy, cy2;
float secondsRadius;
float minutesRadius;
float hoursRadius;
float clockDiameter;

GUIController c;
IFTextField yText;
IFTextField mText;
IFTextField dText;

String strYr = Integer.toString(year());
String strMo = Integer.toString(month());
String strD = Integer.toString(day());
  
  float yr = year();
  float mo = month();
  float d = day();
  float hr = hour();
  float mi = minute();
  float sec = second();

void setup() {
  frameRate(30);
  size(800, 400);
  stroke(0);
  smooth();
  
  font = loadFont("Verdana-10.vlw");
  textFont(font);
  
  int radius = min(width, height) / 2;
  secondsRadius = radius * 0.72;
  minutesRadius = radius * 0.60;
  hoursRadius = radius * 0.50;
  clockDiameter = radius * 1.8;
  
  cx = width / 4;
  cy = height / 2;
  cx2 = (width / 4)+(width/2);
  
 c = new GUIController(this);
 yText = new IFTextField("Year Field", width/2+20, height-30, 50, strYr);
 mText = new IFTextField("Month Field", width/2-60, height-30, 30, strMo);
 dText = new IFTextField("Day Field", width/2-20, height-30, 30, strD);
 c.add(yText);
 c.add(mText);
 c.add(dText);
 yText.addActionListener(this);
 mText.addActionListener(this);
 dText.addActionListener(this); 

 
}

void draw() {
  background(0);
  fill(255);
  noStroke();
  ellipse(cx, cy, clockDiameter, clockDiameter);
  ellipse(cx2, cy, clockDiameter, clockDiameter);
  
  text("mm/dd/yyyy", width/2-30, height-40);
  
  clock ();
  
   // Draw minute ticks
  strokeWeight(2);
  beginShape(POINTS);
  for (int a = 0; a < 360; a+=6) {
    float x = cx + cos(radians(a)) * secondsRadius;
    float y = cy + sin(radians(a)) * secondsRadius;
    float x2 = cx2 + cos(radians(a)) * secondsRadius;
    float y2 = cy2 + sin(radians(a)) * secondsRadius;
    vertex(x, y);
    vertex(x2, y);
  }   
}

void clock(){
  
  String textYr2a = yText.getValue();
  String textMo2a = mText.getValue();
  String textD2a = dText.getValue();
  
  int textYr2;
  
  if (yText.getValue() == "" ){
    textYr2 = 2016;
  } else { 
    textYr2 = Integer.parseInt(yText.getValue());
  }
  
  //int textYr2 = Integer.parseInt(yText.getValue());
  int textMo2 = Integer.parseInt(mText.getValue()); 
  int textD2 = Integer.parseInt(dText.getValue());
  
    if(keyPressed) {
    if (key == ENTER || key == RETURN) {    
        if (textYr2 < 2016) {
       text("Invalid Date", width/2-30, height-60); 
        textYr = 2008;
  } else if (textMo2 > 12) {
        text("Invalid Date", width/2-30, height-60); 
        textMo = 12;
  } else if (textD > 31) {
    text("Invalid Date", width/2-30, height-60); 
   textD2 = 31;
  } else {
}   
      textYr = textYr2;
      textMo = textMo2;
      textD = textD2;
    }
}

  float totalDiff = (textYr-2009) + ((textMo-1.0)/12.0) + ((textD-1.0)/365.0) + (hr/8765.0) + (mi/525949.0) + (sec/3156500.0);
  float yearhalfDiff = totalDiff/1.5;
  //println(yearhalfDiff);
 
  float s = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;
  float s2 = map(second()-yearhalfDiff, 0, 60, 0, TWO_PI) - HALF_PI;
  float m = map(minute() + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI; 
  float m2 = map(minute() + norm(second()-yearhalfDiff, 0, 60), 0, 60, 0, TWO_PI) - HALF_PI; 
  float h = map(hour() + norm(minute(), 0, 60), 0, 24, 0, TWO_PI * 2) - HALF_PI;
  float h2 = map(hour() + norm(minute()-(yearhalfDiff/60), 0, 60), 0, 24, 0, TWO_PI * 2) - HALF_PI;
  
  
  // draw clock hands
  stroke(0);
  strokeWeight(1);
  line(cx, cy, cx + cos(s) * secondsRadius, cy + sin(s) * secondsRadius);
  line(cx2, cy, cx2 + cos(s2) * secondsRadius, cy + sin(s2) * secondsRadius);
  strokeWeight(2);
  line(cx, cy, cx + cos(m) * minutesRadius, cy + sin(m) * minutesRadius);
  line(cx2, cy, cx2 + cos(m2) * minutesRadius, cy + sin(m2) * minutesRadius);
  strokeWeight(4);
  line(cx, cy, cx + cos(h) * hoursRadius, cy + sin(h) * hoursRadius);
  line(cx2, cy, cx2 + cos(h2) * hoursRadius, cy + sin(h2) * hoursRadius);
}

