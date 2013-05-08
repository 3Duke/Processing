  

float squaredDistance(float a, float b, float c, float d) {

  return (a-c)*(a-c) + (b-d)*(b-d);
}


void manageParticleType() {

  int particleType = controller.shapeSelector.react();
  if (particleType > -1) {
    frameSet.setParticleType( particleType );
  }
}

void manageColors() {

  if (controller.colorWheel1.mouseInside()) {
    
    frameSet.c1 = controller.readColorWheel1();
    printColor(frameSet.c1, "manageColors(1)");
    frameSet.setColorTori2();
  }
  
  if (controller.colorWheel2.mouseInside()) {
    
    frameSet.c2 = controller.readColorWheel2();
    printColor(frameSet.c2, "manageColors(2)");
    frameSet.setColorTori2();
    
  }
  
}

void manageColorVelocity() {
  
  if (controller.colorVelocitySlider.mouseInside())  
  {
    frameSet.colorVelocity =  controller.colorVelocitySlider.read();
    controller.colorVelocitySlider.saveValue();
  }
}

void manageFrameRate() {

  if (controller.speedSlider.mouseInside())  
  {
    manageFrameRate( controller.speedSlider.read() );
    controller.speedSlider.saveValue();
  }
 
  
}

void manageRadius() {

  if (controller.radiusSlider.mouseInside())  
  {
    frameSet.MaxRadius =  controller.radiusSlider.read();
    controller.radiusSlider.saveValue();
  }
}

void manageFileControl() {

  if (controller.fileControlBox.mouseInside()) {

    acceptFileName = !acceptFileName;

    if (acceptFileName) {
      typedText = "";
      textSize(36);

      //  println("Accepting text");
    } 
    else {

      fileName = typedText.trim();
    }
  }
}

void manageTextInput() {

  if (controller.textControlBox.mouseInside()) {

    acceptText = !acceptText;

    if (acceptText) {
      typedText = "";
      textSize(36);

      //  println("Accepting text");
    } 
    else {

      typedText = typedText.trim();
      if (typedText != "") {
        displayString = typedText;
      }
    }
  }
}

void manageAlpha() {

  if (controller.alphaSlider.mouseInside()) {

    controller.alphaSlider.read();
    controller.alphaSlider.saveValue();
    frameSet.setAlpha(controller.alphaSlider.value);
  }
}

void manageLightsOut() {
  
  if (controller.lightsOutBox.mouseInside() ) {
    
    if (!controller.lightsAreOut) {
      
      controller.c1Saved = controller.c1;
      controller.c2Saved = controller.c2;
      
      frameSet.c1 = color(0);
      frameSet.c2 = color(0);
      
      frameSet.setColorTori2();
      
      controller.lightsAreOut = true;
      controller.lightsOutBox.bg = color(0,0,128);
      controller.lightsAreOut = true;
      
    } else {
      
      frameSet.c1 = color(128); // controller.c1Saved;
      frameSet.c2 = color(128); // controller.c2Saved;
      frameSet.setColorTori2();
      controller.lightsOutBox.bg = color(0,0,255);
      controller.lightsAreOut = false;
      
    }  

  }
  
}

void manageMinLevel() {

  if ((controller.minLevelSlider.mouseInside()) || (controller.maxLevelSlider.mouseInside()) ) {

    float min = controller.minLevelSlider.read();
    float max = controller.maxLevelSlider.savedValue;

    if (max < min) 
    { 
      max = min;
      controller.maxLevelSlider.setValue(min); 
      controller.maxLevelSlider.display();
    }
    controller.minLevelSlider.saveValue();

    frameSet.setLevelRange(min, max); 
    println("Levels reset");
  }
}

void manageMaxLevel() {

  if (controller.maxLevelSlider.mouseInside() ) {

    float max = controller.maxLevelSlider.read();
    float min = controller.minLevelSlider.savedValue;
    if (max < min) 
    { 
      min = max; 
      controller.minLevelSlider.setValue(max); 
      controller.minLevelSlider.display();
    }
    controller.maxLevelSlider.saveValue();


    frameSet.setLevelRange(min, max);
  }
}

///////////////////////////////////////////////////////

void manageNumberOfParticles() {

  if (controller.numberOfParticlesSlider.mouseInside()) {

    int n = controller.numberOfParticlesSlider.readInteger();
    controller.numberOfParticlesSlider.setValue(n);
    controller.numberOfParticlesSlider.saveValue();
   
    frameSet.numberOfActiveParticles = n;
    frameSet.setQualities();
    
  }
}


///////////////////////////////////////////////////////

void mousePressed() {

  if (controller.bankSelector.activeSwitch() == 0) 
  {  
    manageParticleType();
    manageColors();
    manageFrameRate();
    manageRadius();
    manageFileControl();
    manageTextInput();
  } 

  if (controller.bankSelector.activeSwitch() == 1)
  {
    manageAlpha();
    manageMinLevel();
    manageMaxLevel();
    manageColorVelocity();
  }
  
  if (controller.bankSelector.activeSwitch() == 2)
  {
    manageLightsOut();
    manageNumberOfParticles();
  }
  
}

void keyPressed() {

  int k = key - 49;
  
  if ((key > 32) && (key < 127)) {
    lastKey = key;
  }


  if ((k > -1) && (k < 3)) {

    controller.bankSelector.all_off();
    controller.bankSelector.on(k);
  }

  if ((key == '`')) { // toggle contrals

    controller.bankSelector.all_off();
    controller.hide();
  }

  if (key == CODED) {

    if (keyCode == SHIFT) 
    {
      println("Saved frame "+frameCount+" as "+fileName);
      saveFrame(fileName+"-######.png");
    }

    if (keyCode == ALT) 
    {
      acceptText = !acceptText;

      if (acceptText) {
        println("Display paused");
      } 
      else {
        println("Continue ...");
      }
      textSize(18);
    }
  }
}
