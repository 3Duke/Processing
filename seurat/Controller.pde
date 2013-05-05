class Controller {
  
  SelectorBox shapeSelector;
  ColorWheel colorWheel1, colorWheel2;
  Box colorBox1, colorBox2;
  Box fileControlBox, textControlBox;
  Slider radiusSlider, speedSlider, alphaSlider, maxLevelSlider, minLevelSlider;
  
  
  Controller () {
    
   
    colorBox1 = new Box(20, height - 45, 30, 30, "");
    colorBox2 = new Box(20, height - 5, 30, 30, "");
   
    // frameSet.setColorTori();
    
    fileControlBox = new Box(960, height - 45, 30, 30, "F");
    textControlBox = new Box(960, height - 5, 30, 30, "T");
    fileControlBox.setRGBAColor(0,0,200,255);
    textControlBox.setRGBAColor(0,0,200,255);
    
    
    String particleLabels[] = { 
      "C", "T", "Q", "L", "W"
    };
    
    shapeSelector = new SelectorBox(270, height - 20, 150, 40, particleLabels.length, particleLabels); 
    colorWheel1 = new ColorWheel(100, height - 40, 70, "Color 1");
    colorWheel2 = new ColorWheel(180, height - 40, 70, "Color 2");
   
    speedSlider = new Slider(480, height - 20, 200, 40, 100, "fps", "Framerate");
    radiusSlider = new Slider(720, height - 20, 200, 40, MAXRADIUS, "r", "Radius");
    
    alphaSlider = new Slider(20, height - 25, 200, 40, maxAlpha, "a", "Alpha");
    maxLevelSlider = new Slider(460, height - 25, 200, 40, 1.0, "max", "Maximum Level");
    minLevelSlider = new Slider(240, height - 25, 200, 40, 1.0, "min", "Minimum Level");
    
    speedSlider.setValue(baseFrameRate);  
    radiusSlider.setValue(INITIAL_RADIUS);
    alphaSlider.setValue(frameAlpha);
    maxLevelSlider.setValue(maxLevel);
    minLevelSlider.setValue(minLevel);
    
    
  }
  
  void displayBank1 () {
    
    colorWheel1.display();
    colorWheel2.display();

    colorBox1.display(); 
    colorBox2.display();
    
    fileControlBox.display();
    textControlBox.display();

    radiusSlider.display();
    speedSlider.display();

    radiusSlider.read();
    speedSlider.read();
   
}

void displayBank2() {
  
   alphaSlider.display();
   alphaSlider.read();
   
   minLevelSlider.display();
   maxLevelSlider.display();
  
}

void display() {
  

  if (switchA == 1) { colorBox1.display();   colorBox2.display();  }
  
  if (controlsActive) { displayBank1(); } 
  
  if (controlsActive2) { displayBank2(); } 
 
  if ((!controlsActive) && (!controlsActive2)) { hide(); }
  
  
}

void hide () {
  
  if (screenControlsOn) {
    fill(0);
    rectMode(CORNER);
    // rect(0,0, WIDTH, controlMargin);
    rect(0,HEIGHT - controlMargin + displayMargin -10, displayWidth, 200);
  }
}
  
 void setColor1 ()
 {
   colorWheel1.setColorOfBox(colorBox1);
 }
 
 void setColor2 ()
 {
   colorWheel2.setColorOfBox(colorBox2);
 }
  
}
