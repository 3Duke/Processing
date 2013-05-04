

float squaredDistance(float a, float b, float c, float d) {
  
  return (a-c)*(a-c) + (b-d)*(b-d);
  
}
 

void mousePressed() {
 
  if (controlsActive) 
  {
    
     println("Mouse pressed");
     int particleType = control.react();
     if (particleType > -1) {
       setParticleTypeInframes( particleType );
     }
     
     colorWheel1.setColorOfBox(colorBox1);
     colorWheel2.setColorOfBox(colorBox2);
     
     if ( (colorWheel1.mouseInside()) || (colorWheel2.mouseInside() )) {
       
       println("Setting color tori");
       setColorTori2(colorBox1, colorBox2);
       
     }
     
     if (speedSlider.mouseInside())  
    {
      manageFrameRate( speedSlider.read() );
      speedSlider.saveValue();
    }
    
    if (radiusSlider.mouseInside())  
    {
      MaxRadius =  radiusSlider.read();
      radiusSlider.saveValue();
    }
    
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
   
  }  // controlsActive
  
  if (controlsActive2) {
    
    if (alphaSlider.mouseInside()) {
     
     alphaSlider.read();
     alphaSlider.saveValue();
     setAlphaOfFrames(alphaSlider.value); 
    }
    
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
}

void keyPressed() {
   
  if ((key == '1') && (!controlsActive2)) { // toggle contrals
  
    controlsActive = !controlsActive;
    
  }
  
  if ((key == '2') && (!controlsActive)) { // toggle contrals2
  
    controlsActive2 = !controlsActive2;
    
  }
  
  if (key == ENTER) {  // change color scheme 
      
      setColorTori2(colorBox1, colorBox2);
   
  }
  
  
  
  
  if (key == CODED) {
    
 
    
    if (keyCode == SHIFT) {
      
      
       println("Saved frame "+frameCount+" as "+fileName);
       saveFrame(fileName+"-######.png");
    }
    
    if (keyCode == ALT) {
      
       acceptText = !acceptText;
       
       if (acceptText) {
         println("Display paused");
       } else {
         println("Continue ...");
       }
       textSize(18); 
     
    } 
    
    if ((keyCode == COMMAND) && (key == 'f')) {
      println("cmd-f");
    }
     
    if (  keyCode == CONTROL ) {
    
     acceptText = false;
     
     if (typedText != "") {
       fileName = typedText;
        println("CONTROL, fileName set: "+fileName);
     }
     textSize(18); 
    
  
    
    }
     
   
   if ( keyCode == COMMAND  ) {
    
     acceptText = false;
     
     textSize(18); 
     if (typedText != "") { // XXXX
       displayString = typedText;
      
     } 
   }
   
    

  }

}
