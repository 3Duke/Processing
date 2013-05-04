

float squaredDistance(float a, float b, float c, float d) {
  
  return (a-c)*(a-c) + (b-d)*(b-d);
  
}
 
 
void manageParticleType() {
  
  int particleType = control.react();
     if (particleType > -1) {
       setParticleTypeInframes( particleType );
     }
}

void manageColors() {
  
  colorWheel1.setColorOfBox(colorBox1);
     colorWheel2.setColorOfBox(colorBox2);
     
     if ( (colorWheel1.mouseInside()) || (colorWheel2.mouseInside() )) {
       
       println("Setting color tori");
       setColorTori2(colorBox1, colorBox2);
       
     }
}

void manageFrameRate() {
  
   if (speedSlider.mouseInside())  
    {
      manageFrameRate( speedSlider.read() );
      speedSlider.saveValue();
    }
    
}

void manageRadius() {
  
  if (radiusSlider.mouseInside())  
    {
      MaxRadius =  radiusSlider.read();
      radiusSlider.saveValue();
    }
}

void manageFileControl() {
  
    if (fileControlBox.mouseInside()) {
      
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
  
  if (textControlBox.mouseInside()) {
      
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
  
  if (alphaSlider.mouseInside()) {
     
     alphaSlider.read();
     alphaSlider.saveValue();
     setAlphaOfFrames(alphaSlider.value); 
    }
}

void manageMinLevel() {
  
  if (minLevelSlider.mouseInside() ) {
        
       float min = minLevelSlider.read();
       float max = maxLevelSlider.savedValue;
       
       if (max < min) 
       { 
         println("ADUSTING MAXSLIDER, max = "+nfc(max,2)+"  min = "+nfc(min,2));
         max = min;
         maxLevelSlider.setValue(min); 
         maxLevelSlider.display();
       }
       minLevelSlider.saveValue();
       
       setLevelRangeOfFrames(min, max);  
      
    }
}

void manageMaxLevel() {
  
  if (maxLevelSlider.mouseInside() ) {
        
     float max = maxLevelSlider.read();
     float min = minLevelSlider.savedValue;
     if (max < min) 
     { 
       println("ADUSTING MINSLIDER, max = "+nfc(max,2)+"  min = "+nfc(min,2));
       min = max; 
       minLevelSlider.setValue(max); 
       minLevelSlider.display();
     }
       maxLevelSlider.saveValue();
      
       
       setLevelRangeOfFrames(min, max); 
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
