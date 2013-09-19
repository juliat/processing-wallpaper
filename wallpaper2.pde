int numCircles;
int radius;
int outerPadding;
int diameter;
int internalPadding;
color seedColor;
color backgroundColor;

void setup() {
  colorMode(HSB, 360, 100, 100);
  numCircles = 6;
  size(700, 700);
  outerPadding = width/10;
  int internalWidth = width - (2*outerPadding);
  diameter = internalWidth/numCircles;
  internalPadding = width/60;
  
  seedColor = color(140, 65, 75);
  
  backgroundColor = color(30, 3, 100);
  noLoop();
}

void mousePressed() {
  loop();  // Holding down the mouse activates looping
}

void mouseReleased() {
  noLoop();  // Releasing the mouse stops looping draw()
}

void draw() {
  background(backgroundColor);
  noStroke();
  int rows = numCircles;
  int cols = numCircles;
  
  for (int row = 0; row <= rows; row++) {
    for (int col = 0; col <= cols; col++) {
      drawCircle(row, col);
    }
  }
}

void drawCircle(int row, int col) {
  color circleColor = seedColor;
  float randomNum = random(0, 100);
  if (randomNum >= 0 && randomNum <= 80) {
     circleColor = similarColor(seedColor);
  } else if (randomNum > 80 && randomNum <= 95) {
     circleColor = counterClockwiseAdjacentColor(seedColor);
  } else if (randomNum > 95 && randomNum < 100) { 
     circleColor = clockwiseAdjacentColor(seedColor);
  }
  
  fill(circleColor);
  int x = outerPadding + (diameter * col);
  int y = outerPadding + (diameter * row);
  ellipse(x, y, diameter-internalPadding, diameter-internalPadding);
}

color similarColor(color seedColor) {
   // SIMILAR COLORS, SLIGHT VARIATIONS ON SEED
   // circle color is seed color, but should vary a little in brightness
   float brightDelta = ((int)random(-4, 4))*10.0;
   float hueDelta = random(-25,10);
   float satDelta = -15;
   if (hueDelta > 0) {
     satDelta = 10;
   } else {
     brightDelta += 20;
   }
   return modifyColor(seedColor, hueDelta, satDelta, brightDelta);
}

color counterClockwiseAdjacentColor(color seedColor) {
   // counterclockwise next door color and variations
   float hueDelta = ((int)random(3, 7)) * 10;
   float satDelta = -5;
   float brightDelta = 10;
   if (hueDelta > 65) {
     satDelta -= 30;
     // brightDelta += 35;
   }
   else if (hueDelta > 50) {
     satDelta +=10;
   }
   return modifyColor(seedColor, hueDelta, satDelta, brightDelta);
}

color clockwiseAdjacentColor(color seedColor) {
   // clockwise next to seed color
    float hueDelta = random(8, 11) * -10;
    float satDelta = -15;
    float brightDelta = 23;
    if (hueDelta < -90) {
      satDelta = 25;
    }
    return modifyColor(seedColor, hueDelta, satDelta, brightDelta); 
}

color modifyColor(color startColor, float hueDelta, float saturationDelta, float brightnessDelta) {
  float hue = hue(startColor);
  float newHue = hue + hueDelta;
  
  float sat = saturation(startColor);
  float newSat = sat + saturationDelta;
  
  float brightness = brightness(startColor);
  float newBrightness = brightness + brightnessDelta;
  
  return color(newHue, newSat, newBrightness);
}
