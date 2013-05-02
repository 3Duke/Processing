
int COMMAND = 157;

float squaredDistance(float a, float b, float c, float d) {
  
  return (a-c)*(a-c) + (b-d)*(b-d);
  
}


void manageControl() {
  
     int segmentSelected = control.segmentSelected();
   println("segment selected: " + segmentSelected );
     
   if (segmentSelected  > -1) {
     control.highLightSegment(segmentSelected);
     updateFrames(segmentSelected);
   }

}

void setColoBoxl1( color c ) {
  
  
}
  
void manageColorWheel1() {
  
    if (colorWheel1.mouseInside()) {
     
      colorMode(HSB, 360, 1, 1);
      
      color c1 = color(colorWheel1.angle(), colorWheel1.radius(), 1);
      
      colorBox1.setColor(c1);
     
      colorMode(RGB, 255, 255, 255, 255);
    
   } // end if
}

void manageColorWheel2() {
  
   
   if (colorWheel2.mouseInside()) {
       
      colorMode(HSB, 360, 1, 1);
      
      color c2 = color(colorWheel2.angle(), colorWheel2.radius(), 1);
      
      colorBox2.setColor(c2);
     
      colorMode(RGB, 255, 255, 255, 255);
      
   } // end if
}


void mousePressed() {
 
  if (controlsActive) {
     manageControl();
     manageColorWheel1();
     manageColorWheel2();
  }
   
}

void manageSliders() {
  
}

void keyPressed() {
  
  
   
  if (key == ' ') { // toggle contrals
  
    controlsActive = !controlsActive;
    
  }
  
  if (key == ENTER) {  // change color scheme 
      
      setColorTori2(colorBox1, colorBox2);
   
  }
  
  if (key == TAB) {
    
     acceptText = !acceptText;
    
    if (acceptText) {
       typedText = "";
       textSize(36);
       
      //  println("Accepting text");
       
    }
     
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
       println("COMMAND, displayString set: "+displayString);  
     } 
   }
    
    

  }

}
