
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
  
void manageColorWheel1() {
  
    if (colorWheel1.mouseInside()) {
     
    colorMode(HSB, 360, 1, 1);
    color c1 = color(colorWheel1.angle(), colorWheel1.radius(), 1);
    
    
    println( "rodius = "+ colorWheel1.radius() + ", angle =  rrr" + colorWheel1.angle());
    colorMode(RGB, 255, 255, 255, 255);
    colorBox1.r = red(c1);
    colorBox1.g = green(c1);
    colorBox1.b = blue(c1);
    colorBox1.a = alpha(c1);
    println( red(c1)+", "+green(c1)+", "+blue(c1)+", "+alpha(c1));
    println("");
    
   } // end if
}

void manageColorWheel2() {
  
   
   if (colorWheel2.mouseInside()) {
     
    colorMode(HSB, 360, 1, 1);
    color c2 = color(colorWheel2.angle(), colorWheel2.radius(), 1);
    
    
    println( colorWheel2.radius() + ", " + colorWheel2.angle());
    colorMode(RGB, 255, 255, 255, 255);
    colorBox2.r = red(c2);
    colorBox2.g = green(c2);
    colorBox2.b = blue(c2);
    colorBox2.a = alpha(c2);
    println( red(c2)+", "+green(c2)+", "+blue(c2)+", "+alpha(c2));
    println("");
    
   } // end if
}


void mousePressed() {
 
  if (controlsActive) {
     manageControl();
     manageColorWheel1();
     manageColorWheel2();
  }
   
}



void keyPressed() {
  
  
   
  if (key == ' ') { // toggle contrals
  
    controlsActive = !controlsActive;
    
  }
  
  if (key == ENTER) {  // change color scheme 
      
      setColorTori2(colorBox1.r, colorBox1.g, colorBox1.b, colorBox2.r, colorBox2.g, colorBox2.b);
   
  }
  
  if (key == TAB) {
    
     acceptText = !acceptText;
    
    if (acceptText) {
       typedText = "";
       textSize(36);
       
       println("Accepting text");
       
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
     if (typedText != "") {
       displayString = typedText;
       println("COMMAND, displayString set: "+displayString);  
     } 
   }
    
    

  }

}
