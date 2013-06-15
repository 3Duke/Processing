
class Responder {

  FrameSet fs;
  Controller ct;

  char lastKey;
  String typedText = "";

  XML xml;
  String foobar;
  String logString;
  String logStringArray[];

  // Switches
  boolean acceptText;
  boolean acceptFileName;

  String fileName = "frame";
  String displayString = "art";


  Responder (FrameSet fs_, Controller ct_) {

    fs = fs_; 
    ct = ct_;

    foobar = randomString(4);
    // xml = createXML("filesSaved");
    logStringArray = new String[0];

    acceptFileName = false;
    acceptText = false;
  }

  ///////////////  MANAGERS ///////////////

  void manageParticleType() {

    int particleType = ct.shapeSelector.react();
    if (particleType > -1) {
      fs.setParticleType( particleType );
    }
  }

  void manageColors() {

    println("\n\nmanageColors() ...");
    if (ct.colorWheel1.mouseInside()) {

      fs.c1 = ct.readColorWheel1();
      printColor(fs.c1, "manageColors(1)");
      fs.setColorTori2();
    }

    if (ct.colorWheel2.mouseInside()) {

      fs.c2 = ct.readColorWheel2();
      printColor(fs.c2, "manageColors(2)");
      fs.setColorTori2();
    }
  }

  void manageColorVelocity() {

    if (ct.colorVelocitySlider.mouseInside())  
    {
      fs.colorVelocity =  ct.colorVelocitySlider.read();
      ct.colorVelocitySlider.saveValue();
    }
  }

  void manageFrameRate() {

    if (ct.speedSlider.mouseInside())  
    {
      frameRate( ct.speedSlider.read() );
      ct.speedSlider.saveValue();
    }
  }

  void manageRadius() {

    if (ct.radiusSlider.mouseInside())  
    {
      ct.radiusSlider.read();
      fs.maxRadius =  ct.radiusSlider.value;
      fs.minRadius = ct.radiusSlider.value2;
    }
  }

  void manageFileControl() {

    if (ct.fileControlBox.mouseInside()) {

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



    if (ct.textControlBox.mouseInside()) {

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

    if (ct.alphaSlider.mouseInside()) {

      ct.alphaSlider.read();
      ct.alphaSlider.saveValue();
      fs.setAlpha(ct.alphaSlider.value);
    }
  }

  void manageLightsOut() {

    if (ct.lightsOutBox.mouseInside() ) {

      if (!ct.lightsAreOut) {

        ct.c1Saved = ct.c1;
        ct.c2Saved = ct.c2;

        fs.c1 = color(0);
        fs.c2 = color(0);

        fs.setColorTori2();

        ct.lightsAreOut = true;
        ct.lightsOutBox.bg = color(0, 0, 128);
        ct.lightsAreOut = true;
      } 
      else {

        fs.c1 = color(128); // ct.c1Saved;
        fs.c2 = color(128); // ct.c2Saved;
        fs.setColorTori2();
        ct.lightsOutBox.bg = color(0, 0, 255);
        ct.lightsAreOut = false;
      }
    }
  }

  void manageBrightness() {

    if (ct.brightnessSlider.mouseInside()) {

      ct.brightnessSlider.read();
      fs.setLevelRange( ct.brightnessSlider.value2, ct.brightnessSlider.value); 

      println("Levels reset");
    }
  }


  void manageNumberOfParticles() {

    if (ct.numberOfParticlesSlider.mouseInside()) {

      int n = ct.numberOfParticlesSlider.readInteger();
      ct.numberOfParticlesSlider.setValue(n);
      ct.numberOfParticlesSlider.saveValue();

      fs.numberOfActiveParticles = n;
      fs.setQualities();
    }
  }

  void manageParticleSpacing() {

    if (ct.particleSpacingSlider.mouseInside()) {

      fs.spacingFactor = ct.particleSpacingSlider.read();
      ct.particleSpacingSlider.saveValue();
      fs.setQualities();
      fs.setParticleQualities();
    }
  }


  void manageFoo() {

    if (ct.fooSlider.mouseInside()) {

      ct.fooSlider.read();
    }
  }


  void manageFrameRate(float newFrameRate) {
    // changes frame rate
    frameSet.baseFrameRate = newFrameRate;
    float currentFrameRate =   frameSet.baseFrameRate + 7*sin(TWO_PI*frameCount/20000);
    frameRate(currentFrameRate);
  }

  /////////////

  void manageKeyPress() {

    int k = key - 49;

    if ((key > 32) && (key < 127)) {
      lastKey = key;
    }


    if ((k > -1) && (k < 3)) {

      ct.bankSelector.all_off();
      ct.bankSelector.on(k);
    }

    if ((key == '`')) { // toggle contrals

      ct.bankSelector.all_off();
      ct.hide();
    }

    if (key == CODED) {

      if (keyCode == SHIFT) 
      {
        // String F = fileName+"-"+foobar+"-######.png";

        String index = nfs(frameCount, 6).trim();
        String F = fileName+"-"+foobar+"-"+index+".png";
        println("Saved file: "+F);
        fs.appendXMLOfParameters(xml, F);
        println(xml);  
        saveFrame(F);

        logString = "File: "+F+"; parameters: "+fs.stringValOfParameters()+"\n\n";
        logStringArray = append(logStringArray, logString);

        // saveStrings(foobar+"-log.txt", logStringArray);
        saveXML(xml, foobar+".xml");
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

  ///////////////  DISPATCHERS ///////////////

  void manageMousePress() {

    if (ct.bankSelector.activeSwitch() == 0) 
    {  
      manageParticleType();
      manageColors();
      manageFrameRate();
      manageRadius();
      manageFileControl();
      manageTextInput();
    } 

    if (ct.bankSelector.activeSwitch() == 1)
    {
      manageAlpha();
      manageBrightness();
      manageColorVelocity();
    }

    if (ct.bankSelector.activeSwitch() == 2)
    {
      manageNumberOfParticles();
      manageParticleSpacing();
      manageFoo();
      manageLightsOut();
    }

    if ((!acceptText) && (!acceptFileName)) {

      displayOn = true;
    } 
    else {

      displayOn = false;
    }
  }
} /// End Responder



float squaredDistance(float a, float b, float c, float d) {

  return (a-c)*(a-c) + (b-d)*(b-d);
}
