

float squaredDistance(float a, float b, float c, float d) {
  
  return (a-c)*(a-c) + (b-d)*(b-d);
  
}
 

void mousePressed() {
 
  if (controlsActive) 
  {
     int particleType = control.react();
     setParticleTypeInframes( particleType );
     
     colorWheel1.setColorOfBox(colorBox1);
     colorWheel2.setColorOfBox(colorBox2);
  }  
}

void keyPressed() {
   
  if ((key == ' ') && (!controlsActive2)) { // toggle contrals
  
    controlsActive = !controlsActive;
    
  }
  
  if ((key == 'c') && (!controlsActive)) { // toggle contrals2
  
    controlsActive2 = !controlsActive2;
    
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
