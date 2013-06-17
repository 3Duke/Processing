class Controller {

  color c1, c2;
  color c1Saved, c2Saved;

  SwitchBank bankSelector;
  SelectorBox shapeSelector;
  ColorWheel colorWheel1, colorWheel2;

  Box colorBox1, colorBox2;
  Box fileControlBox, textControlBox;
  Box lightsOutBox;

  // switches
  boolean lightsAreOut;
  
  Widget test, test2, test3;

  DoubleSlider radiusSlider;
  Slider speedSlider;
  Slider alphaSlider, colorVelocitySlider; 
  DoubleSlider brightnessSlider;
  Slider numberOfParticlesSlider, particleSpacingSlider;

  DoubleSlider fooSlider;

  Controller (int numberOfControlBanks) {

    /*
    colorBox1 = new Box(20, height - 50, 30, 30, "");
    colorBox2 = new Box(20, height - 10, 30, 30, "");
    */
    int yOffset = 50;
    int xOffset = 160;
    test = new Widget(5, 680, 150, 30, "");
    test.bg = color(0);
    test2 = new Widget(5, 700, 150, 20, "");
    test2.bg = color(0);
    test3 = new Widget(5, 720, 150, 20, "");
    test3.bg = color(0);
    
    colorBox1 = new Box(20 + xOffset, height - 50 - yOffset, 30, 30, "");
    colorBox2 = new Box(20+ xOffset, height - 10 - yOffset, 30, 30, "");

    bankSelector = new SwitchBank(numberOfControlBanks);

    fileControlBox = new Box(960 + xOffset, height - 50 - yOffset, 30, 30, "F");
    textControlBox = new Box(960 + xOffset, height - 10 - yOffset, 30, 30, "T");
    fileControlBox.setRGBAColor(0, 0, 200, 255);
    textControlBox.setRGBAColor(0, 0, 200, 255);

    lightsOutBox = new Box(980 + xOffset, height - 50 - yOffset, 30, 30, "B");
    lightsAreOut = false;

    String particleLabels[] = { 
      "C", "T", "S", "Q", "*", "s", "L", "W"
    };

    shapeSelector = new SelectorBox(230 + xOffset, height - 20 - yOffset, 230, 40, particleLabels.length, particleLabels); 

    colorWheel1 = new ColorWheel(70 + xOffset, height-20 - yOffset, 60, "Color 1");  
    colorWheel1.bg = color(0);
    colorWheel2 = new ColorWheel(145 + xOffset, height-20 - yOffset, 60, "Color 2");  
    colorWheel2.bg = color(0);

    speedSlider = new Slider(480 + xOffset, height - 20 - yOffset, 200, 40, 200, "fps", "Framerate");
    radiusSlider = new DoubleSlider(720 + xOffset, height - 20 - yOffset, 200, 40, frameSet.MAXRADIUS, "r", "Radius");
    radiusSlider.setValue(frameSet.maxRadius);
    radiusSlider.setValue2(frameSet.minRadius);

    alphaSlider = new Slider(20 + xOffset, height - 25 - yOffset, 200, 40, frameSet.maxAlpha, "a", "Alpha");
    brightnessSlider = new DoubleSlider(240 + xOffset, height - 25 - yOffset, 200, 40, 1.0, "b", "Brightness");
    colorVelocitySlider = new Slider(460 + xOffset, height - 25 - yOffset, 200, 40, 1.0, "v", "Color Velocity");
    colorVelocitySlider.digits = 2;

    numberOfParticlesSlider = new Slider(20 + xOffset, height - 25 - yOffset, 200, 40, frameSet.numberOfParticles, "N", "Number of Particles");
    numberOfParticlesSlider.setValue(frameSet.numberOfActiveParticles);
    numberOfParticlesSlider.digits = 0;
    particleSpacingSlider = new Slider(240 + xOffset, height - 25 - yOffset, 200, 40, 1.0, "sf", "Particle Spacing Factor");
    particleSpacingSlider.setValue(frameSet.spacingFactor);

    fooSlider = new DoubleSlider(660 + xOffset, height - 25 - yOffset, 200, 40, 8, "foo", "Foo Factor");
    fooSlider.setValue(4);
    fooSlider.setValue2(2);

    speedSlider.setValue(frameSet.baseFrameRate);  
    radiusSlider.setValue(frameSet.INITIAL_RADIUS);

    alphaSlider.setValue(frameSet.frameAlpha);
    brightnessSlider.setValue(frameSet.maxBrightness);
    brightnessSlider.setValue2(frameSet.minBrightness);
    colorVelocitySlider.setValue(frameSet.colorVelocity);
  }

  
  String bool2string(boolean b) {
    if (b) {
      return "T";
    } else {
      return "F";
    }
  }

  void displayBank1 () {

    colorWheel1.display();
    colorWheel2.display();

    colorBox1.display(); 
    colorBox2.display();

    shapeSelector.display();

    fileControlBox.display();
    textControlBox.display();

    radiusSlider.display();
    speedSlider.display();
  }

  void displayBank2() {

    alphaSlider.display();
    alphaSlider.read();

    brightnessSlider.display();

    colorVelocitySlider.display();
    colorVelocitySlider.read();
  }

  void displayBank3() {

    numberOfParticlesSlider.display();
    particleSpacingSlider.display();
    lightsOutBox.display();

    fooSlider.display();
  }

  void displayBank(int k) 
  {
    switch(k) {
    case 0:
      displayBank1();
      break;
    case 1:
      displayBank2();
      break;
    case 2:
      displayBank3();
      break;
    default:
      println("Invalid bank selected: "+k);
      break;
    }
  }

  void display() {
    
   
    boolean a1 = sound.phaseIsActive( phase , sound.sopranoScore);
    boolean a2 = sound.phaseIsActive( phase , sound.altoScore);
    boolean a3 = sound.phaseIsActive( phase , sound.tenorScore);
    boolean a4 = sound.phaseIsActive( phase , sound.bassScore);
    
    String soprano = "-";
    String alto = "-";
    String tenor = "-";
    String bass = "-";   
    
    if (a1) {
      soprano = "S";
    }
    if (a2) {
      alto = "A";
    }
    if (a3) {
      tenor = "T";
    }
    if (a4) {
      bass = "B";
    }
      
    
    test.setText(nfc((phase % sound.scoreLength)+1) + "/" + nfc(sound.scoreLength) + " " + soprano + " " + alto + " " + tenor+ " " + bass);
    test.display();
    test2.setText(nfc(phase2)+": "+nfc(frameCount)+", "+nfc(interpreter.instructionPointer));
    test2.display();
    test3.setText(nfc(millis()/1000,1));
    test3.display();
 


    if (serialManager.switchA == 1) { 
      colorBox1.display();   
      colorBox2.display();
    }

    int b = bankSelector.activeSwitch();
    if (b > -1)
    {
      hide();
      displayBank(b);
    } 
    else {
      hide();
    }
  }

  void hide () {

    if (screenControlsOn) {
      fill(0);
      rectMode(CORNER);
      // rect(0,0, WIDTH, controlMargin);
      rect(120, HEIGHT - controlMargin + displayMargin -10, displayWidth, 200);
      float rightMargin_ = 200;
      rect(displayWidth - rightMargin_, 0, rightMargin_, displayHeight);
      rect(0, 0, 200, displayHeight-120);
      rect(0,0,displayWidth,40);
    }
   
  }

  void setColor1 ( color c)
  {
    c1 = c;
  }

  void setColor2 (color c)
  {
    c2 = c;
  }

  color readColorWheel1 ()
  {

    // read color wheel, set c1, and set color of corresponging box

    color c = colorWheel1.read();
    printColor(c, "readColorWheel(1)");
    colorBox1.setColor(c);
    colorMode(RGB, 255, 255, 255, 255); 
    return c;
  }

  color readColorWheel2 ()
  {
    // read color wheel, set c2, and set color of corresponging box

    // read color wheel, set c1, and set color of corresponging box

    color c = colorWheel2.read();
    printColor(c, "readColorWheel(2)");
    colorBox2.setColor(c);
    colorMode(RGB, 255, 255, 255, 255); 
    return c;
  }

  void updateColorBoxes() {

    colorMode(RGB, 255, 255, 255);
    colorBox1.setColor(frameSet.c1);
    colorBox2.setColor(frameSet.c2);
  }
}  // controller
