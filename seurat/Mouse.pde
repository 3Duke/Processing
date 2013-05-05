

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
  
  controller.setColor1();
  controller.setColor2();
     
     if ( (controller.colorWheel1.mouseInside()) || (controller.colorWheel2.mouseInside() )) {
      
       frameSet.setColorTori2(controller.colorBox1, controller.colorBox2);
       
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
      MaxRadius =  controller.radiusSlider.read();
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
      } else {
        
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
      } else {
        
        displayString = typedText.trim();
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

void mousePressed() {
 
  if (controlsActive) 
  {  
     manageParticleType();
     manageColors();
     manageFrameRate();
     manageRadius();
     manageFileControl();
     manageTextInput();
  } 
  
  if (controlsActive2) 
  {
    manageAlpha();
    manageMinLevel();
    manageMaxLevel();
  }
}

void keyPressed() {
   
  if ((key == '1') && (!controlsActive2)) { // toggle contrals
  
    controlsActive = !controlsActive;
    
  }
  
  if ((key == '2') && (!controlsActive)) { // toggle contrals2
  
    controlsActive2 = !controlsActive2;
    
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
       } else {
         println("Continue ...");
       }
       textSize(18);  
    } 
  }
}
